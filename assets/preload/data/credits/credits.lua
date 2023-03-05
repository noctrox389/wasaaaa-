local selected = 1
local optionSelected = false

local allowStart=false
function onStartCountdown()
playSound('songCredits', 1, 'creditsSONG')
	if allowStart==false then
		setProperty('inCutscene', true)
		return Function_Stop;
	end	 
	return Function_Continue;
end

function onCreate()
   makeLuaSprite('bgb', 'MENU/creditsMenu', 0, 0)
   setObjectCamera('bgb', 'camOther')
   addLuaSprite('bgb', true)    

   makeLuaSprite('b2', nil, 0, 570)
   makeGraphic('b2', 150, 150, 'FF0000')
   setObjectCamera('b2', 'camOther')
   setProperty('b2.alpha', 0.2)
   addLuaSprite('b2', true)
   makeLuaSprite('b3', nil, 1130, 570)
   makeGraphic('b3', 150, 150, '00FF00')
   setObjectCamera('b3', 'camOther')
   setProperty('b3.alpha', 0.2)
   addLuaSprite('b3', true)    
addHaxeLibrary('FlxG', 'flixel')
end

function onUpdate()
	if getMouseX('camOther') > getProperty('b2.x') and getMouseX('camOther') < getProperty('b2.x') + getProperty('b2.width') and getMouseY('camOther') > getProperty('b2.y') and getMouseY('camOther') < getProperty('b2.y') + getProperty('b2.height') and mouseClicked('left') then
	   loadSong('menu')
	end
	if getMouseX('camOther') > getProperty('b3.x') and getMouseX('camOther') < getProperty('b3.x') + getProperty('b3.width') and getMouseY('camOther') > getProperty('b3.y') and getMouseY('camOther') < getProperty('b3.y') + getProperty('b3.height') and mouseClicked('left') then
       runHaxeCode([[
        #if linux
          Sys.command('/usr/bin/xdg-open', https://gamebanana.com/mods/308568);
        #else
         FlxG.openURL('https://gamebanana.com/mods/308568');
         #end
        ]]) --THX БОРЩ (легенда)
	end	
end	
function onSoundFinished(tag)
   if tag == 'creditsSONG' then
      playSound('songCredits', 1, 'creditsSONG')
   end
end