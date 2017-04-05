---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

local displayText = {}

---------------------------------------------------------------------------------
-- Displays Statistics

function displayStats()
    local sessionHits = display.newText("Total hits this session was "..
        composer.getVariable("currentHits"),display.contentWidth/2,
        display.contentHeight/5, "FN Blocknote Hand Regular.ttf")
    sessionHits:setFillColor( 1, 0, 0 )
    table.insert(displayText, sessionHits)

    local sessionClicks = display.newText("Total clicks this session was "..
        composer.getVariable("currentClicks"),display.contentWidth/2,
        (display.contentHeight/5)*2, "FN Blocknote Hand Regular.ttf")
    sessionClicks:setFillColor( 1, 0, 0 )
    table.insert(displayText, sessionClicks)

    local totalHits = display.newText("Total all time hits are "..
        composer.getVariable("totalHits"),display.contentWidth/2,
        (display.contentHeight/5)*3, "FN Blocknote Hand Regular.ttf")
    totalHits:setFillColor( 1, 0, 0 )
    table.insert(displayText, totalHits)

    local totalClicks = display.newText("Total all time clicks are "..
        composer.getVariable("totalClicks"),display.contentWidth/2,
        (display.contentHeight/5)*4, "FN Blocknote Hand Regular.ttf")
    totalClicks:setFillColor( 1, 0, 0 )
    table.insert(displayText, totalClicks)
end

---------------------------------------------------------------------------------
-- Removes Display Text

function removeDisplayText()
    for i=1, table.getn(displayText) do
        display.remove(displayText[i])
    end
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
        local title = self:getObjectByName( "Title" )
		title.x = display.contentWidth / 2
		title.y = display.contentHeight / 2
        title.size = display.contentWidth / 10
        local goToScene1Btn = self:getObjectByName( "GoToScene1Btn" )
        goToScene1Btn.x = display.contentWidth - 95
        goToScene1Btn.y = display.contentHeight - 35
        local goToScene1Text = self:getObjectByName( "GoToScene1Text" )
        goToScene1Text.x = display.contentWidth - 92
        goToScene1Text.y = display.contentHeight - 35
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc

        displayStats()


        nextSceneButton = self:getObjectByName( "GoToScene1Btn" )
        if nextSceneButton then
        	-- touch listener for the button
        	function nextSceneButton:touch ( event )
        		local phase = event.phase
        		if "ended" == phase then
        			composer.gotoScene( "scene1", { effect = "fade", time = 300 } )
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
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)

        removeDisplayText()

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
