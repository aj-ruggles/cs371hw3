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
local level, attempt = 1, 1

-- wigetbuttons
local btnGo, btnRock, btnPaper, btnScissor, btnWin, btnLose, messageBox, textMessage, btnQuit

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


---------- DELETE  ---------------------------------------
-- this will make deleting things much easier.

local function delete(obj)
    if obj then obj:removeSelf(); obj = nil end
end

--================== Buttons to Change Scenes ===============--

-- delete all the message stuff and go to level 2
local function level2BtnListener( event )
    delete( messageBox )
    delete( textMessage )
    delete( btnWin )
    delete( btnLose ) 
    delete( btnQuit )
    composer.gotoScene( "level2", "fade", 800)
end

-- delete all the message stuff and go to level 1
local function level1BtnListener( event )
    delete( messageBox )
    delete( textMessage )
    delete( btnWin )
    delete( btnLose ) 
    delete( btnQuit )
    composer.gotoScene( "level1", "fade", 800)
end

-- delete all the message stuff and go to start screen
local function startScreenBtnListener( event )
    delete( messageBox )
    delete( textMessage )
    delete( btnWin )
    delete( btnLose ) 
    delete( btnQuit )
    composer.gotoScene( "startScreen", "fade", 800)
end

-- display a message at the end of the screen.
local function nextLevelMessage()
    attempt = attempt + 1
    messageBox = display.newRoundedRect( display.contentCenterX, display.contentCenterY, 200, 100, 5 )
    messageBox:setFillColor(.2,.2,.2,.4)
    textMessage = display.newText( "Hello, World", display.contentCenterX, display.contentCenterY, 100, 50, arial ,20 )
    -- you win 
    if alex.win > alex.lose then
        textMessage.text = "You Win"
        btnWin = widget.newButton(          -- contiune to next level
            {
                x = display.contentCenterX+50,
                y = display.contentCenterY+35,  
                id = "btnWin",
                label = "Continue",
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },    
                sheet = buttonSheet,
                defaultFrame = 1,
                overFrame = 2,
                onPress = level2BtnListener,
                isEnabled = true,
            }
        )
        btnQuit = widget.newButton(            -- quit and exit to start screen
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
        btnQuit = widget.newButton(             -- quit and exit to start screen 
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
        btnLose = widget.newButton(             -- retry the current level.
            {
                x = display.contentCenterX+50,
                y = display.contentCenterY+35,  
                id = "btnLose",
                label = "Retry",
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },    
                sheet = buttonSheet,
                defaultFrame = 1,
                overFrame = 2,
                onPress = level1BtnListener,
                isEnabled = true,
            }
        )
    end
end

--^^^^^^^^^^^^^^^^^ Buttons to Change Scenes ^^^^^^^^^^^^^^^--
--==================== Parplin Transitions ===================--

-- some forward declarations of the object assosiated with parplin
local playMove, playPreview, moveTable, playShake, playCount
playCount = 1; moveTable = {}
alexPlay = nil

local parplinPlayedHand


-- user played rock
local function alexPlayedRock( event )
    alexPlay = true
    alex.choice = 1
end

-- user played paper
local function alexPlayedPaper( event )
    alexPlay = true
    alex.choice = 2
end

-- user played scissor
local function alexPlayedScissor( event )
    alexPlay = true
    alex.choice = 3
end

-- display the user choice if clicked in time, to register. 
function playMove()
    parplinPlayedHand.alpha = 1
    parplinPlayedHand = display.newSprite (baddieSheet, seqDataParplin)
    parplinPlayedHand.x = display.contentCenterX+52
    parplinPlayedHand.y = display.contentCenterY+42
    parplin.anchorX = 1
    parplin.anchorY = 1


    if moveTable[playCount] == 1 and playCount <= 3 then 
         -- show parplin move and set the sequence
        transition.to(parplin, {time = 1500, onComplete=playShake})
        parplin:setSequence( "set" )
        parplin:play()

        parplinPlayedHand:setSequence( "rock" )
        parplinPlayedHand:play()

    elseif moveTable[playCount] == 2 and playCount <= 3 then
         -- show parplin move and set the sequence
        transition.to(parplin, {time = 1500, onComplete=playShake})
        parplin:setSequence( "set" )
        parplin:play()

        parplinPlayedHand:setSequence( "paper" )
        parplinPlayedHand:play()

    elseif moveTable[playCount] == 3 and playCount <= 3 then
         -- show parplin move and set the sequence
        transition.to(parplin, {time = 1500, onComplete=playShake})
        parplin:setSequence( "set" )
        parplin:play()

        parplinPlayedHand:setSequence( "scissor" )
        parplinPlayedHand:play()
    end

    --display alex kidd move, and calculate the win/lose
    --this implementation will also count a tie as a win for alex kidd....
    -- because he is the hero.
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
        -- if the user didnt play in time, play the loseing hand for alex kidd.
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
        alex.lose = alex.lose + 1           -- inc the lose
    end

    playCount = playCount + 1
end

function playShake()
    -- remove the last played hand from parplin
    if parplinPlayedHand then delete(parplinPlayedHand) end

    -- total number of hand to play is three
    if playCount > 3 then
        parplin:setSequence("taunt")    -- set parplin to taunt
        parplin:play()

        alex:setSequence("normal")
        alex:pause()                -- pause alex kidd
        alex:setFrame(2)            -- setup for replay and stop alex animation
        playCount = 1               -- setup for replay set playcount to 1

        transition.fadeOut( btnRock, { time=1000, onComplete=delete } )
        transition.fadeOut( btnPaper, { time=1000, onComplete=delete} )
        transition.fadeOut( btnScissor, { time=1000, onComplete=delete} )

        nextLevelMessage()
        --add what happens on a win or lose
    else 
        -- continue the play sequence and go to the next hand. 
        parplin:setSequence("shake")    -- shake for 1500ms
        parplin:play()

        alex:setSequence("shake")       -- shake for 1500ms
        alex:play()
        transition.to(parplin, {time = 1500, onComplete=playMove})
    end
end



function playPreview()
    -- create ai moves
    for i=1,3 do
        moveTable[i] = math.random(1,3) 
        -- add the hand to the screen as a preview above parplins head.
        local parplinHand = display.newSprite (baddieSheet, seqDataParplin)
        parplinHand.x = display.contentCenterX+42 + 16*(i-1)
        parplinHand.y = display.contentCenterY+15

        if (moveTable[i] == 1) then             -- show rock
            parplinHand:setSequence( "rock" )
            parplinHand:play()
        elseif (moveTable[i] == 2) then         -- show paper
            parplinHand:setSequence( "paper" )
            parplinHand:play()
        elseif (moveTable[i] == 3) then         -- show scissor
            parplinHand:setSequence( "scissor" )
            parplinHand:play()
        end

        -- after 5s remove and delete the preview.
        local handTimer = timer.performWithDelay(5000, function()
            delete(parplinHand)
        end, 1)
    end
    -- move to shake and start the play loop
    transition.to(parplin, {time = 5000, onComplete=playShake})
end

--==================== Parplin Transitions ===================--

-- play the walking animation
local function startWalking( event )
    alex:play()
    transition.fadeOut( btnGo, { time=1000, onComplete=delete } )
end

-- stop the waling animation and show preview
local function stopWalking( event )
    alex:pause()
    alex:setFrame(2)
    playPreview() -- show the preview
end


-- listener from the widget 
local function go( event )
    transition.to(alex, {time = 2500, x=135, onStart=startWalking, onComplete=stopWalking})
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
    alex.lose = 0       -- set the win/lose to 0
    alex.win = 0

    alex.anchorX = 0
    alex.anchorY = 1

    parplin = display.newSprite (baddieSheet, seqDataParplin)

    parplin.x = display.contentCenterX+75
    parplin.y = display.contentCenterY+58

    parplin.anchorX = 1
    parplin.anchorY = 1



    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    sceneGroup:insert( alex )
    sceneGroup:insert( parplin )


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
    -- add parplin to the sceneGroup and set alpha to 0
    parplinPlayedHand = display.newSprite (baddieSheet, seqDataParplin)
    parplinPlayedHand.alpha = 0

    -- reset alex kidds posistion back to start
    alex.x = display.contentCenterX-95
    alex.win = 0    --reset
    alex.lose = 0

    --insert everything
    sceneGroup:insert( btnGo )
    sceneGroup:insert( btnPaper )
    sceneGroup:insert( btnRock )
    sceneGroup:insert( btnScissor )
    sceneGroup:insert( parplinPlayedHand )

    elseif ( phase == "did" ) then
        parplin:play()
        local text = "level "..level.." Attempt "..attempt
        local title = display.newText( sceneGroup, text, display.contentCenterX, 15, 100, 30, monospaced, 5 )
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