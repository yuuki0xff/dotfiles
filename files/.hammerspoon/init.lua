function callback(exitCode, stdOut, stdErr)
	if exitCode > 0 then
		local msg = string.format('code: %d\nout: %s\nerr: %s', exitCode, stdOut, stdErr)
		hs.alert.show(msg)
	end
end

function stream_callback(task, stdOut, stdErr)
	return true
end

function start_shell_command(command)
	pre_command = [[
		exec  >/tmp/.yabai-operations.stdout &&
		exec 2>/tmp/.yabai-operations.stderr &&
		exec 9>/tmp/.yabai-operations.lock &&
		set -x &&
		PATH=/opt/homebrew/bin:/usr/local/bin:$PATH &&
		flock 9 || exit $?;
		focus_follows_mouse="`yabai -m config focus_follows_mouse`" || exit $?;
		yabai -m config focus_follows_mouse off
	]]
	post_command = [[
		case "$focus_follows_mouse" in
			disabled)
				;;
			*)
				yabai -m config focus_follows_mouse "$focus_follows_mouse"
				;;
		esac
	]]
	script = table.concat({pre_command, command, post_command}, '\n')
	local task = hs.task.new('/bin/sh', callback, stream_callback, {'-c', script})
	task:start()
end

hs.hotkey.bind({'cmd'}, 'm', function()
	start_shell_command([[
		yabai -m window --minimize &&
		yabai -m window --focus mouse ||
		:
	]])
	-- hs.alert.show('focus prev')
end)

hs.hotkey.bind({'cmd'}, 'k', function()
	start_shell_command([[
		yabai -m window --focus prev ||
		yabai -m window --focus stack.prev ||
		yabai -m window --focus mouse ||
		:
	]])
	-- hs.alert.show('focus prev')
end)


hs.hotkey.bind({'cmd'}, 'j', function()
	start_shell_command([[
		yabai -m window --focus next ||
		yabai -m window --focus stack.next ||
		yabai -m window --focus mouse ||
		:
	]])
	-- hs.alert.show('focus next')
end)

hs.hotkey.bind({'cmd', 'shift'}, 'k', function()
	start_shell_command('yabai -m window --swap prev || :')
	-- hs.alert.show('move prev')
end)

hs.hotkey.bind({'cmd', 'shift'}, 'j', function()
	start_shell_command('yabai -m window --swap next || :')
	-- hs.alert.show('move next')
end)


hs.hotkey.bind({'cmd'}, 'h', function()
	start_shell_command([[
		yabai -m display --focus prev ||
		yabai -m display --focus last ||
		:
	]])

	-- hs.alert.show('move prev display')
end)


hs.hotkey.bind({'cmd'}, 'l', function()
	start_shell_command([[
		yabai -m display --focus next ||
		yabai -m display --focus first ||
		:
	]])
	-- hs.alert.show('move next display')
end)

hs.hotkey.bind({'cmd', 'shift'}, 'h', function()
	start_shell_command([[
		(
			yabai -m window --display prev &&
			yabai -m display --focus prev
		) || (
			yabai -m window --display last &&
			yabai -m display --focus last
		) || :
	]])
	-- hs.alert.show('move window to prev display')
end)


hs.hotkey.bind({'cmd', 'shift'}, 'l', function()
	start_shell_command([[
		(
			yabai -m window --display next &&
			yabai -m display --focus next
		) || (
			yabai -m window --display first &&
			yabai -m display --focus first
		) || :
	]])
	-- hs.alert.show('move window to next display')
end)


hs.hotkey.bind({'cmd'}, 'q', function()
	start_shell_command('yabai -m space --layout stack || :')
	-- hs.alert.show('stack mode')
end)

hs.hotkey.bind({'cmd'}, 'e', function()
	start_shell_command([[
		yabai -m config split_ratio 0.7
		yabai -m space --layout bsp || :
	]])
	-- hs.alert.show('bsp mode')
end)

hs.hotkey.bind({'cmd', 'shift'}, 'e', function()
	start_shell_command([[
		yabai -m config split_ratio 0.5
		yabai -m space --layout bsp || :
	]])
	-- hs.alert.show('bsp mode')
end)

--hs.hotkey.bind({'cmd'}, 'r', function()
--    start_shell_command([[
--        yabai -m config split_ratio 0.3
--        yabai -m space --layout bsp || :
--    ]])
--     hs.alert.show('bsp mode')
--end)

--hs.hotkey.bind({'cmd', 'shift'}, 'r', function()
--    hs.reload()
--end)
