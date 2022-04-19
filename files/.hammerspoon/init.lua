function callback(exitCode, stdOut, stdErr)
	if exitCode > 0 then
		local msg = string.format('code: %d\nout: %s\nerr: %s', exitCode, stdOut, stdErr)
		hs.alert.show(msg)
	end
end

function stream_callback(task, stdOut, stdErr)
	return true
end

function start_shell_command(shell)
	local task = hs.task.new('/bin/sh', callback, stream_callback, {'-c', shell})
	task:start()
end

hs.hotkey.bind({'cmd'}, 'm', function()
	start_shell_command([[
		/usr/local/bin/yabai -m window --minimize &&
		/usr/local/bin/yabai -m window --focus mouse ||
		:
	]])
	-- hs.alert.show('focus prev')
end)

hs.hotkey.bind({'cmd'}, 'k', function()
	start_shell_command([[
		/usr/local/bin/yabai -m window --focus prev ||
		/usr/local/bin/yabai -m window --focus stack.prev ||
		/usr/local/bin/yabai -m window --focus mouse ||
		:
	]])
	-- hs.alert.show('focus prev')
end)


hs.hotkey.bind({'cmd'}, 'j', function()
	start_shell_command([[
		/usr/local/bin/yabai -m window --focus next ||
		/usr/local/bin/yabai -m window --focus stack.next ||
		/usr/local/bin/yabai -m window --focus mouse ||
		:
	]])
	-- hs.alert.show('focus next')
end)

hs.hotkey.bind({'cmd', 'shift'}, 'k', function()
	start_shell_command('/usr/local/bin/yabai -m window --swap prev || :')
	-- hs.alert.show('move prev')
end)

hs.hotkey.bind({'cmd', 'shift'}, 'j', function()
	start_shell_command('/usr/local/bin/yabai -m window --swap next || :')
	-- hs.alert.show('move next')
end)


hs.hotkey.bind({'cmd'}, 'h', function()
	start_shell_command('/usr/local/bin/yabai -m display --focus prev || :')
	-- hs.alert.show('move prev display')
end)


hs.hotkey.bind({'cmd'}, 'l', function()
	start_shell_command('/usr/local/bin/yabai -m display --focus next || :')
	-- hs.alert.show('move next display')
end)

hs.hotkey.bind({'cmd', 'shift'}, 'h', function()
	start_shell_command([[
		/usr/local/bin/yabai -m window --display prev &&
		/usr/local/bin/yabai -m display --focus prev ||
		:
	]])
	-- hs.alert.show('move window to prev display')
end)


hs.hotkey.bind({'cmd', 'shift'}, 'l', function()
	start_shell_command([[
		/usr/local/bin/yabai -m window --display next &&
		/usr/local/bin/yabai -m display --focus next ||
		:
	]])
	-- hs.alert.show('move window to next display')
end)


hs.hotkey.bind({'cmd'}, 'q', function()
	start_shell_command('/usr/local/bin/yabai -m space --layout stack || :')
	-- hs.alert.show('stack mode')
end)

hs.hotkey.bind({'cmd'}, 'e', function()
	start_shell_command([[
		/usr/local/bin/yabai -m config split_ratio 0.7
		/usr/local/bin/yabai -m space --layout bsp || :
	]])
	-- hs.alert.show('bsp mode')
end)

hs.hotkey.bind({'cmd', 'shift'}, 'e', function()
	start_shell_command([[
		/usr/local/bin/yabai -m config split_ratio 0.5
		/usr/local/bin/yabai -m space --layout bsp || :
	]])
	-- hs.alert.show('bsp mode')
end)

--hs.hotkey.bind({'cmd'}, 'r', function()
--    start_shell_command([[
--        /usr/local/bin/yabai -m config split_ratio 0.3
--        /usr/local/bin/yabai -m space --layout bsp || :
--    ]])
--     hs.alert.show('bsp mode')
--end)

--hs.hotkey.bind({'cmd', 'shift'}, 'r', function()
--    hs.reload()
--end)
