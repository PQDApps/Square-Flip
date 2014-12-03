-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

local ragdogLib = require "ragdogLib"
_G.ballPalette = {
	"#00ff2f",
	"#ff00c8",
	"#7b00ff",
	"#ff8f33",
}

-- include the Corona "composer" module
local composer = require "composer"

-- load menu screen
composer.gotoScene( "menu" )