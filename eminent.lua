----------------------------------------------------------------
-- Effortless wmii-style dynamic tagging.
----------------------------------------------------------------
-- Lucas de Vries <lucas@glacicle.org>
-- Licensed under the WTFPL version 2
--   * http://sam.zoy.org/wtfpl/COPYING
----------------------------------------------------------------
-- To use this module add:
--   require("eminent")
-- to the top of your rc.lua. 
--
-- That's it. Through magical monkey-patching, all you need to
-- do to start dynamic tagging is loading it.
--
-- Use awesome like you normally would, you don't need to
-- change a thing.
----------------------------------------------------------------

-- Grab environment
local ipairs = ipairs
local pairs = pairs
local ascreen = require("awful.screen")
local awful = require("awful")
local util = require("awful.util")
local table = table
local capi = {
    tag = tag,
    mouse = mouse,
    client = client,
    screen = screen,
    wibox = wibox,
    timer = timer,
    keygrabber = keygrabber,
}

local tag = require("awful.tag")


-- Eminent: Effortless wmii-style dynamic tagging
local eminent = {}

-- simply change the behavior of the filter will do the trick
awful.widget.taglist.filter.all = awful.widget.taglist.filter.noempty

-- However it still need to replace the original awful.tag.viewidx to only loop in the 
-- set of the non-empty tags
--
-- Return tags with stuff on them
local function gettags(screen)
    local tags = {}

    for k, t in ipairs(tag.gettags(screen)) do
        if t.selected or #t:clients() > 0 then
            table.insert(tags, t)
        end
    end

    return tags
end

awful.tag.viewidx = function (i, screen)
    local screen = screen or ascreen.focused()
    local tags = gettags(screen)
    local showntags = {}
    for k, t in ipairs(tags) do
        if not tag.getproperty(t, "hide") then
            table.insert(showntags, t)
        end
    end
    local sel = tag.selected(screen)
    tag.viewnone(screen)
    for k, t in ipairs(showntags) do
        if t == sel then
            showntags[util.cycle(#showntags, k + i)].selected = true
        end
    end
    capi.screen[screen]:emit_signal("tag::history::update")
end

return eminent

