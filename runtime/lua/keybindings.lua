-- TODO: -- magic search indepent switch
--
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

--  vim.keymap.set  vim.api.nvim_set_keymap  vim.api.nvim_buf_set_keymap
--  详细见: https://github.com/glepnir/nvim-lua-guide-zh

local keybind = {}
local keybindingAlias = require("keybindingAlias")

local commConf = require("commConf")

local inser = keybindingAlias.insert
local norl = keybindingAlias.norl
local visul = keybindingAlias.visul
local cmand = keybindingAlias.cmand
-- plugins
local nvimTree = keybindingAlias.nvimTree
local bufferline = keybindingAlias.bufferline
local telesp = keybindingAlias.telescope
local yankyy = keybindingAlias.yanky
local commment = keybindingAlias.comment
local hoppp = keybindingAlias.hop
local toggletermm = keybindingAlias.toggerterm

-- leader key
vim.g.mapleader = keybindingAlias.leader_key
vim.g.maplocalleader = keybindingAlias.leader_key

-- register keymap
function keybind.register_keymap(keymap)
	local opts
	if keymap.opts then
		opts = vim.tbl_extend("force", { noremap = true, silent = true }, keymap.opts)
	else
		opts = { noremap = true, silent = true }
	end
	opts.desc = keymap.description
	if keymap.bufnr then
		if type(keymap.mode) == "string" then
			vim.api.nvim_buf_set_keymap(keymap.bufnr, keymap.mode, keymap.lhs, keymap.rhs, opts)
		else
			for _, mode in ipairs(keymap.mode) do
				vim.api.nvim_buf_set_keymap(keymap.bufnr, mode, keymap.lhs, keymap.rhs, opts)
			end
		end
	else
		if type(keymap.mode) == "string" then
			vim.api.nvim_set_keymap(keymap.mode, keymap.lhs, keymap.rhs, opts)
		else
			for _, mode in ipairs(keymap.mode) do
				vim.api.nvim_set_keymap(mode, keymap.lhs, keymap.rhs, opts)
			end
		end
	end
end

function keybind.bulk_register_keymaps(group_keymap)
	for _, keymap in ipairs(group_keymap) do
		keybind.register_keymap(keymap)
	end
end

keybind.unsetmap = {
	n = {
		keybindingAlias.telescope.find_files,
		"s",
		"u",
		"p",
		norl.go_left35,
		norl.go_right35,
		norl.goto_command_mode,
		norl.quit_buffer,
	},
	i = { inser.goto_command_mode },
	v = { visul.goto_command_mode },
}

keybind.editorInsert = {
	{ mode = "i", lhs = inser.goto_command_mode, rhs = [[<Esc>:]], opts = { silent = false } },
	-- { mode = "i", lhs = inser.goto_normal_mode, rhs = [[<Esc>]], opts = { silent = false } },
}

keybind.editorNormal = {
	-- goto command mode
	{ mode = "n", lhs = norl.goto_command_mode, rhs = [[:]], opts = { silent = false } },
	-- undo
	{ mode = "n", lhs = norl.undo, rhs = [[u]], opts = { silent = false } },
	-- paste
	{ mode = "n", lhs = norl.paste, rhs = [[p]], opts = { silent = false } },
	-- switch ctrl-i and ctrl-o
	-- FIX:
	-- { mode = "n", lhs = [[<C-o]], rhs = [[<C-i>]], opts = { silent = false } },
	-- { mode = "n", lhs = [[<C-i]], rhs = [[<C-o>]], opts = { silent = false } },

	-- go and out paste mode
	{
		mode = "n",
		lhs = norl.goto_paste_mode,
		rhs = [[:set paste<cr>]],
		opts = { silent = false },
		description = "goto paste mode",
	},
	{
		mode = "n",
		lhs = norl.exit_paste_mode,
		rhs = [[:set nopaste<CR>]],
		opts = { silent = false },
		description = "exit paste mode",
	},
	-- jumps
	{ mode = "n", lhs = norl.go_left35, rhs = [[35h]] },
	{ mode = "n", lhs = norl.go_right35, rhs = [[35l]] },
	{
		mode = "n",
		lhs = norl.go_up_10line,
		rhs = [[10k]],
	},
	{
		mode = "n",
		lhs = norl.go_down_10line,
		rhs = [[10j]],
	},
	{
		mode = "n",
		lhs = norl.go_down_5line,
		rhs = [[5j]],
	},
	{
		mode = "n",
		lhs = norl.go_up_5line,
		rhs = [[5k]],
	},
	-- buffer behavior
	{
		mode = "n",
		lhs = norl.quit_buffer,
		rhs = [[:bd<CR>]],
		opts = { silent = false },
		description = "close buffer",
	},
	{
		mode = "n",
		lhs = norl.save_buffer,
		rhs = [[<cmd>w<CR>]],
		opts = { silent = false },
		description = "save buffer",
	},
	{
		mode = "n",
		lhs = norl.saveALL_and_exitALL,
		rhs = [[:wa<CR>:q<CR>]],
		opts = { silent = false },
		description = "save all and exit all",
	},
	{
		mode = "n",
		lhs = norl.quit_without_save,
		rhs = [[:qa!<CR>]],
		opts = { silent = false },
		description = "exit all without save",
	},
	-- window behavior
	{
		mode = "n",
		lhs = norl.quit_window,
		rhs = [[:q<CR>]],
		opts = { silent = false },
		description = "close window",
	},
	{
		mode = "n",
		lhs = norl.horizontal_split,
		rhs = [[:sp<CR>]],
		opts = { silent = false },
		description = "horizontal_split window",
	},
	{
		mode = "n",
		lhs = norl.vertical_split,
		rhs = [[:vsp<CR>]],
		opts = { silent = false },
		description = "vertical_split window",
	},
	-- window jumps
	{
		mode = "n",
		lhs = norl.window_left,
		rhs = [[<C-w>h]],
	},
	{
		mode = "n",
		lhs = norl.window_down,
		rhs = [[<C-w>j]],
	},
	{
		mode = "n",
		lhs = norl.window_up,
		rhs = [[<C-w>k]],
	},
	{
		mode = "n",
		lhs = norl.window_right,
		rhs = [[<C-w>l]],
	},
	{
		mode = "n",
		lhs = norl.goto_window_sequence,
		rhs = [[<C-w><C-w>]],
	},
	-- adjust window size
	{
		mode = "n",
		lhs = norl.move_2up,
		rhs = [[:res +2<CR>]],
		opts = { silent = false },
		description = "move the window up +2",
	},
	{
		mode = "n",
		lhs = norl.move_2down,
		rhs = [[:res -2<CR>]],
		opts = { silent = false },
		description = "move the window down +2",
	},
	{
		mode = "n",
		lhs = norl.move_2left,
		rhs = [[:vertical resize-2<CR>]],
		opts = { silent = false },
		description = "move the window left +2",
	},
	{
		mode = "n",
		lhs = norl.move_2right,
		rhs = [[:vertical resize+2<CR>]],
		opts = { silent = false },
		description = "move the window right +2",
	},
	{
		mode = "n",
		lhs = norl.move_resize,
		rhs = [[<C-w>=]],
		opts = { silent = false },
		description = "restore the window size",
	},
	-- open terminal
	{
		mode = "n",
		lhs = norl.term_horizontal_split,
		rhs = [[:sp | terminal<CR>]],
		opts = { silent = false },
		description = "open terminal horizontal split",
	},
	{
		mode = "n",
		lhs = norl.term_vertical_split,
		rhs = [[:vsp | terminal<CR>]],
		opts = { silent = false },
		description = "open terminal vertical split",
	},
}

-- NOTE: visual mode keybindings
keybind.editorVisual = {
	-- goto command mode
	{
		mode = "v",
		lhs = visul.goto_command_mode,
		rhs = [[:]],
		opts = { silent = false },
	},
	-- jumps
	{
		mode = "v",
		lhs = visul.go_down_5line,
		rhs = [[5j]],
	},
	{
		mode = "v",
		lhs = visul.go_up_5line,
		rhs = [[5k]],
	},
	-- copy to sys clipboard
	{
		mode = "v",
		lhs = visul.cp_to_sysClipboard,
		rhs = [["+y]],
		opts = { silent = false },
		description = "copy to sys clipboard",
	},
}

-- NOTE: command mode keybindings
keybind.editorCommand = {
	{
		mode = "c",
		lhs = cmand.select_next,
		rhs = [[<C-n>]],
	},
	{
		mode = "c",
		lhs = cmand.select_pre,
		rhs = [[<C-p>]],
	},
}

-- NOTE: terminal mode keybindings

-- -------------------
-- plugin keybindings

-- nvimTree
keybind.nvimTree = {
	{
		mode = "n",
		lhs = nvimTree.NvimTreeToggle,
		rhs = [[:NvimTrr<CR>]],
		description = "nvim-tree toggle",
	},
}

keybind.undotree = {
	{
		mode = "n",
		lhs = keybindingAlias.undotree.UndotreeToggle,
		rhs = [[<cmd>Ut<CR>]],
		description = "undotree toggle",
	},
}
keybind.outline = {
	{
		mode = "n",
		lhs = keybindingAlias.lsp.outline,
		rhs = [[<cmd>LSoutline<CR>]],
		description = "outline toggle",
	},
}

keybind.bufferline = {
	{
		mode = "n",
		lhs = bufferline.BufferLineCyclePrev,
		rhs = [[:BufferLineCyclePrev<CR>]],
		description = "bufferline-goto left buffer",
	},
	{
		mode = "n",
		lhs = bufferline.BufferLineCycleNext,
		rhs = [[:BufferLineCycleNext<CR>]],
		description = "bufferline-goto right buffer",
	},
	{
		mode = "n",
		lhs = bufferline.BufferLineMovePrev,
		rhs = [[:BufferLineMovePrev<CR>]],
		description = "bufferline-move buffer left",
	},
	{
		mode = "n",
		lhs = bufferline.BufferLineMoveNext,
		rhs = [[:BufferLineMoveNext<CR>]],
		description = "bufferline-move buffer right",
	},
}

keybind.comment = {
	{
		mode = "n",
		lhs = commment.nline_comment,
		rhs = [[gccA<Space>]],
		opts = { noremap = false },
	},
	{
		mode = "v",
		lhs = commment.vline_comment,
		rhs = [[gc]],
		opts = { noremap = false },
	},
	{
		mode = "i",
		lhs = commment.iline_comment,
		rhs = [[<Esc>gccA<Space>]],
		opts = { noremap = false },
	},
}

keybind.telescope = {
	{
		mode = "n",
		lhs = telesp.fuzzy_find,
		rhs = [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({initial_mode = 'insert'})<CR>]],
		description = "telescope-current buffer fuzzy find",
	},
	{
		mode = "i",
		lhs = telesp.fuzzy_find_insertmode,
		rhs = [[<Esc>:lua require('telescope.builtin').current_buffer_fuzzy_find({initial_mode = 'insert'})<CR>]],
		description = "telescope-current buffer fuzzy find",
	},
	{
		mode = "n",
		lhs = telesp.find_files,
		rhs = [[<cmd>lua require('telescope.builtin').find_files({initial_mode = 'insert'})<CR>]],
		description = "telescope-find files",
	},
	{
		mode = "n",
		lhs = telesp.buffer_select,
		rhs = [[<cmd>lua require('telescope.builtin').buffers({initial_mode = 'normal'})<CR>]],
		description = "telescope-find buffer select",
	},
}

keybind.yanky = {
	{
		mode = { "n", "x" },
		lhs = yankyy.yanky_after,
		rhs = [[<Plug>(YankyPutAfter)]],
		opts = { noremap = false },
		description = "yanky-paste after",
	},
	{
		mode = { "n", "x" },
		lhs = yankyy.yanky_before,
		rhs = [[<Plug>(YankyPutBefore)]],
		opts = { noremap = false },
		description = "yanky-paste before",
	},
	{
		mode = "i",
		lhs = yankyy.iopen_yank_history,
		rhs = [[<Esc>:Telescope yank_history<cr>]],
		description = "open yank history",
	},
	{
		mode = "n",
		lhs = yankyy.nopen_yank_history,
		rhs = [[:Telescope yank_history<cr>]],
		description = "open yank history",
	},
}
-- hop
keybind.hop = {
	{
		mode = "n",
		lhs = hoppp.nhop_word,
		rhs = [[<cmd>HopWord<cr>]],
		description = "hop-word",
	},
	{
		mode = "n",
		lhs = hoppp.nhop_line,
		rhs = [[<cmd>HopLine<cr>]],
		description = "hop-line",
	},
	{
		mode = "n",
		lhs = hoppp.nhop_pattern,
		rhs = [[<cmd>HopPattern<cr>]],
		description = "hop-pattern",
	},
	-- {
	-- 	mode = "i",
	-- 	lhs = hoppp.ihop_line,
	-- 	rhs = [[<Esc>:HopLine<cr>]],
	-- 	description = "hop-line",
	-- },
	-- {
	-- 	mode = "i",
	-- 	lhs = hoppp.ihop_word,
	-- 	rhs = [[<Esc>:HopWord<cr>]],
	-- 	description = "hop-word",
	-- },
	-- {
	-- 	mode = "i",
	-- 	lhs = hoppp.ihop_pattern,
	-- 	rhs = [[<Esc>:HopPattern<cr>]],
	-- 	description = "hop-patter",
	-- },
}

-- ------------
-- whick-key
--
-- NOTE: register in which-key
-- vim.keymap.set("n", keybindingAlias.telescope.session_load, "<cmd>Telescope xray23 list<cr>")

-- ------------
-- plugs-others
--

-- comment
keybind.pluginKeys = {}
keybind.pluginKeys.comment = {
	-- Normal mode
	toggler = {
		line = "gcc", -- 行注释
		block = "gbc", -- 块注释
	},
	-- Visual mode
	opleader = {
		line = "gc",
		bock = "gb",
	},
}

-- LSP

local lsp = keybindingAlias.lsp
local function lsp_formatting()
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			-- NOTE: the client.name is name of the clients attached to this buffer
			return client.name == "null-ls"
		end,
		bufnr = vim.api.nvim_get_current_buf(),
		-- timeout_ms = 20000,
		async = true,
	})
end
vim.keymap.set(
	"n",
	lsp.open_fix_workspace,
	"<cmd>Trouble document_diagnostics<cr>",
	{ noremap = true, silent = true, desc = "open loacation quickfix list current" }
)
vim.keymap.set(
	"n",
	lsp.open_fix_workspace,
	"<cmd>Trouble workspace_diagnostics<cr>",
	{ noremap = true, silent = true, desc = "open loacation quickfix list workspace" }
)

keybind.pluginKeys.mapLSP = function(bufnr)
	vim.keymap.set("n", lsp.definition, function()
		require("telescope.builtin").lsp_definitions(
			require("telescope.themes").get_cursor({ initial_mode = "normal" })
		)
	end, { noremap = true, silent = true, desc = "goto lsp definition", buffer = bufnr })
	vim.keymap.set("n", lsp.references, function()
		require("telescope.builtin").lsp_references(require("telescope.themes").get_cursor({ initial_mode = "normal" }))
	end, { noremap = true, silent = true, desc = "goto lsp references", buffer = bufnr })
	vim.keymap.set(

		"n",
		lsp.hover,
		"<cmd>lua vim.lsp.buf.hover()<CR>",
		{ noremap = true, silent = true, desc = "open lsp hover", buffer = bufnr }
	)
	vim.keymap.set(

		"n",
		lsp.open_flow,
		"<cmd>lua vim.diagnostic.open_float()<CR>",
		{ noremap = true, silent = true, desc = "open lsp diagnostic", buffer = bufnr }
	)
	vim.keymap.set(

		"n",
		lsp.goto_next,
		"<cmd>lua vim.diagnostic.goto_next()<CR>",
		{ noremap = true, silent = true, desc = "goto next diagnostic", buffer = bufnr }
	)
	vim.keymap.set(

		"n",
		lsp.goto_prev,
		"<cmd>lua vim.diagnostic.goto_prev()<CR>",
		{ noremap = true, silent = true, desc = "goto prev diagnostic", buffer = bufnr }
	)
	vim.keymap.set(

		"n",
		lsp.rename,
		"<cmd>lua vim.lsp.buf.rename()<CR>",
		{ noremap = true, silent = true, desc = "variable lsp rename", buffer = bufnr }
	)
	vim.keymap.set(

		"n",
		lsp.code_action,
		"<cmd>lua vim.lsp.buf.code_action()<CR>",
		{ noremap = true, silent = true, desc = "lsp code action", buffer = bufnr }
	)
	vim.keymap.set(
		"n",
		lsp.format,
		lsp_formatting,
		{ noremap = true, silent = true, desc = "lsp code format", buffer = bufnr }
	)
	vim.keymap.set(

		"n",
		lsp.signature_help,
		"<cmd>lua vim.lsp.buf.signature_help()<CR>",
		{ noremap = true, silent = true, desc = "open function signature help", buffer = bufnr }
	)
	vim.keymap.set("n", lsp.implementations, function()
		require("telescope.builtin").lsp_implementations(
			require("telescope.themes").get_cursor({ initial_mode = "normal" })
		)
	end, { noremap = true, silent = true, desc = "goto interface implementation", buffer = bufnr })
	vim.keymap.set("n", lsp.type_definitions, function()
		require("telescope.builtin").lsp_type_definitions(
			require("telescope.themes").get_cursor({ initial_mode = "normal" })
		)
	end, { noremap = true, silent = true, desc = "goto type definition", buffer = bufnr })
	vim.keymap.set(
		"n",
		lsp.declaration,
		vim.lsp.buf.declaration,
		{ noremap = true, silent = true, desc = "goto declaration", buffer = bufnr }
	)
end

keybind.pluginKeys.cmp = function(luasnip, cmp)
	local cmpp = keybindingAlias.cmp

	-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
	-- local has_words_before = function()
	-- 	unpack = unpack or table.unpack
	-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	-- end

	local mapping = {
		-- [cmpp.cmp_next] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_next_item()
		-- 	elseif luasnip.expand_or_jumpable() then
		-- 		luasnip.expand_or_jump()
		-- 		-- 光标左边有单词  if there are words before the cursor
		-- 	elseif has_words_before() then
		-- 		cmp.complete()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
		[cmpp.cmp_next] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		[cmpp.cmp_pre] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		[cmpp.cmp_scroll_doc_down] = cmp.mapping.scroll_docs(4),
		[cmpp.cmp_scroll_doc_up] = cmp.mapping.scroll_docs(-4),
		[cmpp.cmp_select_next_item] = cmp.mapping(
			cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior }),
			{ "i", "c" }
		),
		[cmpp.cmp_select_prev_item] = cmp.mapping(
			cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior }),
			{ "i", "c" }
		),
		-- [cmpp.cmp_trigge] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		[cmpp.cmp_trigge] = cmp.mapping.complete(),
		[cmpp.cmp_abort] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
		[cmpp.cmp_confirm] = cmp.mapping({
			i = function(fallback)
				-- 如果有补全就调用cmp，没有补全项，<CR>就保持neovim原来的功能
				if cmp.visible() then
					cmp.confirm({
						select = true,
						behavior = cmp.ConfirmBehavior.Replace,
					})
				else
					fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
				end
			end,
			c = function(fallback)
				if cmp.visible() then
					cmp.confirm({
						select = false,
						behavior = cmp.ConfirmBehavior.Replace,
					})
				else
					fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
				end
			end,
		}),
	}
	return mapping
end

-- toggleterm
-- <leader>ta 浮动
-- <leader>tb 右侧
-- <leader>tc 下方
keybind.pluginKeys.mapToggleTerm = function(toggleterm)
	vim.keymap.set("n", toggletermm.toggleA, toggleterm.toggleA, { desc = "opent float terminal" })
	vim.keymap.set("n", toggletermm.toggleB, toggleterm.toggleB, { desc = "opent right side terminal" })
	vim.keymap.set("n", toggletermm.toggleC, toggleterm.toggleC, { desc = "opent bottom terminal" })
	vim.keymap.set("n", toggletermm.toggleD, toggleterm.toggleD, { desc = "opent 0.8 right side terminal" })
	vim.keymap.set("n", toggletermm.toggleG, toggleterm.toggleG, { desc = "opent lazygit terminal" })
end

keybind.keymap_set = {
	"editorInsert",
	"editorNormal",
	"editorVisual",
	"editorCommand",

	"nvimTree",
	"bufferline",
	"comment",
	"telescope",
	"yanky",
	"hop",
	"undotree",
	"outline",
}

function keybind.editorKeyRegister(keymapSet)
	for _, v in ipairs(keymapSet) do
		keybind.bulk_register_keymaps(keybind[v])
	end
end

function keybind.unsetKey(unsetmap)
	for mode, v in pairs(unsetmap) do
		if type(v) == "string" then
			vim.api.nvim_set_keymap(mode, v, "", { noremap = true, silent = false })
		else
			for _, vv in ipairs(v) do
				vim.api.nvim_set_keymap(mode, vv, "", { noremap = true, silent = false })
			end
		end
	end
end

keybind.magicSearch = {
	vmagicSearch = keybindingAlias.switch.vmagicSearch,
	nmagicSearch = keybindingAlias.switch.nmagicSearch,
}

commConf.magiceSearchSwitches(keybind.magicSearch)

return keybind
