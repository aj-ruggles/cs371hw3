--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:289f07cdbf1836c9b9b3de75df55b741:383600cf504f79df7d8f7b4c85ca3d8f:c2abd518c56de296da3531d6d2349491$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- janken-paper-01
            x=34,
            y=188,
            width=16,
            height=16,

            sourceX = 0,
            sourceY = 19,
            sourceWidth = 16,
            sourceHeight = 48
        },
        {
            -- janken-rock-03
            x=20,
            y=199,
            width=12,
            height=13,

            sourceX = 4,
            sourceY = 21,
            sourceWidth = 16,
            sourceHeight = 48
        },
        {
            -- janken-set-01
            x=2,
            y=150,
            width=30,
            height=47,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 31,
            sourceHeight = 48
        },
        {
            -- janken-shake-01
            x=2,
            y=2,
            width=38,
            height=47,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 40,
            sourceHeight = 48
        },
        {
            -- janken-shake-02
            x=2,
            y=51,
            width=35,
            height=47,

            sourceX = 4,
            sourceY = 1,
            sourceWidth = 40,
            sourceHeight = 48
        },
        {
            -- janken-scissor-02
            x=20,
            y=214,
            width=16,
            height=13,

            sourceX = 0,
            sourceY = 21,
            sourceWidth = 16,
            sourceHeight = 48
        },
        {
            -- janken-taunt-01
            x=2,
            y=100,
            width=30,
            height=48,

            sourceX = 10,
            sourceY = 0,
            sourceWidth = 40,
            sourceHeight = 48
        },
        {
            -- janken-taunt-02
            x=34,
            y=104,
            width=28,
            height=48,

            sourceX = 8,
            sourceY = 0,
            sourceWidth = 40,
            sourceHeight = 48
        },
        {
            -- parplin-paper-03
            x=34,
            y=188,
            width=16,
            height=16,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 16,
            sourceHeight = 32
        },
        {
            -- parplin-rock-01
            x=20,
            y=199,
            width=12,
            height=13,

            sourceX = 4,
            sourceY = 10,
            sourceWidth = 16,
            sourceHeight = 32
        },
        {
            -- parplin-set-01
            x=42,
            y=2,
            width=16,
            height=32,

        },
        {
            -- parplin-shake-01
            x=34,
            y=154,
            width=24,
            height=32,

        },
        {
            -- parplin-shake-02
            x=39,
            y=70,
            width=23,
            height=32,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 24,
            sourceHeight = 32
        },
        {
            -- parplin-scissor-02
            x=20,
            y=214,
            width=16,
            height=13,

            sourceX = 0,
            sourceY = 10,
            sourceWidth = 16,
            sourceHeight = 32
        },
        {
            -- parplin-taunt-01
            x=2,
            y=199,
            width=16,
            height=31,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 16,
            sourceHeight = 32
        },
        {
            -- parplin-taunt-02
            x=42,
            y=36,
            width=16,
            height=32,

        },
    },
    
    sheetContentWidth = 64,
    sheetContentHeight = 232
}

SheetInfo.frameIndex =
{

    ["janken-paper"] = 1,
    ["janken-rock"] = 2,
    ["janken-set"] = 3,
    ["janken-shake-01"] = 4,
    ["janken-shake-02"] = 5,
    ["janken-scissor"] = 6,
    ["janken-taunt-01"] = 7,
    ["janken-taunt-02"] = 8,
    ["parplin-paper"] = 9,
    ["parplin-rock"] = 10,
    ["parplin-set"] = 11,
    ["parplin-shake-01"] = 12,
    ["parplin-shake-02"] = 13,
    ["parplin-scissor"] = 14,
    ["parplin-taunt-01"] = 15,
    ["parplin-taunt-02"] = 16,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
