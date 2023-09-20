local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- 起動シェルを設定
config.default_prog = { '/opt/homebrew/bin/fish', '-l' }
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false
-- カラースキーム
config.color_scheme = 'Dracula (Official)'
-- フォント
config.font = wezterm.font("Meslo LG L DZ for Powerline", {weight="Regular", stretch="Normal", style="Normal"})
config.font_size = 12
config.line_height = 1.2
config.use_ime = true
-- 背景透過
config.window_background_opacity = 0.9
-- キーバインド
local act = wezterm.action
config.disable_default_key_bindings = true
config.leader = { key = 'Space', mods = 'META', timeout_milliseconds = 1000 }
config.keys = {
    -- 隠す
    { key = "Space", mods = 'LEADER', action = act.HideApplication },
    -- フォントサイズ変更
    { key = "-", mods = 'CMD', action = act.DecreaseFontSize },
    { key = "=", mods = 'CMD', action = act.IncreaseFontSize },
    { key = "0", mods = 'CMD', action = act.ResetFontSize },
    -- ペイン分割
    { key = "/", mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = "-", mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    -- ペイン移動
    { key = "h", mods = 'LEADER', action = act.ActivatePaneDirection "Left" },
    { key = "j", mods = 'LEADER', action = act.ActivatePaneDirection "Down" },
    { key = "k", mods = 'LEADER', action = act.ActivatePaneDirection "Up" },
    { key = "l", mods = 'LEADER', action = act.ActivatePaneDirection "Right" },
    -- ペインのリサイズ
    { key = "H", mods = 'LEADER|SHIFT', action = act.AdjustPaneSize {'Left', 10} },
    { key = "J", mods = 'LEADER|SHIFT', action = act.AdjustPaneSize {'Down', 10} },
    { key = "K", mods = 'LEADER|SHIFT', action = act.AdjustPaneSize {'Up', 10} },
    { key = "L", mods = 'LEADER|SHIFT', action = act.AdjustPaneSize {'Right', 10} },
    -- ペインにズーム
    { key = "z", mods = 'LEADER', action = act.TogglePaneZoomState },
    -- タブを開閉
    { key = "t", mods = 'LEADER', action = act.SpawnTab "CurrentPaneDomain" },
    { key = "w", mods = 'LEADER', action = act.CloseCurrentTab { confirm = true } },
    -- タブを移動
    { key = "1", mods = 'LEADER', action = act.ActivateTab(0) },
    { key = "2", mods = 'LEADER', action = act.ActivateTab(1) },
    { key = "3", mods = 'LEADER', action = act.ActivateTab(2) },
    { key = "4", mods = 'LEADER', action = act.ActivateTab(3) },
    { key = "5", mods = 'LEADER', action = act.ActivateTab(4) },
    { key = "6", mods = 'LEADER', action = act.ActivateTab(5) },
    { key = "7", mods = 'LEADER', action = act.ActivateTab(6) },
    { key = "8", mods = 'LEADER', action = act.ActivateTab(7) },
    { key = "9", mods = 'LEADER', action = act.ActivateTab(-1) },
    { key = "[", mods = 'LEADER', action = act.ActivateTabRelative(-1) },
    { key = "]", mods = 'LEADER', action = act.ActivateTabRelative(1) },
    -- スクロール
    { key = "PageUp", mods = 'LEADER', action = act.ClearScrollback "ScrollbackOnly" },
    { key = "PageDown", mods = 'LEADER', action = act.ScrollByPage(1) },
    -- コピペ
    { key = "c", mods = 'CMD', action = act.CopyTo 'Clipboard' },
    { key = "v", mods = 'CMD', action = act.PasteFrom 'Clipboard' },
}

-- ========= ON =========
-- タブタイトルをフォーマット
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = wezterm.truncate_right(utils.basename(tab.active_pane.foreground_process_name), max_width)
	if title == "" then
		title = wezterm.truncate_right(
			utils.basename(utils.convert_home_dir(tab.active_pane.current_working_dir)),
			max_width
		)
	end
	return {
		{ Text = tab.tab_index + 1 .. ":" .. title },
	}
end)

-- ウィンドウを全画面で起動
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():toggle_fullscreen()
end)

return config