local dirAnim = {'LEFT', 'DOWN', 'UP', 'RIGHT'}
local HUDtoDELETE = {'healthBarBG', 'healthBar', 'timeBar', 'timeBarBG', 'iconP1', 'iconP2'}
local isStando = false
local prepareOra = false
local isOra = false
local healthPie = 12
local healthRegenTap = 0
local powerUp = 0
local powerUpEffect = 0
local invincibility = false
local dodging = false

local mattSoffsets = {
   -15, -15, -23, -15, --x
   12, 35, 9, 0 --y 
}
local bfSoffsets = {
   -160, -160, -160, -200, --x
   -5, 55, 10, 10 --y 
}
function onCreatePost()
 for i=1, #HUDtoDELETE do
   setProperty(''..HUDtoDELETE[i]..'.visible', false)
 end
 if downscroll then
   setProperty('scoreTxt.y', 10)
 else  
   setProperty('scoreTxt.y', 690)
 end  
 
   makeAnimatedLuaSprite('mattSTANDO', 'Stands/mattstando', 330, 440)
   addAnimationByPrefix('mattSTANDO', 'idle', 'matt idle', 24, true)
   addAnimationByPrefix('mattSTANDO', 'singLEFT', 'matt left note', 24, false)
   addAnimationByPrefix('mattSTANDO', 'singDOWN', 'matt down note', 24, false)
   addAnimationByPrefix('mattSTANDO', 'singUP', 'matt up note', 24, false)
   addAnimationByPrefix('mattSTANDO', 'singRIGHT', 'matt right note', 24, false)   
   setObjectCamera('mattSTANDO', 'camGame')
   scaleObject('mattSTANDO', 1, 1)
   setProperty('mattSTANDO.alpha', 0)   
   addLuaSprite('mattSTANDO', true) 
   
   makeAnimatedLuaSprite('bfSTANDO', 'Stands/bfstando', 750, 460)
   addAnimationByPrefix('bfSTANDO', 'idle', 'BF idle dance', 24, true)
   addAnimationByPrefix('bfSTANDO', 'singLEFT', 'BF NOTE LEFT', 24, false)
   addAnimationByPrefix('bfSTANDO', 'singDOWN', 'BF NOTE DOWN', 24, false)
   addAnimationByPrefix('bfSTANDO', 'singUP', 'BF NOTE UP', 24, false)
   addAnimationByPrefix('bfSTANDO', 'singRIGHT', 'BF NOTE RIGHT', 24, false)   
   setObjectCamera('bfSTANDO', 'camGame')
   scaleObject('bfSTANDO', 1, 1)
   setProperty('bfSTANDO.alpha', 0)   
   addLuaSprite('bfSTANDO', true) 
   
   makeAnimatedLuaSprite('pie', 'HUD/pie', 40, 120)
  for i=0,12 do 
   addAnimationByPrefix('pie', 'health'..i..'', 'health '..i..'', 0, false)
  end
   setObjectCamera('pie', 'camHUD')
   scaleObject('pie', 0.75, 0.75)
   setProperty('pie.alpha', 0)   
   addLuaSprite('pie', true)   
   
   makeLuaSprite('powerBarBG', nil, 1240, 60)
   makeGraphic('powerBarBG', 16, 600, '000000')
   setObjectCamera('powerBarBG', 'camHUD')   
   addLuaSprite('powerBarBG', true)  
   makeLuaSprite('powerBar', nil, 1242, 65)
   makeGraphic('powerBar', 12, 590, '005FFF')
   setObjectCamera('powerBar', 'camHUD')   
   addLuaSprite('powerBar', true)
   
   makeLuaText('powerTxt', 'Press Z!', 500, 390, 500)
   setTextSize('powerTxt', 35)
   setProperty('powerTxt.alpha', 0)
   addLuaText('powerTxt', true)
   
   makeLuaSprite('b1', nil, 0, 570)
   makeGraphic('b1', 150, 150, '00FFFF')
   setObjectCamera('b1', 'camOther')
   setProperty('b1.alpha', 0.25)
   addLuaSprite('b1', true)
   makeLuaSprite('b2', nil, 150, 570)
   makeGraphic('b2', 150, 150, 'FF0000')
   setObjectCamera('b2', 'camOther')
   setProperty('b2.alpha', 0.25)
   addLuaSprite('b2', true)
   makeLuaSprite('b3', nil, 300, 570)
   makeGraphic('b3', 150, 150, 'FF7800')
   setObjectCamera('b3', 'camOther')
   setProperty('b3.alpha', 0.25)
   addLuaSprite('b3', true)     
end
function onUpdate()   
   objectPlayAnimation('pie', 'health'..healthPie..'', false) 
   setProperty('powerBar.scale.y', powerUp / 100)   
   if getMouseX('camOther') > getProperty('b1.x') and getMouseX('camOther') < getProperty('b1.x') + getProperty('b1.width') and getMouseY('camOther') > getProperty('b1.y') and getMouseY('camOther') < getProperty('b1.y') + getProperty('b1.height') and mouseClicked('left') then
      healthRegenTap = healthRegenTap + 1
   end
   if getMouseX('camOther') > getProperty('b3.x') and getMouseX('camOther') < getProperty('b3.x') + getProperty('b3.width') and getMouseY('camOther') > getProperty('b3.y') and getMouseY('camOther') < getProperty('b3.y') + getProperty('b3.height') and mouseClicked('left') and dodging == false and isStando == false and mustHitSection == false and isOra == false and prepareOra == false then
      dodging = true
      triggerEvent('Play Animation', 'dodge', 'boyfriend')   		  
	  runTimer('dodged', 1.25, 1)
   end
   if healthRegenTap == 4 then
      healthRegenTap = 0
	  healthPie = healthPie + 1
   end
   if healthPie <= 0 then
      setProperty('health', -420228)
   end
   if healthPie > 12 then
      healthPie = 12
   end
   if powerUp == 100 then
    setProperty('powerTxt.alpha', 1)
	setTextString('powerTxt', 'Press RED!')	
     if getMouseX('camOther') > getProperty('b2.x') and getMouseX('camOther') < getProperty('b2.x') + getProperty('b2.width') and getMouseY('camOther') > getProperty('b2.y') and getMouseY('camOther') < getProperty('b2.y') + getProperty('b2.height') and mouseClicked('left') then
      powerUpEffect = getRandomInt(1,10)
	  powerUp = 0
	  runTimer('powerTxtFadeOut', 2, 1)
	  if powerUpEffect == 1 or powerUpEffect == 2 or powerUpEffect == 5 then
	     --nothing lol
		 setTextString('powerTxt', 'nothing lol')
	  end
	  if powerUpEffect == 4 or powerUpEffect == 10 or powerUpEffect == 8 then
	     healthPie = healthPie - getRandomInt(1,3)	  
		 setTextString('powerTxt', 'Die')	
         setProperty('pie.alpha', 1)		 
	  end
	  if powerUpEffect == 3 or powerUpEffect == 6 or powerUpEffect == 9 then
	     healthPie = healthPie + getRandomInt(1,3)
		 setTextString('powerTxt', 'Extra Shield')	
         setProperty('pie.alpha', 1)		 
	  end
	  if powerUpEffect == 7 then
	     invincibility = true
		 runTimer('stopInvincibility', 5, 1)
		 setTextString('powerTxt', 'Invincibility')	
	  end
	 end 
   end
end
function goodNoteHit(id, direction, noteData, type, isSustainNote)
 if powerUp < 100 then
   powerUp = powerUp + 0.5
 end
 if isStando == false and dodging == false and isOra == false and prepareOra == false then  
  for i=0,#dirAnim do
    if direction == i then
      playAnim('dad', 'block'..dirAnim[i+1]..'', false)
      playAnim('boyfriend', 'punch'..dirAnim[i+1]..'', false)	  
    end 
  end
 end 
 if isStando == true then  
  for i=0,#dirAnim do
    if direction == i then
      playAnim('bfSTANDO', 'sing'..dirAnim[i+1]..'', false) 
      setProperty('bfSTANDO.x', 750+ bfSoffsets[i+1])
      setProperty('bfSTANDO.y', 460+ bfSoffsets[i+5])	  
    end 
  end
 end  
end
function opponentNoteHit(id, direction, type, isSustainNote)
 if isStando == false and isOra == false and prepareOra == false then 
  for i=0,#dirAnim do
    if direction == i then
      playAnim('dad', 'punch'..dirAnim[i+1]..'', false)	
     if dodging == false then 
      playAnim('boyfriend', 'block'..dirAnim[i+1]..'', false)
	 end 
    end 
  end    
 end  
 if isStando == true then  
  for i=0,#dirAnim do
    if direction == i then
      playAnim('mattSTANDO', 'sing'..dirAnim[i+1]..'', false) 
      setProperty('mattSTANDO.x', 330+ mattSoffsets[i+1])
      setProperty('mattSTANDO.y', 440+ mattSoffsets[i+5])	  
    end 
  end
 end 
end
function noteMiss(id, direction, noteType, isSustainNote)
 if invincibility == false then
  healthPie = healthPie - 1
  setProperty('pie.alpha', 1)
 end 
 if invincibility == true then
  setProperty('pie.alpha', 1) 
 end   
 if isStando == true and mustHitSection == true then  
   playAnim('boyfriend', 'stand', false) 
 end
end
function onEvent(name, value1, value2)
   if name == 'stando' then
     if value1 == 'T' then
	    isStando = true 		
        triggerEvent('Play Animation', 'stand', 'dad')   		
	 end
     if value1 == 'F' then
	    isStando = false	
	 end	 
   end
   if name == 'tweenStando' then
     if value1 == 'dad' then
	  if value2 == 'T' then
	   doTweenAlpha('mattSTANDO1', 'mattSTANDO', 1, 0.5, 'cubeOut')
	  end 
	  if value2 == 'F' then
       playAnim('dad', 'idle', false) 	  
	   doTweenAlpha('mattSTANDO2', 'mattSTANDO', 0, 0.5, 'cubeOut')
       playAnim('mattSTANDO', 'idle', false) 	 
       setProperty('mattSTANDO.x', 330)
       setProperty('mattSTANDO.y', 440)		   
	  end 	  
	 end     
     if value1 == 'bf' then
	  if value2 == 'T' then
	   doTweenAlpha('boyfriendSTANDO1', 'bfSTANDO', 1, 0.5, 'cubeOut')
	  end 
	  if value2 == 'F' then
	   doTweenAlpha('boyfriendSTANDO2', 'bfSTANDO', 0, 0.5, 'cubeOut')
       playAnim('bfSTANDO', 'idle', false) 	 
       setProperty('bfSTANDO.x', 750)
       setProperty('bfSTANDO.y', 460)		   
	  end 	  
	 end   
   end   
   if name == 'prepare' and prepareOra == false then
     prepareOra = true
	 doTweenX('dadLeft', 'dad', getProperty('dad.x')- 420, 0.2, 'cubeInOut')  
	 doTweenX('bfRight', 'boyfriend', getProperty('boyfriend.x')+ 420, 0.2, 'cubeInOut') 
     triggerEvent('Play Animation', 'prepare', 'dad')  
     triggerEvent('Play Animation', 'prepare', 'bf')    	 
   end
   if name == 'oraEnd' then
     isOra = false
     cameraFlash('camOther', 'FFFFFF', 0.75, false)			 
     triggerEvent('Play Animation', 'idle', 'dad')  
     triggerEvent('Play Animation', 'idle', 'bf')  	 
   end
end
function onStepHit()
  if curStep % 96 == 0 then
    doTweenY('gfDownLine', 'gf', getProperty('gf.y')+ 40, 0.75, 'cubeIn')  
  end
  if isStando == true and mustHitSection == false and curStep % 12 == 0 then
    triggerEvent('Play Animation', 'stand', 'dad')  
  end    
  if isStando == true and mustHitSection == true and curStep % 8 == 0 then
    playAnim('boyfriend', 'stand', false)  
  end  
  if isOra == true then
     triggerEvent('Screen Shake', '0.1, 0.005', '0.1, 0.0025')    
   if curStep % 4 == 0 then
     triggerEvent('Play Animation', 'ora', 'dad')  
     triggerEvent('Play Animation', 'ora', 'bf')     
   end	 
  end
end
function onBeatHit()
   if healthPie == 12 and curBeat % 4 == 0 and getProperty('pie.alpha') == 1 then
	  doTweenAlpha('pieBye', 'pie', 0, 0.5, 'cubeInOut')   
   end
end
function onTweenCompleted(tag)
   if tag == 'gfDownLine' then
     doTweenY('gfUpLine', 'gf', getProperty('gf.y')- 40, 0.75, 'cubeOut')     
   end
   if tag == 'bfRight' then
	 doTweenX('dadBACK', 'dad', getProperty('dad.x')+ 420, 0.25, 'cubeIn')  
	 doTweenX('bfBACK', 'boyfriend', getProperty('boyfriend.x')- 420, 0.25, 'cubeIn')  
   end 
   if tag == 'bfBACK' then
      prepareOra = false
	  isOra = true
      triggerEvent('Play Animation', 'ora', 'dad')  
      triggerEvent('Play Animation', 'ora', 'bf')   	  
   end    
end
function onTimerCompleted(tag, loops, loopsLeft)
   if tag == 'powerTxtFadeOut' then
      doTweenAlpha('powerTxtBye', 'powerTxt', 0, 0.5, 'cubeIn')
   end
   if tag == 'stopInvincibility' then
      invincibility = false
   end  
   if tag == 'dodged' then
      dodging = false
	  playAnim('boyfriend', 'idle', false)
   end   
end