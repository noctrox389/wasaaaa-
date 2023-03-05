function onEndSong()
   if difficulty == 2 then
      loadSong('menu', 2)
   end
   if difficulty == 1 or difficulty == 0 then
      loadSong('freeplay', 2)
   end   
end