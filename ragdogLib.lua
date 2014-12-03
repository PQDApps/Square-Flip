------------------------------------------------------------------------
---This library contains a few functions that we're gonna use in several 
---parts of this template.
---We use various functions throughout our games and apps to speed up
---the most common practices. 
---Each template only contains a handful of these (the one useful to it)
---but we're planning on a release that will contain all our functions
---revised and polished up.
---Made by Ragdog Studios SRL in 2013 http://www.ragdogstudios.com
------------------------------------------------------------------------

local ragdogLib = {};

ragdogLib.convertRGB = function(r, g, b)
   assert(r and g and b and r <= 255 and r >= 0 and g <= 255 and g >= 0 and b <= 255 and b >= 0, "You must pass all 3 RGB values within a range of 0-255");
   return r/255, g/255, b/255;
end

ragdogLib.convertHexToRGB = function(hexCode)
   assert(#hexCode == 7, "The hex value must be passed in the form of #XXXXXX");
   local hexCode = hexCode:gsub("#","")
   return tonumber("0x"..hexCode:sub(1,2))/255,tonumber("0x"..hexCode:sub(3,4))/255,tonumber("0x"..hexCode:sub(5,6))/255;
end

return ragdogLib;