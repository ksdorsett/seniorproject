---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
local physics = require( "physics" )

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )
local displayObjects = {}

---------------------------------------------------------------------------------
-- Save Data

function saveData()
    -- Data (string) to write
    local saveData = "My app state data"
 
    -- Path for the file to write
    local path = system.pathForFile( "saveData.txt", system.DocumentsDirectory )
 
    -- Open the file handle
    local file, errorString = io.open( path, "w" )
 
    if not file then
        -- Error occurred; output the cause
        print( "File error: " .. errorString )
    else
        -- Write data to file
        file:write( saveData )
        -- Close the file handle
        io.close( file )
    end
 
    file = nil
end

---------------------------------------------------------------------------------
-- Create Boundries
local boundary = {}
function boundaryBuilder()
    local top = display.newImage("images/oneBlackPixel.png")
    top.x=display.contentWidth/2
    top.y=0
    top.height=1
    top.width=display.contentWidth
    table.insert(boundary,top)
    physics.addBody(top,"static")
    local bottom = display.newImage("images/oneBlackPixel.png")
    bottom.x=display.contentWidth/2
    bottom.y=display.contentHeight-1
    bottom.height=1
    bottom.width=display.contentWidth
    table.insert(boundary,bottom)
    physics.addBody(bottom,"static")
    local left = display.newImage("images/oneBlackPixel.png")
    left.x=0
    left.y=display.contentHeight/2
    left.height=display.contentHeight
    left.width=1
    table.insert(boundary,left)
    physics.addBody(left,"static")
    local right = display.newImage("images/oneBlackPixel.png")
    right.x=display.contentWidth-1
    right.y=display.contentHeight/2
    right.height=display.contentHeight
    right.width=1
    table.insert(boundary,right)
    physics.addBody(right,"static")
end

---------------------------------------------------------------------------------
-- Boundary Remover
function removeBoundary()
    for i=1, table.getn(boundary) do
        display.remove(boundary[i])
    end
end


---------------------------------------------------------------------------------
-- Displayed Shape Remover
function removeDisplayedShapes()
    for i=1, table.getn(displayObjects) do
        display.remove(displayObjects[i])
    end
end

---------------------------------------------------------------------------------
-- Shape Spawner

local shapeArray = {"Circle", "Triangle", "Square", "Rectangle", "Diamond", "Oval"}
local firstShape
--Storing objects currently displayed on screen
local onShapeTouch,spawnRandomShape

function spawnRandomShape()
    local newShape = display.newImage("images/shapes/"..shapeArray[math.random(table.getn(shapeArray))]..".png")
    --newShape.height=100
    --newShape.width=100
    newShape:scale(.1,.1)
    newShape.x=display.contentWidth/4+math.random(display.contentWidth/2)
    newShape.y=display.contentHeight/4+math.random(display.contentHeight/2)
    table.insert(displayObjects,newShape)
    newShape:addEventListener("touch", onShapeTouch)
    physics.addBody( newShape, "dynamic", { radius=75, bounce=1 } )
    newShape:setLinearVelocity(20+math.random(30),20+math.random(30))
    newShape:applyTorque(-10+math.random(20))
end

function onShapeTouch(event)
    if ( event.phase == "ended" ) then
        removeDisplayedShapes()
        spawnRandomShape()
        composer.setVariable("totalHits",composer.getVariable("totalHits")+1)
        print("totalHits is" .. composer.getVariable("totalHits"))
        composer.setVariable("currentHits",composer.getVariable("currentHits")+1)
    end
end

---------------------------------------------------------------------------------
--On any click

function onTouch(event)
    if ( event.phase == "ended" ) then
        composer.setVariable("totalClicks",composer.getVariable("totalClicks")+1)
        print("totalClicks is" .. composer.getVariable("totalClicks"))
        composer.setVariable("currentClicks",composer.getVariable("currentClicks")+1)
    end
end

---------------------------------------------------------------------------------
-- Create Background (hitbox for touch)
local background
function backgroundBuilder()
    background = display.newImage("images/oneBlackPixel.png")
    background.x=display.contentWidth/2
    background.y=display.contentHeight/2
    background.height=display.contentHeight
    background.width=display.contentWidth
    background:addEventListener("touch", onTouch)
    background:toBack()
end

---------------------------------------------------------------------------------
-- Remove Background (hitbox for touch)
function removeBackground()
    display.remove(background)
end

---------------------------------------------------------------------------------

local nextSceneButton

function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
        local goToScene3Btn = self:getObjectByName( "GoToScene3Btn" )
        goToScene3Btn.x = display.contentWidth - 95
        goToScene3Btn.y =  23
        local goToScene3Text = self:getObjectByName( "GoToScene3Text" )
        goToScene3Text.x = display.contentWidth - 95
        goToScene3Text.y =  23

        physics.start(false) --true/false for sleeping bodies
        physics.setGravity( 0, 0 )
        boundaryBuilder()
        backgroundBuilder()

        composer.setVariable("currentHits",0)
        composer.setVariable("currentClicks",0)


    elseif phase == "did" then

        spawnRandomShape()


        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
        nextSceneButton = self:getObjectByName( "GoToScene3Btn" )
        if nextSceneButton then
        	-- touch listener for the button
        	function nextSceneButton:touch ( event )
        		local phase = event.phase
        		if "ended" == phase then
        			composer.gotoScene( "scene3", { effect = "fade", time = 300 } )
        		end
        	end
        	-- add the touch event listener to the button
        	nextSceneButton:addEventListener( "touch", nextSceneButton )
        end
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        removeDisplayedShapes()
        removeBoundary()
        removeBackground()


        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
    elseif phase == "did" then
        -- Called when the scene is now off screen
		if nextSceneButton then
			nextSceneButton:removeEventListener( "touch", nextSceneButton )
		end
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
