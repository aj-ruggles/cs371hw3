local composer = require( "composer" )
local widget = require( "widget" )
local sheetInfo = require( "sheet" )
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here
-- characters
local alex, parplin

-- frames for each parplin hand
local parplinHand = {
    [1] = 10,   --rock
    [2] = 9,    --paper
    [3] = 14,   --scissor
}

-- wigetbuttons
local btnGo, btnRock, btnPaper, btnScissor

---------- ALEX KIDD  -------------------------------------
local options =
{
    frames = {
        { x = 1, y = 2, width = 16, height = 25}, --frame 1       
        { x = 18, y = 2, width = 16, height = 25}, --frame 2        
        { x = 35, y = 2, width = 16, height = 25}, --frame 3        
        { x = 52, y = 2, width = 16, height = 25}, --frame 4
        { x = 1, y = 54, width = 16, height = 24},  --ready1
        { x = 19, y = 54, width = 16, height = 24}, --ready2
        { x = 37, y = 54, width = 29, height = 24}, -- rock
        { x = 67, y = 54, width = 33, height = 24}, -- scissor
        { x = 101, y = 54, width = 33, height = 24},  -- paper       
    }
}
local sheet = graphics.newImageSheet( "res/kidd.png", options )

local seqData = {
    {name = "normal", start=1 , count = 4, time = 800},
    {name = "faster", frames={1,2,3,4}, time = 400},
    {name = "shake", frames={5,6}, time = 500},
    {name = "rock", frames={7}},
    {name = "paper", frames={9}},
    {name = "scissor", frames={8}},

}

---------- PARPLIN  ---------------------------------------


local baddieSheet = graphics.newImageSheet( "res/chars.png", sheetInfo:getSheet() )

-- Create animation sequence parplin
local seqDataParplin = {
    {name = "taunt", frames={15,16}, time = 500},
    {name = "shake", frames={12,13}, time = 500},    
    {name = "set", frames={11}, time = 10, loopCount=1}, 
    {name = "rock", frames={10}, time = 5000},  
    {name = "paper", frames={9}, time = 5000},
    {name = "scissor", frames={14}, time = 5000},      
}

---------- BUTTONS  ---------------------------------------


local btnOpt =
{
    frames = {
        { x = 3, y = 2, width=70, height = 22}, --frame 1       
        { x = 78, y = 2, width=70, height = 22}, --frame 2        
        
    }
}

local buttonSheet = graphics.newImageSheet( "res/button.png", btnOpt )



-- -------------------------------------------------------------------------------------
local function delete(obj)
    obj:removeSelf()
    obj = nil
end
--================== Buttons to Change Scenes ===============--

local function level2BtnListener( event )
    composer.gotoScene( "level2", "fade", 800)
end

local function level1BtnListener( event )
    composer.gotoScene( "level1", "fade", 800)
end

local function sceneEndBtnListener( event )
    composer.gotoScene( "sceneEnd", "fade", 800)
end

--^^^^^^^^^^^^^^^^^ Buttons to Change Scenes ^^^^^^^^^^^^^^^--













local function function_name( ... )
    -- body
end


local function playPreview()
    parplin:setSequence( "shake" )
    parplin:play()
    transition.to(parplin, {time = 1500, onComplete=stopWalking})
end

--==================== Parplin Transitions ===================--

local function startWalking( event )
    alex:play()
    parplin:play()
    delete( btnGo )
end

local function stopWalking( event )
    alex:pause()
    alex:setFrame(2)
    playPreview()
end

local function go( event )
    --parplin.xScale = 1
    transition.to(alex, {time = 2500, x=145, onStart=startWalking, onComplete=stopWalking})
end





-- -------------------------------------------------------------------------------------
-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    -- Initialize the scene here.
    local bg = display.newImage( sceneGroup, "res/bg.png", display.contentWidth/2, display.contentHeight/2 )
    bg.width = display.contentWidth
    bg.height = display.contentHeight

    alex = display.newSprite (sheet, seqData)
    alex:setFrame(2)
    alex.x = display.contentCenterX-95
    alex.y = display.contentCenterY+58

    alex.anchorX = 0
    alex.anchorY = 1

    parplin = display.newSprite (baddieSheet, seqDataParplin)

    parplin.x = display.contentCenterX+75
    parplin.y = display.contentCenterY+58

    parplin.anchorX = .5
    parplin.anchorY = 1
    parplin.xScale = -1
    




    ------------------------------------------------------------------------------
    -- add the widgets to go, and pick rock paper scissor 
    ------------------------------------------------------------------------------
    btnGo = widget.newButton(
        {
            x = 200,
            y = 20,    
            id = "btnGo",
            label = "Go!",
            labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },    
            sheet = buttonSheet,
            defaultFrame = 1,
            overFrame = 2,
            onPress = go,
        }
    )

    btnRock = widget.newButton(
        {
            x = 80,
            y = 20,    
            id = "btnRock",
            label = "Rock",
            labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },    
            sheet = buttonSheet,
            defaultFrame = 1,
            overFrame = 2,
            onEvent = play,
            isEnabled = false,
        }
    )

    btnPaper = widget.newButton(
        {
            x = 80,
            y = 50,    
            id = "btnPaper",
            label = "Paper",
            labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },    
            sheet = buttonSheet,
            defaultFrame = 1,
            overFrame = 2,
            onEvent = play,
            isEnabled = false,
        }
    )

    btnScissor = widget.newButton(
        {
            x = 80,
            y = 80,    
            id = "btnScissor",
            label = "Scissor",
            labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },    
            sheet = buttonSheet,
            defaultFrame = 1,
            overFrame = 2,
            onEvent = play,
            isEnabled = false,
        }
    )





    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    sceneGroup:insert( alex )
    sceneGroup:insert( parplin )
    sceneGroup:insert( btnGo )
    sceneGroup:insert( btnPaper )
    sceneGroup:insert( btnRock )
    sceneGroup:insert( btnScissor )

end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        parplin:play()
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