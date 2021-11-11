function outlookToRoamMarkdown()
    status, object, descriptor = hs.osascript.javascriptFromFile('./outlook-to-roam.js')
    hs.pasteboard.setContents(object)
    hs.alert.show("Agenda items copied to clipboard")
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "O", outlookToRoamMarkdown)
