-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------
--Requires and imports
local composer = require( "composer" )
local scene = composer.newScene()
local ragdogLib = require ("ragdogLib")
local widget = require( "widget" )
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
local leaderboards
local play
local restart
local continue
local gameOver
local rectangleBg
local circle
local triangleOne
local triangleTwo
local triangleThree
local triangleFour
local color = 1 --Used to keep track of the triangle color
local rando = math.random(1,4) --Random number used to color ball
local ballMove = false
local multiplier = 1
local multiplierText

--FUNCTIONS
function moveBall(event)

	--if ballMove == true then
	if circle.y > _H/2-42 then
		circle.y = math.random(-200, 0)
		circle:setLinearVelocity( 0, 0 )
		if circle.number == color then
			circle:applyLinearImpulse( 0, math.random(15,30), circle.x, circle.y )
			current = current + 1 * multiplier
			currentText.text = current
		else
			transition.to(highScore, {time = 400, x=_W/2-(_W/4), y= 50})
			transition.to(highText, {time = 400, x=_W/2-(_W/4), y= 95})
			transition.to(currentScore, {time = 400, x=_W/2+(_W/4), y= 50})
			transition.to(currentText, {time = 400, x=_W/2+(_W/4), y= 95})
			gameOver.alpha = 1
			transition.to(gameOver, {time = 700, size = 60, y = 400})			
			transition.to(rectangleBg, {time = 300, alpha = 0.8})
			--rectangleBg.alpha = .8
			transition.to(continue, {time = 400, x=_W/2})
			transition.to(leaderboards, {time = 400, x=_W/2})
			transition.to(restart, {time = 400, x=_W/2})
		end
		function updateBall( event )
			rando = math.random(1,4)
			circle.number = rando
			circle:setFillColor( ragdogLib.convertHexToRGB(_G.ballPalette[rando]) )
		end
		timer.performWithDelay( 100, updateBall ,1 )
	end
end

function continuePress ( event )
	--stuff
	return true
end

function leaderboardsPress ( event )
	--stuff
	return true
end

function restartPress( event )

	return true
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
	background:setFillColor( ragdogLib.convertHexToRGB("#242415") )

	highScore = display.newText("H I G H  S C O R E", 0, 0, "Bebas Neue", 20)
	highScore.x = _W/2-(_W/4)
	highScore.y = -120
	highScore:setFillColor(65/255, 65/255, 65/255)
	--highScore.alpha = 0

	highText = display.newText( high, 0, 0, "04B_19", 70)
	highText.x = highScore.x
	highText.y = highScore.y+45
	--highText.alpha=0

	currentScore = display.newText("S C O R E", 0, 0, "Bebas Neue", 20)
	currentScore.x = _W/2+(_W/4)
	currentScore.y = -120
	currentScore:setFillColor(65/255, 65/255, 65/255)
	--currentScore.alpha = 0

	currentText = display.newText( current, 0, 0, "04B_19", 70)
	currentText.x = _W/2
	currentText.y = 100

	continue = widget.newButton{
		label="C O N T I N U E ?",
		font="Bebas Neue",
		labelColor = { default={255}, over={128} },
		fontSize=38,
		--defaultFile="button.png",
		--overFile="button-over.png",
		width=154, 
		height=40,
		onRelease = continuePress	-- event listener function
	}	
	continue.x = -120
	continue.y = _H/2-40

	leaderboards = widget.newButton{
		label="G A M E  C E N T E R",
		font="Bebas Neue",
		labelColor = { default={255}, over={128} },
		fontSize=38,
		--defaultFile="button.png",
		--overFile="button-over.png",
		width=154, 
		height=40,
		onRelease = leaderboardsPress	-- event listener function
	}	
	leaderboards.x = -120
	leaderboards.y = _H/2

	restart = widget.newButton{
		label="R E S T A R T",
		font="Bebas Neue",
		labelColor = { default={255}, over={128} },
		fontSize=38,
		--defaultFile="button.png",
		--overFile="button-over.png",
		width=154, 
		height=40,
		onRelease = restartPress	-- event listener function
	}	
	restart.x = -120
	restart.y = _H/2+40

	gameOver = display.newText("G A M E  O V E R", 0, 0, "Bebas Neue", 80)
	gameOver.x = _W/2
	gameOver.y = _H/2
	gameOver:setFillColor( 1,0,0 )
	gameOver.alpha = 0

	rectangleBg = display.newRect( 0, 0, _W, _H )
	rectangleBg.x = _W/2
	rectangleBg.y = _H/2
	rectangleBg:setFillColor( ragdogLib.convertHexToRGB("#000000") )
	rectangleBg.alpha = 0
	
	triangleOne = display.newImageRect(  "images/triangle.png", 130, 65 )
	triangleOne.x = _W/2
	triangleOne.y = _H/2
	triangleOne:setFillColor( ragdogLib.convertHexToRGB(_G.ballPalette[1]) )

	triangleTwo = display.newImageRect(  "images/triangle.png", 130, 65 )
	triangleTwo.rotation = -90
	triangleTwo.x = triangleOne.x-42
	triangleTwo.y = triangleOne.y+42
	triangleTwo:setFillColor( ragdogLib.convertHexToRGB(_G.ballPalette[2]) )

	triangleThree = display.newImageRect(  "images/triangle.png", 130, 65 )
	triangleThree.rotation = 180
	triangleThree.x = triangleTwo.x+42
	triangleThree.y = triangleTwo.y+42
	triangleThree:setFillColor( ragdogLib.convertHexToRGB(_G.ballPalette[3]) )

	triangleFour = display.newImageRect(  "images/triangle.png", 130, 65 )
	triangleFour.rotation = 90
	triangleFour.x = triangleThree.x+42
	triangleFour.y = triangleThree.y-42
	triangleFour:setFillColor( ragdogLib.convertHexToRGB(_G.ballPalette[4]) )

	circle = display.newImageRect(  "images/circle.png", 20, 20 )
	circle.x = _W/2
	circle.y = 50
	circle:setFillColor( ragdogLib.convertHexToRGB(_G.ballPalette[rando]) )
	physics.addBody( circle, {radius=10,density=10, friction=1, bounce=1, isSensor = true } )
	circle.number = rando

	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( circle )
	sceneGroup:insert( triangleOne )
	sceneGroup:insert( triangleTwo )
	sceneGroup:insert( triangleThree )
	sceneGroup:insert( triangleFour )
	sceneGroup:insert( rectangleBg )
	sceneGroup:insert( highScore )
	sceneGroup:insert( highText )
	sceneGroup:insert( currentScore )
	sceneGroup:insert( currentText )
	sceneGroup:insert( continue )
	sceneGroup:insert( leaderboards )
	sceneGroup:insert( restart )
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
		circle:applyLinearImpulse( 0, math.random(5,20), circle.x, circle.y )
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

	-- 	-- Called prior to the removal of scene's "view" (sceneGroup)

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