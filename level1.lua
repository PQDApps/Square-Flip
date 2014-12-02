-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
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
local square
local circle

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	local sceneGroup = self.view

	background = display.newRect( 0, 0, _W, _H )
	background.x = _W/2
	background.y = _H/2
	background:setFillColor( 0.5, 0.5, 1 )

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
	
	square = display.newRect( 0, 0, 130, 130 )
	square.x = _W/2
	square.y = _H/2+25

	circle = display.newCircle( 0, 0, 10 )
	circle.x = _W/2
	circle.y = 50
	-- all display objects must be inserted into group
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
		physics.start()
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
		physics.stop()
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