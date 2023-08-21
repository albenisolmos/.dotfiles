local dpi = require('beautiful').xresources.apply_dpi

return {
	theme = 'dark',
    highlight = '#A6E9FF',
	titlebar_style = 'windows',
	titlebar_height = dpi(35),
	wallpaper = nil,
	icon_user = nil,
	dock = true,
	dock_hide = 'needed',
	dock_bg_solid = false,
	dock_gap = dpi(10),
	dock_position = 'bottom',
	wibar_tasklist = false,
	wibar_bg_solid = false,
	wibar_hide_on_maximized = true,
	wibar_invade_on_maximized = false,
	wibar_autohide = false,
	wibar_height = dpi(24),
	wibar_position = 'bottom',
	wibox_test_visible = false,
	test = false,
	client_border_width = dpi(1),
	client_rounded_corners = dpi(15),
	client_shape = dpi(15),
	client_rounded_corner_on_maximized = dpi(0),
	client_shape_on_maximized = dpi(0),
	client_size_hints_honor = true,
	switcher_preview = false,
	volumen_indicator = true,
	web_browser = 'chromium',
	music_player = 'lollypop',
	terminal = 'alacritty',
	launcher = 'rofi -show drun',
	manager_network = 'wicd-gtk',
	manager_package = 'synaptic-pkexec',
	manager_sound = 'pavucontrol',
	shell = '/bin/bash',
	modkey = 'Mod4',
	cmd_vol_up = '',
	cmd_vol_down = '',
	cmd_player_play = '',
	cmd_player_pause = 'dbus-send --print-reply --dest=org.gnome.Lollypop /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause',
	once_spawn = {
		'albert',
		'bash -c "~/.local/bin/imap 2"',
		'/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1'
	}
}