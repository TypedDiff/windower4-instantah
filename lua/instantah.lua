_addon.name = 'instantah'
_addon.author = 'TypedDiff'
_addon.version = '1.0.0'
_addon.commands = { }

local addon_path = windower.addon_path:gsub('\\', '/')	
package.cpath = package.cpath .. ';' .. addon_path .. '/libs/?.dll'
require('memorylib')

local instantah = { };
instantah.pattern = '668BC1B9????????0FAFC233D2F7F1'
instantah.pointer = memorylib.findPattern('FFXiMain.dll', instantah.pattern);

local function msg(s)
    local txt = '[InstantAH] ' .. s;
    print(txt);
end

windower.register_event('load', function()
    if (instantah.pointer == 0) then
        msg('Failed to find required pointer.');
        return;
    end

    memorylib.write_uint8(instantah.pointer + 0x27, 0xEB);
    msg('Function patched; auction results should now be instant.');
end)

windower.register_event('unload', function()
    if (instantah.pointer ~= 0) then
        memorylib.write_uint8(instantah.pointer + 0x27, 0x74);
    end
end)