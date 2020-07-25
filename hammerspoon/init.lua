function manipulateFrame(cb)
    local win = hs.window.focusedWindow()
    local f = win:frame()

    cb(f)

    win:setFrame(f)
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", manipulateFrame(function(f)
    f.x = f.x - 10
end))

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "L", manipulateFrame(function()
    f.x = f.x + 10
end))

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "J", manipulateFrame(function()
    f.y = f.y - 10
end))

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "K", manipulateFrame(function()
    f.y = f.y + 10
end))

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", manipulateFrame(function()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
end))

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", manipulateFrame(function()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
end))

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", manipulateFrame(function()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h / 2
end))

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", manipulateFrame(function()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x
    f.y = max.y + (max.h / 2)
    f.w = max.w
    f.h = max.h / 2
end))

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", hs.reload)

hs.hotkey.bind({"cmd", "alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

-- First thing I've really done off my own back. Reads from Firefox Session restore
-- file, parses the total number of tabs, and lobs them in a menubar. Colours the menubar
-- red when we're over 100. 
-- That "when we're" clause is redundant.
openTabsBar = hs.menubar.new(true)
function updateOpenTabs()
    result = hs.execute(os.getenv("HOME") .. "/bin/get-open-tabs.sh", true)
    strippedResult = result:match( "(.-)%s*$" )
    TARGET = 100

    styled = hs.styledtext.new({
        "  " .. strippedResult .. "  ",
        tonumber(strippedResult) > TARGET and {
            starts = 2,
            attributes = {
                backgroundColor = { red = 1},
                color = { white = 1}
            }
        }
    })
    openTabsBar:setTitle(styled)
end

if openTabsBar then
    icon = [[ASCII:
    ............
    ............
    ............
    ..C......D..
    ............
    ............
    ............
    A.B......E.F
    H..........I
    K..........L
    ............
    ............]]
    openTabsBar:setIcon(icon)

    updateOpenTabs()

    profileFolder = "/Library/Application Support/Firefox/Profiles/lupwyej0.default-release/sessionstore-backups"
    profileWatcher = hs.pathwatcher.new(os.getenv("HOME") .. profileFolder, updateOpenTabs):start()
end

hs.alert.show("Config loaded")
