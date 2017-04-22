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

function resetData()
    composer.setVariable("currentHits",0)
    composer.setVariable("currentClicks",0)
    composer.setVariable("totalHits",0)
    composer.setVariable("totalClicks",0)
    -- Data (string) to write
    local saveData = "0\n0"
 
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
-- Displays Statistics

function displayStats()
    local sessionHits2 = display.newText("Total successful clicks this session was "..
        composer.getVariable("currentHits"),(display.contentWidth/2)+1,
        ((display.contentHeight/10)*2)+1, "FN Blocknote Hand Regular.ttf")
    sessionHits2:setFillColor( 0, 0, 0 )
    table.insert(displayText, sessionHits2)

    local sessionClicks2 = display.newText("Total clicks this session was "..
        composer.getVariable("currentClicks"),(display.contentWidth/2)+1,
        ((display.contentHeight/10)*3)+1, "FN Blocknote Hand Regular.ttf")
    sessionClicks2:setFillColor( 0, 0, 0 )
    table.insert(displayText, sessionClicks2)

    if(composer.getVariable("currentClicks")==0) then
        local sessionPercentage2 = display.newText("Hit percentage this session was 0%",(display.contentWidth/2)+1,
            ((display.contentHeight/10)*4)+1, "FN Blocknote Hand Regular.ttf")
        sessionPercentage2:setFillColor( 0, 0, 0 )
        table.insert(displayText, sessionPercentage2)
    else
        local sessionPercentage2 = display.newText("Hit percentage this session was "..
            math.floor(composer.getVariable("currentHits")/composer.getVariable("currentClicks")*100)
            .."%",(display.contentWidth/2)+1,
            ((display.contentHeight/10)*4)+1, "FN Blocknote Hand Regular.ttf")
        sessionPercentage2:setFillColor( 0, 0, 0 )
        table.insert(displayText, sessionPercentage2)
    end

    local totalHits2 = display.newText("Total successful clicks all time are "..
        composer.getVariable("totalHits"),(display.contentWidth/2)+1,
        ((display.contentHeight/10)*5)+1, "FN Blocknote Hand Regular.ttf")
    totalHits2:setFillColor( 0, 0, 0 )
    table.insert(displayText, totalHits2)

    local totalClicks2 = display.newText("Total clicks all time are "..
        composer.getVariable("totalClicks"),(display.contentWidth/2)+1,
        ((display.contentHeight/10)*6)+1, "FN Blocknote Hand Regular.ttf")
    totalClicks2:setFillColor( 0, 0, 0 )
    table.insert(displayText, totalClicks2)

    if(composer.getVariable("totalClicks")==0) then
        local totalPercentage2 = display.newText("Hit percentage all time is 0%",(display.contentWidth/2)+1,
            ((display.contentHeight/10)*7)+1, "FN Blocknote Hand Regular.ttf")
        totalPercentage2:setFillColor( 0, 0, 0 )
        table.insert(displayText, totalPercentage2)
    else
        local totalPercentage2 = display.newText("Hit percentage all time is "..
            math.floor(composer.getVariable("totalHits")/composer.getVariable("totalClicks")*100)
            .."%",(display.contentWidth/2)+1,
            ((display.contentHeight/10)*7)+1, "FN Blocknote Hand Regular.ttf")
        totalPercentage2:setFillColor( 0, 0, 0 )
        table.insert(displayText, totalPercentage2)
    end

    local sessionHits = display.newText("Total successful clicks this session was "..
        composer.getVariable("currentHits"),display.contentWidth/2,
        (display.contentHeight/10)*2, "FN Blocknote Hand Regular.ttf")
    sessionHits:setFillColor( 1, 0, 0 )
    table.insert(displayText, sessionHits)

    local sessionClicks = display.newText("Total clicks this session was "..
        composer.getVariable("currentClicks"),display.contentWidth/2,
        (display.contentHeight/10)*3, "FN Blocknote Hand Regular.ttf")
    sessionClicks:setFillColor( 1, 0, 0 )
    table.insert(displayText, sessionClicks)

    if(composer.getVariable("currentClicks")==0) then
        local sessionPercentage = display.newText("Hit percentage this session was 0%",display.contentWidth/2,
            (display.contentHeight/10)*4, "FN Blocknote Hand Regular.ttf")
        sessionPercentage:setFillColor( 1, 0, 0 )
        table.insert(displayText, sessionPercentage)
    else
        local sessionPercentage = display.newText("Hit percentage this session was "..
            math.floor(composer.getVariable("currentHits")/composer.getVariable("currentClicks")*100)
            .."%",display.contentWidth/2,
            (display.contentHeight/10)*4, "FN Blocknote Hand Regular.ttf")
        sessionPercentage:setFillColor( 1, 0, 0 )
        table.insert(displayText, sessionPercentage)
    end

    local totalHits = display.newText("Total successful clicks all time are "..
        composer.getVariable("totalHits"),display.contentWidth/2,
        (display.contentHeight/10)*5, "FN Blocknote Hand Regular.ttf")
    totalHits:setFillColor( 1, 0, 0 )
    table.insert(displayText, totalHits)

    local totalClicks = display.newText("Total clicks all time are "..
        composer.getVariable("totalClicks"),display.contentWidth/2,
        (display.contentHeight/10)*6, "FN Blocknote Hand Regular.ttf")
    totalClicks:setFillColor( 1, 0, 0 )
    table.insert(displayText, totalClicks)

    if(composer.getVariable("totalClicks")==0) then
        local totalPercentage = display.newText("Hit percentage all time is 0%",display.contentWidth/2,
            (display.contentHeight/10)*7, "FN Blocknote Hand Regular.ttf")
        totalPercentage:setFillColor( 1, 0, 0 )
        table.insert(displayText, totalPercentage)
    else
        print(composer.getVariable("totalClicks"))
        local totalPercentage = display.newText("Hit percentage all time is "..
            math.floor(composer.getVariable("totalHits")/composer.getVariable("totalClicks")*100)
            .."%",display.contentWidth/2,
            (display.contentHeight/10)*7, "FN Blocknote Hand Regular.ttf")
        totalPercentage:setFillColor( 1, 0, 0 )
        table.insert(displayText, totalPercentage)
    end
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

        resetButton = self:getObjectByName( "ResetBtn")
         if resetButton then
            -- touch listener for the button
            function resetButton:touch ( event )
                local phase = event.phase
                if "ended" == phase then
                    resetData()
                    composer.gotoScene( "scene1", { effect = "fade", time = 300 } )
                end
            end
            -- add the touch event listener to the button
            resetButton:addEventListener( "touch", resetButton )
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
        displayText={}

    elseif phase == "did" then
        -- Called when the scene is now off screen
		if nextSceneButton then
			nextSceneButton:removeEventListener( "touch", nextSceneButton )
		end
        if resetButton then
            resetButton:removeEventListener( "touch", resetButton )
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
