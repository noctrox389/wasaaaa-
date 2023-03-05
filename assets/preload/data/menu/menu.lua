local selected = 1
local optionSelected = false
local loadingTxt = {'Loading Assets...', 'Loading Song...', 'Loading JSON...', 'Loading Mechanics...', 'Precaching Sprites...', 'Press ACCEPT to load song!'}
local SDinstalling = false
local installText = 1

local allowStart=false
function onStartCountdown()
playSound('songMenu', 1, 'menuSONG')
setTextString('LoadingSD', loadingTxt[installText])
	if allowStart==false then
		setProperty('inCutscene', true)
		return Function_Stop;
	end	 
	return Function_Continue;
end

function onCreate()
   makeLuaSprite('bgb', nil, 0, 0)
   makeGraphic('bgb', 1280, 720, '000000')
   setObjectCamera('bgb', 'camOther')
   addLuaSprite('bgb', true)

   makeAnimatedLuaSprite('mattIdling', 'characters/mattangry', 20, 240)
   addAnimationByPrefix('mattIdling', 'idle', 'matt idle', 12, true)
   setObjectCamera('mattIdling', 'camOther')
   scaleObject('mattIdling', 1, 1)
   setProperty('mattIdling.alpha', 1)   
   addLuaSprite('mattIdling', true)   
   makeAnimatedLuaSprite('bfIdling', 'characters/BOYFRIENDMII', 940, 300)
   addAnimationByPrefix('bfIdling', 'idle', 'BF idle dance', 12, true)
   setObjectCamera('bfIdling', 'camOther')
   scaleObject('bfIdling', 0.9, 0.9)
   setProperty('bfIdling.alpha', 1)   
   addLuaSprite('bfIdling', true)   

   makeAnimatedLuaSprite('logo', 'MENU/logo', 260, 60)
   addAnimationByPrefix('logo', 'bum', 'logo bumpin', 24, true)
   setObjectCamera('logo', 'camOther')
   scaleObject('logo', 1, 1)
   setProperty('logo.alpha', 1)   
   addLuaSprite('logo', true)   

   makeLuaSprite('sd', 'MENU/sd_card', 980, 20)
 --  makeGraphic('xd', 1280, 720, '000000')
   setObjectCamera('sd', 'camOther')
   addLuaSprite('sd', true)   

   makeLuaText('optionOne', 'PLAY', 500, 40, 600)
   setTextSize('optionOne', 65)
   setProperty('optionOne.alpha', 1)
   setObjectCamera('optionOne', 'camOther')   
   addLuaText('optionOne', true)
   makeLuaText('optionTwo', 'CREDITS', 500, 360, 600)
   setTextSize('optionTwo', 65)
   setProperty('optionTwo.alpha', 1)
   setObjectCamera('optionTwo', 'camOther')   
   addLuaText('optionTwo', true)   
   makeLuaText('optionThree', 'FREEPLAY', 500, 720, 600)
   setTextSize('optionThree', 65)
   setProperty('optionThree.alpha', 1)
   setObjectCamera('optionThree', 'camOther')   
   addLuaText('optionThree', true)      
   makeLuaText('optionARROW', 'V', 500, 40, 500)
   setTextSize('optionARROW', 65)
   setProperty('optionARROW.alpha', 1)
   setObjectCamera('optionARROW', 'camOther')   
   addLuaText('optionARROW', true)  
   

   makeLuaSprite('darkenBG', nil, 0, 0)
   makeGraphic('darkenBG', 1280, 720, '000000')
   setObjectCamera('darkenBG', 'camOther')
   setProperty('darkenBG.alpha', 0)
   addLuaSprite('darkenBG', true)   

   makeLuaText('LoadingSD', 'Press ACCEPT to load song!', 1200, 50, 480)
   setTextSize('LoadingSD', 65)
   setProperty('LoadingSD.alpha', 0)
   setObjectCamera('LoadingSD', 'camOther')   
   addLuaText('LoadingSD', true)         

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

   makeLuaSprite('mouse', 'MENU/wii_cursor', 0, 0)
   setObjectCamera('mouse', 'camOther')
   addLuaSprite('mouse', true)     
end

function onUpdate()	
  setProperty('mouse.x', getMouseX('camOther'))
  setProperty('mouse.y', getMouseY('camOther'))  
	if keyJustPressed('back') or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ESCAPE') then
	   endSong()	   
	end
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.TAB') then
	   loadSong(songName)
	end	

  if SDinstalling == false then
	if getMouseX('camOther') > getProperty('b1.x') and getMouseX('camOther') < getProperty('b1.x') + getProperty('b1.width') and getMouseY('camOther') > getProperty('b1.y') and getMouseY('camOther') < getProperty('b1.y') + getProperty('b1.height') and mouseClicked('left') then
	   selected = selected - 1
	   playSound('scrollMenu', 0.7)	   
	end	
	if getMouseX('camOther') > getProperty('b2.x') and getMouseX('camOther') < getProperty('b2.x') + getProperty('b2.width') and getMouseY('camOther') > getProperty('b2.y') and getMouseY('camOther') < getProperty('b2.y') + getProperty('b2.height') and mouseClicked('left') then
	   selected = selected + 1
	   playSound('scrollMenu', 0.7)
	end
	if selected < 1 then
	   selected = 3
	end  
	if selected > 3 and selected ~= 666 then
	   selected = 1
	end 
  end	
    if selected == 1 then
       setProperty('optionARROW.x', getProperty('optionOne.x'))
	   if getMouseX('camOther') > getProperty('b3.x') and getMouseX('camOther') < getProperty('b3.x') + getProperty('b3.width') and getMouseY('camOther') > getProperty('b3.y') and getMouseY('camOther') < getProperty('b3.y') + getProperty('b3.height') and mouseClicked('left') and optionSelected == false then
	      cameraFlash('camOther', 'FFFFFF', 0.75, false)  
	      playSound('confirmMenu', 1)
	      runTimer('optionOne', 1.45, 1)
		  optionSelected = true
	   end
    end 
    if selected == 2 then
       setProperty('optionARROW.x', getProperty('optionTwo.x'))
	   if getMouseX('camOther') > getProperty('b3.x') and getMouseX('camOther') < getProperty('b3.x') + getProperty('b3.width') and getMouseY('camOther') > getProperty('b3.y') and getMouseY('camOther') < getProperty('b3.y') + getProperty('b3.height') and mouseClicked('left') and optionSelected == false then
	      cameraFlash('camOther', 'FFFFFF', 0.75, false)  
	      playSound('confirmMenu', 1)
	      runTimer('optionTwo', 1.25, 1)
		  optionSelected = true
	   end	   
    end 
    if selected == 3 then
       setProperty('optionARROW.x', getProperty('optionThree.x'))
	   if getMouseX('camOther') > getProperty('b3.x') and getMouseX('camOther') < getProperty('b3.x') + getProperty('b3.width') and getMouseY('camOther') > getProperty('b3.y') and getMouseY('camOther') < getProperty('b3.y') + getProperty('b3.height') and mouseClicked('left') and optionSelected == false then
	      cameraFlash('camOther', 'FFFFFF', 0.75, false)  
	      playSound('confirmMenu', 1)
	      runTimer('optionThree', 1.45, 1)
		  optionSelected = true
	   end	   	   
    end 	
    if selected == 666 then
       setProperty('optionARROW.alpha', 0)
	   if getMouseX('camOther') > getProperty('b3.x') and getMouseX('camOther') < getProperty('b3.x') + getProperty('b3.width') and getMouseY('camOther') > getProperty('b3.y') and getMouseY('camOther') < getProperty('b3.y') + getProperty('b3.height') and mouseClicked('left') then
          loadSong('Mattpurgation', 2)
	   end	   	   
    end 		
	
	if getMouseX('camOther') > getProperty('sd.x') and getMouseX('camOther') < getProperty('sd.x') + getProperty('sd.width') and getMouseY('camOther') > getProperty('sd.y') and getMouseY('camOther') < getProperty('sd.y') + getProperty('sd.height') and mouseClicked('left') and SDinstalling == false then
	   doTweenAlpha('darkenBG', 'darkenBG', 0.65, 0.7, 'linear')
	   doTweenAlpha('LoadingSD', 'LoadingSD', 1, 0.8, 'linear')	
       runTimer('LoadingSD', 1.5, 5)	   
	   SDinstalling = true
	   selected = 0
	end
end	
function onTimerCompleted(tag)
   if tag == 'optionOne' then
      loadSong('VS')
   end
   if tag == 'optionTwo' then
      loadSong('Credits')
   end   
   if tag == 'optionThree' then
      loadSong('Freeplay')
   end  
   if tag == 'LoadingSD' then
     installText = installText + 1
     setTextString('LoadingSD', loadingTxt[installText])
	 if installText == 6 then
	    selected = 666
	 end
   end   
end
function onSoundFinished(tag)
   if tag == 'menuSONG' then
      playSound('songMenu', 1, 'menuSONG')
   end
end