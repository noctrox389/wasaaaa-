local allowStart=false
function onStartCountdown()
playSound('songMenuVS', 1)
runTimer('startSong', 10, 1)
	if allowStart==false then
		setProperty('inCutscene', true)
		return Function_Stop;
	end	 
	return Function_Continue;
end

function onCreatePost()
   isStoryMode = true
   makeLuaSprite('bgb', 'Stages/stage', 0, 0)
   setObjectCamera('bgb', 'camOther')
   scaleObject('bgb', 0.75, 0.75)
   addLuaSprite('bgb', true)

   makeAnimatedLuaSprite('mattIdling', 'characters/mattangry', 120, 160)
   addAnimationByPrefix('mattIdling', 'idle', 'matt idle', 12, true)
   setObjectCamera('mattIdling', 'camOther')
   scaleObject('mattIdling', 1, 1)  
   addLuaSprite('mattIdling', true)   
   makeAnimatedLuaSprite('bfPunch', 'characters/BOYFRIENDMII', 780, 200)
   addAnimationByPrefix('bfPunch', 'idle', 'BF idle dance', 12, true)
   setObjectCamera('bfPunch', 'camOther')
   scaleObject('bfPunch', 1, 1)  
   addLuaSprite('bfPunch', true)    
   
   makeAnimatedLuaSprite('VS', 'MENU/vsScreen', -20, -30)
   addAnimationByPrefix('VS', 'VS', 'loading screen gui', 24, true)
   setObjectCamera('VS', 'camOther')
   scaleObject('VS', 1, 1)  
   addLuaSprite('VS', true)      
   
   makeLuaText('controls', 'Controls \nSpam BLUE BUTTON to regain sheild \nPress RED BUTTON once the stamina meter is full to gain a random power \nPress ORANGE BUTTON to dodge', 1000, 140, 420)
   setTextSize('controls', 25)
   setProperty('controls.alpha', 1)
   setObjectCamera('controls', 'camOther')   
   addLuaText('controls', true)   

end

function onUpdate()	
end	
function onTimerCompleted(tag)
   if tag == 'startSong' then
      loadSong('Sporting', 2)
   end
end