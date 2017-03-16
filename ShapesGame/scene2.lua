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
-- Create Boundries
local boundry = {}
function boundryBuilder()
    print(display.contentHeight)
    print(display.contentWidth)
    local line1 = display.newLine(0,0,0,display.contentHeight)
    line1:setStrokeColor( 1, 0, 0, 1 )
    line1.strokeWidth = 8
    local line2 = display.newLine(0,display.contentHeight,
        display.contentWidth,display.contentHeight)
    line2:setStrokeColor( 1, 0, 0, 1 )
    line2.strokeWidth = 8
    local line3 = display.newLine(display.contentWidth,display.contentHeight,
        display.contentWidth,0)
    line3:setStrokeColor( 1, 0, 0, 1 )
    line3.strokeWidth = 8
    local line4 = display.newLine(0,0,display.contentWidth,0)
    line4:setStrokeColor( 1, 0, 0, 1 )
    line4.strokeWidth = 8
    table.insert(boundry,line1)
    table.insert(boundry,line2)
    table.insert(boundry,line3)
    table.insert(boundry,line4)
    physics.addBody(line1,"static")
    physics.addBody(line2,"static")
    physics.addBody(line3,"static")
    physics.addBody(line4,"static")
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
end

function onShapeTouch(event)
    if ( event.phase == "ended" ) then
        removeDisplayedShapes()
        spawnRandomShape()
    end
end

---------------------------------------------------------------------------------
--Remove shape and spawn new one


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
    elseif phase == "did" then
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

        physics.start(false) --true/false for sleeping bodies
        physics.setGravity( 0, 0 )

        boundryBuilder()

        spawnRandomShape()
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
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
