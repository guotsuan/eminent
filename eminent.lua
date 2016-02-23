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
local awful = require("awful")
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

-- Eminent: Effortless wmii-style dynamic tagging
local eminent = {}


-- simply change the behavior of the filter will do the trick
awful.widget.taglist.filter.all = awful.widget.taglist.filter.noempty

