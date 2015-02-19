local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------


local function startBtnListener( event )
    composer.gotoScene( "level1", "fade", 800)
end

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    -- Initialize the scene here.
    local bg = display.newImage( sceneGroup, "res/splashBG.jpg", display.contentWidth/2, display.contentHeight/2 + 10)
    bg.width = display.contentWidth
    bg.height = display.contentHeight - 10

    local name = display.newText( sceneGroup, "Austin Ruggles", display.contentWidth/2, 5, display.contentWidth, 10, arial, 8 )
    

    local startBtnOpt = {
        x = 175,
        y = 150,    
        width = 155,
        height = 15,
        shape = "roundedRect",
        id = "btnStart",
        label = "START ol^.^lo ",
        labelColor = { default={ 0, 0, 0 }, over={ 1, 1, 1 } },  
        fillColor = { default={ .984, 1, .565, 1 }, over={ .168627, 0, 1 } },
        strokeColor = { default={ 1, 0.4, 0, 1 }, over={ 0.8, 0.8, 1, 1 } },
        strokeWidth = 1,
        onRelease = startBtnListener,
    }


    local startBtn = widget.newButton( startBtnOpt )
    sceneGroup:insert( startBtn )
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene