-- Restoring this classic, influenced by this blogpost: 
-- https://dopedesi.com/2021/08/10/i-closed-a-lot-of-browser-tabs/. Vivaldi, my current browser
-- of choice plays far nicer with JXA than Firefox, so can drop all the filewatching. 
-- Colours the menubar red when we're over 100. 
-- (That "when we're" clause is largely redundant.)

previousCount = -1
countDir = "-"

openTabsBar = hs.menubar.new(true)
function updateOpenTabs()
    bool, count, desc = hs.osascript.javascript([[
        const Vivaldi = new Application("/Applications/Vivaldi.app")
        let count = 0;

        if(Vivaldi.running())
        for (i in Vivaldi.windows) count += Vivaldi.windows[i].tabs.length;

        count
    ]])

    if count ~= previousCount then
        if count > previousCount and previousCount ~= -1 then
            countDir = "^"
        end
        if count < previousCount then
            countDir = "V"
        end

        previousCount = count
    end

    TARGET = 100
    styled = hs.styledtext.new({
        "  " .. count .. "  " .. countDir .. "  ",
        tonumber(count) > TARGET and {
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

    hs.timer.doEvery(3, updateOpenTabs)
end
