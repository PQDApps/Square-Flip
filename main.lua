-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

local ragdogLib = require "ragdogLib"
_G.ballPalette = {
	"#5CC8FF",
	"#FF220C",
	"#4DFF4D",
	"#F6F930",
}

-- include the Corona "composer" module
local composer = require "composer"

-- load menu screen
composer.gotoScene( "menu" )