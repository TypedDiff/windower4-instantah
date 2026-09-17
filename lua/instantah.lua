_addon.name = 'instantah'
_addon.author = 'TypedDiff'
_addon.version = '1.0.0'
_addon.commands = { }

local addon_path = windower.addon_path:gsub('\\', '/')	
package.cpath = package.cpath .. ';' .. addon_path .. '/libs/?.dll'
require('MemoryLib')

local instantah = { };
instantah.pattern = '668BC1B9????????0FAFC233D2F7F1'
instantah.pointer = MemoryLib.findPattern('FFXiMain.dll', instantah.pattern);

local nolock = { };
nolock.pattern = '66FF81????????66C781????????0807C3'
nolock.pointer = MemoryLib.findPattern('FFXiMain.dll', nolock.pattern)

local function msg(s)
    local txt = '[InstantAH] ' .. s;
    print(txt);
end

windower.register_event('load', function()
    if (instantah.pointer == 0) then
        msg('Failed to find required pointer.');
        return;
    end

    MemoryLib.write_uint8(instantah.pointer + 0x27, 0xEB);
    msg('Function patched; auction results should now be instant.');

    if (nolock.pointer == 0) then
        msg('Failed to find required pointer.');
        return;
    end

    for i = 0,6
    do
        MemoryLib.write_uint8(nolock.pointer + i, 0x90);
    end

    msg('NoLock function patched; should no longer be locked during disengage');
end)

windower.register_event('unload', function()
    if (instantah.pointer ~= 0) then
        MemoryLib.write_uint8(instantah.pointer + 0x27, 0x74);
    end
end)