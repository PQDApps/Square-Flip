-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------
--Requires and imports
local composer = require( "composer" )
local scene = composer.newScene()
local ragdogLib = require ("ragdogLib")
local physics = require( "physics" )
physics.start( )
physics.setGravity( 0, 0 )
--physics.setDrawMode( "hybrid" )

--Variables to help place display objects
local _W = display.contentWidth
local _H = display.contentHeight

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5
local background
local highScore
local highText
local high = 0
local current = 0
local highText
local currentScore
local currentText
local circle
local color = 1 --Used to keep track of the triangle color
local rando = math.random(1,4) --Random number used to color ball
local ballMove = false

--FUNCTIONS
function moveBall(event)

	--if ballMove == true then
	if circle.y > _H/2-42 then
		circle.y = math.random(-100, 0)
		if circle.number == color then
			current = current + 1
			currentText.text = current
		end
		function updateScore( event )
			rando = math.random(1,4)
			circle.number = rando
			circle:setFillColor( ragdogLib.convertHexToRGB(_G.ballPalette[rando]) )
		end
		timer.performWithDelay( 100, updateScore ,1 )
	end
end

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	local sceneGroup = self.view

	background = display.newRect( 0, 0, _W, _H )
	background.x = _W/2
	background.y = _H/2
	background:setFillColor( 0.2, 0.5, 1 )

	highScore = display.newText("High Score", 0, 0, native.systemFont, 20)
	highScore.x = _W/2-(_W/4)
	highScore.y = 50

	highText = display.newText( high, 0, 0, native.systemFont, 20)
	highText.x = highScore.x
	highText.y = highScore.y+30

	currentScore = display.newText("Score", 0, 0, native.systemFont, 20)
	currentScore.x = _W/2+(_W/4)
	currentScore.y = 50

	currentText = display.newText( current, 0, 0, native.systemFont, 20)
	currentText.x = currentScore.x
	currentText.y = currentScore.y+30
	
	triangleOne = display.newImageRect(  "images/triangle.png", 130, 65 )
	triangleOne.x = _W/2
	triangleOne.y = _H/2-42
	triangleOne:setFillColor( ragdogLib.convertHexToRGB(_G.ballPalette[1]) )

	triangleTwo = display.newImageRect(  "images/triangle.png", 130, 65 )
	triangleTwo.rotation = -90
	triangleTwo.x = _W/2-42
	triangleTwo.y = _H/2
	triangleTwo:setFillColor( ragdogLib.convertHexToRGB(_G.ballPalette[2]) )

	triangleThree = display.newImageRect(  "images/triangle.png", 130, 65 )
	triangleThree.rotation = 180
	triangleThree.x = _W/2
	triangleThree.y = _H/2+42
	triangleThree:setFillColor( ragdogLib.convertHexToRGB(_G.ballPalette[3]) )

	triangleFour = display.newImageRect(  "images/triangle.png", 130, 65 )
	triangleFour.rotation = 90
	triangleFour.x = _W/2+42
	triangleFour.y = _H/2
	triangleFour:setFillColor( ragdogLib.convertHexToRGB(_G.ballPalette[4]) )

	circle = display.newCircle( 0, 0, 10 )
	circle.x = _W/2
	circle.y = 50
	circle:setFillColor( ragdogLib.convertHexToRGB(_G.ballPalette[rando]) )
	physics.addBody( circle, {radius=10,density=1, friction=1, bounce=1, isSensor = true } )
	circle.number = rando

	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( highScore )
	sceneGroup:insert( highText )
	sceneGroup:insert( currentScore )
	sceneGroup:insert( currentText )
	sceneGroup:insert( circle )
	sceneGroup:insert( triangleOne )
	sceneGroup:insert( triangleTwo )
	sceneGroup:insert( triangleThree )
	sceneGroup:insert( triangleFour )
end


--Rotate the square 90 degrees
local flippable = true
local function flipSquare(event)
	if event.phase == 'ended' then
		if flippable == true then
			flippable = false
			transition.to( triangleFour, { time=100, x=triangleThree.x, y=triangleThree.y, rotation=triangleThree.rotation, transition=easing.inOutCubic } )
			transition.to( triangleThree, { time=100, x=triangleTwo.x, y=triangleTwo.y, rotation=triangleTwo.rotation, transition=easing.inOutCubic } )
			transition.to( triangleTwo, { time=100, x=triangleOne.x, y=triangleOne.y, rotation=triangleOne.rotation, transition=easing.inOutCubic } )
			transition.to( triangleOne, { time=100, x=triangleFour.x, y=triangleFour.y, rotation=triangleFour.rotation, transition=easing.inOutCubic } )
			if color < 4 then
			color = color + 1
			elseif color == 4 then
			color = 1
			end
			function allowClick( event )
				flippable = true
			end
			timer.performWithDelay( 101, allowClick ,1 )
		end
		print( color )
		print( circle.number )
	end
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		background:addEventListener("touch", flipSquare)
		circle:applyLinearImpulse( 0, 1, circle.x, circle.y )
		Runtime:addEventListener("enterFrame", moveBall)
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene