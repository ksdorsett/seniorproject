---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

---------------------------------------------------------------------------------
--Load Save Data
function loadData()
    -- Path for the file to read
    local path = system.pathForFile( "saveData.txt", system.DocumentsDirectory )
 
    -- Open the file handle
    local file, errorString = io.open( path, "r" )

    if not file then
        -- Error occurred; output the cause
        composer.setVariable("totalHits",0)
        composer.setVariable("totalClicks",0)
    else
        -- Read data from file
        local contents = file:read( "*a" )
        -- Output the file contents
        print( "Contents of " .. path .. "\n" .. contents )
        -- Close the file handle
        io.close( file )
    end
 
    file = nil
end

---------------------------------------------------------------------------------

local nextSceneButton
local muteButton

function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
    loadData()
    print("totalClicks is" .. composer.getVariable("totalClicks"))
    print("totalHits is" .. composer.getVariable("totalHits"))
    local backgroundMusic = audio.loadSound( "sounds/bensound-cute.wav")
    audio.setVolume( 0.25, { channel=1 } )
    audio.play(backgroundMusic, {channel = 1, loops = -1, fadein = 5000})
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
        local goToScene2Btn = self:getObjectByName( "GoToScene2Btn" )
        goToScene2Btn.x = display.contentWidth - 95
        goToScene2Btn.y = display.contentHeight - 35
        local goToScene2Text = self:getObjectByName( "GoToScene2Text" )
        goToScene2Text.x = display.contentWidth - 95
        goToScene2Text.y = display.contentHeight - 35
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
        
        -- we obtain the object by id from the scene's object hierarchy
        nextSceneButton = self:getObjectByName( "GoToScene2Btn" )
        if nextSceneButton then
        	-- touch listener for the button
        	function nextSceneButton:touch ( event )
        		local phase = event.phase
        		if "ended" == phase then
        			composer.gotoScene( "scene2", { effect = "fade", time = 300 } )
        		end
        	end
        	-- add the touch event listener to the button
        	nextSceneButton:addEventListener( "touch", nextSceneButton )
        end

        muteButton = self:getObjectByName( "MuteBtn" )
        if muteButton then
            -- touch listener for the button
            function muteButton:touch ( event )
                local phase = event.phase
                if "ended" == phase then
                    print("Clicked mute")
                    audio.pause(0)
                end
            end
            -- add the touch event listener to the button
            muteButton:addEventListener( "touch", muteButton )
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
