-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


local walkLenTime=2000
local prepereLenTime=200
local HitTime=300


local timeBetweenHits=math.random(walkLenTime-walkLenTime*0.5, walkLenTime+walkLenTime*0.8)
local timePrepareHit=math.random(prepereLenTime-prepereLenTime*0.5, prepereLenTime+prepereLenTime*0.5)
local timeMakingHit=math.random(HitTime-HitTime*0.5, HitTime+HitTime*0.5)

local deltaTime=0
local curtime = 0
local lastCurTime=0

local timeAfterHit=0
local timeAfterPrepare=0
local timeAfterStartHitting=0

local hitState="walk"

local enemyWalk=display.newImage("walk.jpg",display.contentCenterX, display.contentCenterY)
local enemyPrepare=display.newImage("prepare.jpg",display.contentCenterX, display.contentCenterY)
enemyPrepare.isVisible=false
local enemyHit=display.newImage("making.jpg",display.contentCenterX, display.contentCenterY)
enemyHit.isVisible=false

local score=0



local myText = display.newText( "Score:", 10, 30, native.systemFont, 22 )
myText:setFillColor( 1, 0, 0.5 )


function onTouch(event )
	-- body
	score=score+1
	myText.text="Score: "..score
end

enemyPrepare:addEventListener( "touch", onTouch )




local myListener = function( event )
   lastCurTime=curtime
   curtime=system.getTimer()
   deltaTime=curtime-lastCurTime

   if hitState=="walk" then
   		timeAfterHit=timeAfterHit+deltaTime
   		 if timeAfterHit>=timeBetweenHits then
   		 	-- начать готовиться к удару
   		 	hitState="PrepareHit"
   		 	timeAfterHit=0
   		 	enemyWalk.isVisible=false
   		 	enemyPrepare.isVisible=true
   		 	
   		 end
   		
   end
   if hitState=="PrepareHit" then
   		
   		timeAfterPrepare=timeAfterPrepare+deltaTime
   		 if timeAfterPrepare>=timePrepareHit then
   		 	-- начать ударять
   		 	hitState="MakingHit"
   		 	timeAfterPrepare=0
   		 	enemyPrepare.isVisible=false
   		 	enemyHit.isVisible=true
   		 end	
   end
   if hitState=="MakingHit" then	
   		timeAfterStartHitting=timeAfterStartHitting+deltaTime
   		 if timeAfterStartHitting>=timeMakingHit then
   		 	-- удар закончился
	   		hitState="walk"
			timeBetweenHits=math.random(walkLenTime-walkLenTime*0.5, walkLenTime+walkLenTime*0.8)
			timePrepareHit=math.random(prepereLenTime-prepereLenTime*0.5, prepereLenTime+prepereLenTime*0.5)
			timeMakingHit=math.random(HitTime-HitTime*0.5, HitTime+HitTime*0.5)
			timeAfterStartHitting=0
			enemyHit.isVisible=false
			enemyWalk.isVisible=true
   		 end
   end
end
Runtime:addEventListener( "enterFrame", myListener )



