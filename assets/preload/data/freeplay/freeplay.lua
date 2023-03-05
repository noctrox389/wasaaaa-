local selected = 1
local colorBG = {'31B0D1', 'FF8C00', 'C10000', '3AC100'}
local songName = {'Sporting', 'Boxing-Match', 'King-hit', 'King-hit-fefe'}
local scaleLikeBeat = {'bgF', 'bgS', 'icons', 'songNameTXT'}

local allowStart=false
function onStartCountdown()
playSound('songFreeplay', 1, 'freeplaySONG')
runTimer('boob', 0.65, 1)
	if allowStart==false then
		setProperty('inCutscene', true)
		return Function_Stop;
	end	 
	return Function_Continue;
end

function onCreatePost()
   makeLuaSprite('bgF', 'MENU/freeplayBG', 0, 0)
   setObjectCamera('bgF', 'camOther')
   addLuaSprite('bgF', true)
   setProperty('bgF.color', getColorFromHex('31B0D1'))
   
   makeLuaSprite('bgS', nil, 330, 160)
   setObjectCamera('bgS', 'camOther')
   makeGraphic('bgS', 640, 350, '000000')
   setProperty('bgS.alpha', 0.5)
   addLuaSprite('bgS', true)   

   makeLuaSprite('icons', 'MENU/FreeplayIcons', 500, 120)
   setObjectCamera('icons', 'camOther')
   scaleObject('icons', 1, 1)
   setProperty('icons.alpha', 1)   
   addLuaSprite('icons', true)     

   makeLuaText('songNameTXT', 'SONG NAME', 680, 310, 300)
   setTextSize('songNameTXT', 75)
   setProperty('songNameTXT.alpha', 1)
   setObjectCamera('songNameTXT', 'camOther')   
   addLuaText('songNameTXT', true)       

   makeLuaSprite('b1', nil, 0, 570)
   makeGraphic('b1', 150, 150, 'C600C6')
   setObjectCamera('b1', 'camOther')
   setProperty('b1.alpha', 0.2)
   addLuaSprite('b1', true)
   makeLuaSprite('b2', nil, 150, 570)
   makeGraphic('b2', 150, 150, 'FF0000')
   setObjectCamera('b2', 'camOther')
   setProperty('b2.alpha', 0.2)
   addLuaSprite('b2', true)
   makeLuaSprite('b3', nil, 1130, 570)
   makeGraphic('b3', 150, 150, '00FF00')
   setObjectCamera('b3', 'camOther')
   setProperty('b3.alpha', 0.2)
   addLuaSprite('b3', true)  
end

function onUpdate()	
	if keyJustPressed('back') or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ESCAPE') then
	   loadSong('menu')	   
	end
	
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.TAB') then
	   loadSong('freeplay')
	end		
    
	if selected < 1 then
	   selected = 4
	end  
	if selected > 4 then
	   selected = 1
	end 		
    setTextString('songNameTXT', songName[selected])
	if getMouseX('camOther') > getProperty('b1.x') and getMouseX('camOther') < getProperty('b1.x') + getProperty('b1.width') and getMouseY('camOther') > getProperty('b1.y') and getMouseY('camOther') < getProperty('b1.y') + getProperty('b1.height') and mouseClicked('left') then
	   selected = selected - 1
	   runTimer('changeColorForBackgroundPLS', 0.1, 1)
	   playSound('scrollMenu', 0.7)	   
	end	
	if getMouseX('camOther') > getProperty('b2.x') and getMouseX('camOther') < getProperty('b2.x') + getProperty('b2.width') and getMouseY('camOther') > getProperty('b2.y') and getMouseY('camOther') < getProperty('b2.y') + getProperty('b2.height') and mouseClicked('left') then
	   selected = selected + 1
	   runTimer('changeColorForBackgroundPLS', 0.1, 1)
	   playSound('scrollMenu', 0.7)
	end	
	if getMouseX('camOther') > getProperty('b3.x') and getMouseX('camOther') < getProperty('b3.x') + getProperty('b3.width') and getMouseY('camOther') > getProperty('b3.y') and getMouseY('camOther') < getProperty('b3.y') + getProperty('b3.height') and mouseClicked('left') then
	   loadSong(songName[selected], 1)	   
	end
end	
function onTimerCompleted(tag)
   if tag == 'boob' then
    for i=1,#scaleLikeBeat do
	  setProperty(''..scaleLikeBeat[i]..'.scale.x', 1.1)
	  setProperty(''..scaleLikeBeat[i]..'.scale.y', 1.1)
      doTweenX('beatX'..i, ''..scaleLikeBeat[i]..'.scale', 1, 0.5, 'cubeOut')	  
      doTweenY('beatY'..i, ''..scaleLikeBeat[i]..'.scale', 1, 0.5, 'cubeOut')	  	  
	end
	  runTimer('boob', 0.65, 1)
   end   
   if tag == 'changeColorForBackgroundPLS' then
	   doTweenColor('bgC', 'bgF', colorBG[selected], 0.5, 'linear')	     
   end
end
function onSoundFinished(tag)
   if tag == 'freeplaySONG' then
      playSound('songFreeplay', 1, 'freeplaySONG')
   end
end