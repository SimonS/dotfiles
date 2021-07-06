function manipulateFrame(cb)
    return function()
        win = hs.window.focusedWindow()
        f = win:frame()

        cb(f)

        win:setFrame(f)
    end
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

function outlookToRoamMarkdown()
    status, object, descriptor = hs.osascript.javascriptFromFile('./lib/outlook-to-roam.js')
    hs.pasteboard.setContents(object)
    hs.alert.show("Agenda items copied to clipboard")
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "O", outlookToRoamMarkdown)
    
hs.alert.show("Config loaded")
