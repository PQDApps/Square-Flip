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

function doesFileExist( fname, path )
    local results = false
    local filePath = system.pathForFile( fname, path )
    --filePath will be 'nil' if file doesn't exist and the path is 'system.ResourceDirectory'
    if ( filePath ) then
        filePath = io.open( filePath, "r" )
    end
    if ( filePath ) then
        print( "File found: " .. fname )
        --clean up file handles
        filePath:close()
        results = true
    else
        print( "File does not exist: " .. fname )
        local saveData = 0
		local path = system.pathForFile( "highscore.json", system.DocumentsDirectory )
		local file = io.open( path, "w" )
		file:write( saveData )
		io.close( file )
		file = nil
    end
    return results
end
--check for file in 'system.DocumentsDirectory'
local results = doesFileExist( "highscore.json", system.DocumentsDirectory )

-- include the Corona "composer" module
local composer = require "composer"

-- load menu screen
composer.gotoScene( "menu" )