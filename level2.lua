local composer = require( "composer" )
local widget = require( "widget" )
local sheetInfo = require( "sheet" )
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here
-- characters
local alex, janken
local level, attempt = 2, 1

-- wigetbuttons
local btnGo, btnRock, btnPaper, btnScissor, btnWin, btnLose, btnRetry, messageBox, textMessage, btnQuit

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

---------- janken  ---------------------------------------


local baddieSheet = graphics.newImageSheet( "res/chars.png", sheetInfo:getSheet() )

-- Create animation sequence janken
local seqDatajanken = {
    {name = "taunt", frames={7,8}, time = 500},
    {name = "shake", frames={4,5}, time = 500},    
    {name = "set", frames={3}, time = 10, loopCount=1}, 
    {name = "rock", frames={2}, time = 5000},  
    {name = "paper", frames={1}, time = 5000},
    {name = "scissor", frames={6}, time = 5000},      
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


local function delete(obj)
    if obj then obj:removeSelf(); obj = nil end
end

--================== Buttons to Change Scenes ===============--

local function level2BtnListener( event )
    delete( messageBox )
    delete( textMessage )
    delete( btnWin )
    delete( btnLose ) 
    delete( btnQuit )
    delete( btnRetry )
    composer.gotoScene( "level2", "fade", 800)
end

local function level1BtnListener( event )
    delete( messageBox )
    delete( textMessage )
    delete( btnWin )
    delete( btnLose ) 
    delete( btnQuit )
    delete( btnRetry )
    composer.gotoScene( "level1", "fade", 800)
end

local function startScreenBtnListener( event )
    delete( messageBox )
    delete( textMessage )
    delete( btnWin )
    delete( btnLose ) 
    delete( btnQuit )
    delete( btnRetry )
    composer.gotoScene( "startScreen", "fade", 800)
end

local function creditsBtnListener( event )
    delete( messageBox )
    delete( textMessage )
    delete( btnWin )
    delete( btnLose ) 
    delete( btnQuit )
    delete( btnRetry )
    composer.gotoScene( "gameCredits", "fade", 800)
end

local function nextLevelMessage()
    attempt = attempt + 1
    messageBox = display.newRoundedRect( display.contentCenterX, display.contentCenterY, 200, 100, 5 )
    messageBox:setFillColor(.2,.2,.2,.4)
    textMessage = display.newText( "Hello, World", display.contentCenterX, display.contentCenterY, 100, 50, arial ,20 )
    if alex.win > alex.lose then
        textMessage.text = "You Win"
        btnWin = widget.newButton(
            {
                x = display.contentCenterX+50,
                y = display.contentCenterY+35,  
                id = "btnWin",
                label = "Credits",
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },    
                sheet = buttonSheet,
                defaultFrame = 1,
                overFrame = 2,
                onPress = creditsBtnListener,
                isEnabled = true,
            }
        )
        btnQuit = widget.newButton(
            {
                x = display.contentCenterX-50,
                y = display.contentCenterY+35,  
                id = "btnLose",
                label = "Quit",
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },    
                sheet = buttonSheet,
                defaultFrame = 1,
                overFrame = 2,
                onPress = startScreenBtnListener,
                isEnabled = true,
            }
        )
    else 
        textMessage.text = "You Lose"
        btnQuit = widget.newButton(
            {
                x = display.contentCenterX-50,
                y = display.contentCenterY+35,  
                id = "btnLose",
                label = "Quit",
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },    
                sheet = buttonSheet,
                defaultFrame = 1,
                overFrame = 2,
                onPress = startScreenBtnListener,
                isEnabled = true,
            }
        )
        btnLose = widget.newButton(
            {
                x = display.contentCenterX+50,
                y = display.contentCenterY+10,  
                id = "btnLose",
                label = "Retry 1",
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },    
                sheet = buttonSheet,
                defaultFrame = 1,
                overFrame = 2,
                onPress = level1BtnListener,
                isEnabled = true,
            }
        )
        btnRetry = widget.newButton(
            {
                x = display.contentCenterX+50,
                y = display.contentCenterY+35,  
                id = "btnRetry",
                label = "Retry 2",
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },    
                sheet = buttonSheet,
                defaultFrame = 1,
                overFrame = 2,
                onPress = level2BtnListener,
                isEnabled = true,
            }
        )
    end
end

--^^^^^^^^^^^^^^^^^ Buttons to Change Scenes ^^^^^^^^^^^^^^^--
--==================== janken Transitions ===================--
local playMove, playPreview, moveTable, playShake, playCount
playCount = 1; moveTable = {}
alexPlay = nil

local jankenPlayedHand

local function alexPlayedRock( event )
    alexPlay = true
    alex.choice = 1
end

local function alexPlayedPaper( event )
    alexPlay = true
    alex.choice = 2
end

local function alexPlayedScissor( event )
    alexPlay = true
    alex.choice = 3
end


function playMove()
    jankenPlayedHand = display.newSprite (baddieSheet, seqDatajanken)
    jankenPlayedHand.x = display.contentCenterX+37
    jankenPlayedHand.y = display.contentCenterY+34
    janken.anchorX = 1
    janken.anchorY = 1

    if moveTable[playCount] == 1 and playCount <= 5 then 
        transition.to(janken, {time = 1500, onComplete=playShake})
        janken:setSequence( "set" )
        janken:play()

        jankenPlayedHand:setSequence( "rock" )
        jankenPlayedHand:play()

    elseif moveTable[playCount] == 2 and playCount <= 5 then
        transition.to(janken, {time = 1500, onComplete=playShake})
        janken:setSequence( "set" )
        janken:play()

        jankenPlayedHand:setSequence( "paper" )
        jankenPlayedHand:play()

    elseif moveTable[playCount] == 3 and playCount <= 5 then
        transition.to(janken, {time = 1500, onComplete=playShake})
        janken:setSequence( "set" )
        janken:play()

        jankenPlayedHand:setSequence( "scissor" )
        jankenPlayedHand:play()
    end

    if alexPlay then
        alexPlay = false
        if alex.choice == 1 then         
            alex:setSequence("rock")
            alex:play()
            if moveTable[playCount] == 2 then alex.lose = alex.lose + 1 else alex.win = alex.win + 1 end
        elseif alex.choice == 2 then      
            alex:setSequence("paper")
            alex:play()
            if moveTable[playCount] == 3 then alex.lose = alex.lose + 1 else alex.win = alex.win + 1 end
        elseif alex.choice == 3 then           
            alex:setSequence("scissor")
            alex:play()
            if moveTable[playCount] == 1 then alex.lose = alex.lose + 1 else alex.win = alex.win + 1 end
        end
    else
        alexPlay = false
        if moveTable[playCount] == 1 then          
            alex:setSequence("scissor")
            alex:play()
        elseif moveTable[playCount] == 2 then      
            alex:setSequence("rock")
            alex:play()
        else                                       
            alex:setSequence("paper")
            alex:play()
        end
        alex.lose = alex.lose + 1
    end

    playCount = playCount + 1
end

function playShake()
    if jankenPlayedHand then delete(jankenPlayedHand) end
    if playCount > 5 then
        janken:setSequence("taunt")
        janken:play()

        alex:setSequence("normal")
        alex:pause()
        alex:setFrame(2)
        playCount = 1

        transition.fadeOut( btnRock, { time=1000, onComplete=delete } )
        transition.fadeOut( btnPaper, { time=1000, onComplete=delete} )
        transition.fadeOut( btnScissor, { time=1000, onComplete=delete} )

        nextLevelMessage()
        --add what happens on a win or lose
    else 

        janken:setSequence("shake")
        janken:play()

        alex:setSequence("shake")
        alex:play()
        transition.to(janken, {time = 1500, onComplete=playMove})
    end
end


function playPreview()
    for i=1,5 do
        moveTable[i] = math.random(1,3) 
        local jankenHand = display.newSprite (baddieSheet, seqDatajanken)
        jankenHand.x = display.contentCenterX+30 + 16*(i-1)
        jankenHand.y = display.contentCenterY


        if (moveTable[i] == 1) then
            jankenHand:setSequence( "rock" )
            jankenHand:play()
        elseif (moveTable[i] == 2) then
            jankenHand:setSequence( "paper" )
            jankenHand:play()
        elseif (moveTable[i] == 3) then
            jankenHand:setSequence( "scissor" )
            jankenHand:play()
        end

        local handTimer = timer.performWithDelay(3000, function()
            delete(jankenHand)
        end, 1)
    end
    transition.to(janken, {time = 3000, onComplete=playShake})
end

--==================== janken Transitions ===================--

local function startWalking( event )
    alex:play()
    transition.fadeOut( btnGo, { time=1000, onComplete=delete } )
end

local function stopWalking( event )
    alex:pause()
    alex:setFrame(2)
    playPreview()
end

local function go( event )
    transition.to(alex, {time = 1900, x=120, onStart=startWalking, onComplete=stopWalking})
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
    alex.lose = 0
    alex.win = 0

    alex.anchorX = 0
    alex.anchorY = 1

    janken = display.newSprite (baddieSheet, seqDatajanken)

    janken.x = display.contentCenterX+75
    janken.y = display.contentCenterY+58

    janken.anchorX = 1
    janken.anchorY = 1



    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    sceneGroup:insert( alex )
    sceneGroup:insert( janken )


end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
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
            alpha = 0,
            onPress = go,
        }
    )
    btnGo.param = sceneGroup

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
            onPress = alexPlayedRock,
            isEnabled = true,
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
            onPress = alexPlayedPaper,
            isEnabled = true,
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
            onPress = alexPlayedScissor,
            isEnabled = true,
        }
    )
    jankenPlayedHand = display.newSprite (baddieSheet, seqDatajanken)
    jankenPlayedHand.alpha = 0
    alex.x = display.contentCenterX-95
    alex.win = 0
    alex.lose = 0


    sceneGroup:insert( btnGo )
    sceneGroup:insert( btnPaper )
    sceneGroup:insert( btnRock )
    sceneGroup:insert( btnScissor )
    sceneGroup:insert( jankenPlayedHand )

    elseif ( phase == "did" ) then
        janken:play()
        local text = "level "..level.." Attempt "..attempt
        local title = display.newText( sceneGroup, text, display.contentCenterX, 15, 100, 30, arial, 5 )
        title:setFillColor( 0,0,0 )
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