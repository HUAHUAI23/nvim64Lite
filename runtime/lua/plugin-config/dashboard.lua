local status, db = pcall(require, "dashboard")
if not status then
	vim.notify("没有找到 dashboard")
	return
end
db.session_directory = vim.fn.stdpath("data") .. "/vimSession"
local luaPath = require("commConf").sharePath .. "/xray23/lua"
-- it will auto-save the current session on neovim exit if a session exists and more than one buffer is loaded
-- db.session_auto_save_on_exit = true
-- Example: Close NvimTree buffer before auto-saving the current session
-- local autocmd = vim.api.nvim_create_autocmd
-- autocmd("User", {
-- 	pattern = "DBSessionSavePre",
-- 	callback = function()
-- 		pcall(vim.cmd, "NvimTreeClose")
-- 	end,
-- })
db.custom_footer = {
	-- "",
	"千里之行，始于足下                     ",
	-- "https://xray23.ltd                     ",
	-- "https://github.com/HUAHUA              ",
}
db.custom_center = {
	{
		icon = "🗃️  ",
		desc = "Projects                            ",
		action = "Telescope projects",
	},
	{
		-- icon = "📎  ",
		icon = "☕  ",
		desc = "Work Space                          ",
		-- action = "exe 'normal melloworld'",
		action = "Telescope xray23 list",
	},
	{
		-- icon = "📎  ",
		icon = "📺  ",
		desc = "Recently files                      ",
		action = "Telescope oldfiles",
	},
	{
		icon = "🔍️  ",
		desc = "Find file                           ",
		action = "Telescope find_files",
	},
	{
		icon = "📄  ",
		desc = "New file                           ",
		action = "DashboardNewFile",
	},
	{
		-- icon = "📑  ",
		icon = "🕹️  ",
		desc = "Edit keybindings                    ",
		action = "edit" .. luaPath .. "/keybindingAlias.lua",
	},
	{
		icon = "📻  ",
		desc = "Edit Projects                       ",
		action = "edit ~/.local/share/nvim/project_nvim/project_history",
	},
	-- {
	--   icon = "  ",
	--   desc = "Edit .bashrc                        ",
	--   action = "edit ~/.bashrc",
	-- },
	-- {
	--   icon = "  ",
	--   desc = "Change colorscheme                  ",
	--   action = "ChangeColorScheme",
	-- },
	-- {
	--   icon = "  ",
	--   desc = "Edit init.lua                       ",
	--   action = "edit ~/.config/nvim/init.lua",
	-- },
	-- {
	--   icon = "  ",
	--   desc = "Find file                           ",
	--   action = "Telescope find_files",
	-- },
	-- {
	--   icon = "  ",
	--   desc = "Find text                           ",
	--   action = "Telescopecope live_grep",
	-- },
}

db.custom_header = {
	[[]],
	[[███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
	[[████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
	[[██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
	[[██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
	[[██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
	[[╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
}
-- db.custom_header = {
-- 	-- [[]],
-- 	[[██╗░░██╗██╗░░░██╗░█████╗░██╗░░██╗██╗░░░██╗░█████╗░]],
-- 	[[██║░░██║██║░░░██║██╔══██╗██║░░██║██║░░░██║██╔══██╗]],
-- 	[[███████║██║░░░██║███████║███████║██║░░░██║███████║]],
-- 	[[██╔══██║██║░░░██║██╔══██║██╔══██║██║░░░██║██╔══██║]],
-- 	[[██║░░██║╚██████╔╝██║░░██║██║░░██║╚██████╔╝██║░░██║]],
-- 	[[╚═╝░░╚═╝░╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝░╚═════╝░╚═╝░░╚═╝]],
-- 	[[]],
-- }
-- 👻 🎵 🔔 🤖 🚑 ☕ 💦 ☔
-- see more: https://fsymbols.com/
-- https://fsymbols.com/text-art/twitter/
-- db.custom_header = {
-- 	[[]],
-- 	[[▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒]],
-- 	[[▒▒▄▄▄▒▒▒█▒▒▒▒▄▒▒▒▒▒▒▒▒▒▒▄▄▄▒▒▒█▒▒▒▒▄▒▒▒▒▒▒▒▒]],
-- 	[[▒█▀█▀█▒█▀█▒▒█▀█▒▄███▄▒▒█▀█▀█▒█▀█▒▒█▀█▒▄███▄▒]],
-- 	[[░█▀█▀█░█▀██░█▀█░█▄█▄█░░█▀█▀█░█▀██░█▀█░█▄█▄█░]],
-- 	[[░█▀█▀█░█▀████▀█░█▄█▄█░░█▀█▀█░█▀████▀█░█▄█▄█░]],
-- 	[[████████▀█████████████████████▀█████████████]],
-- 	[[]],
-- }
