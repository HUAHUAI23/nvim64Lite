local M = {
	config_path = vim.fn.stdpath("config"),

	-- Modes
	--   normal_mode = "n",
	--   insert_mode = "i",
	--   visual_mode = "v",
	--   visual_block_mode = "x",
	--   term_mode = "t",
	--   command_mode = "c",
	--   select_mode = "s"

	-- 前导键
	leader_key = ";",
	-- normal模式下键盘映射
	norl = {

		goto_command_mode = "<F1>",
		undo = "<leader>u",

		go_left35 = "H",
		go_right35 = "L",

		-- -- 粘贴模式可以防止从网页复制内容到vim而出现奇怪的缩进问题
		-- 因为vim的缩减处理和一般文本编辑器不一样
		goto_paste_mode = "sp",
		exit_paste_mode = "sP",
		-- cursor move in normal mode
		go_up_10line = "<C-u>",
		go_down_10line = "<C-d>",
		go_up_5line = "<C-k>",
		go_down_5line = "<C-j>",
		-- save exit and exit all  buffer behavior
		quit_buffer = "qq",
		quit_window = "<Leader>q",
		save_buffer = "<Leader>w",
		saveALL_and_exitALL = "<Leader>WQ",
		quit_without_save = "<Leader>Q",
		-- window split
		horizontal_split = "sh",
		vertical_split = "sv",
		-- window motion
		window_left = "s<left>",
		window_down = "s<down>",
		window_up = "s<up>",
		window_right = "s<right>",
		goto_window_sequence = "sw",
		-- adjust window size
		move_2up = "sk",
		move_2down = "sj",
		move_2left = "s,",
		move_2right = "s.",
		move_resize = "s=",
	},
	-- insert 模式下键盘映射
	insert = {
		goto_command_mode = "<F1>",
		goto_normal_mode = "<Leader><Leader>",
	},
	-- visual 模式下键盘映射
	visul = {
		-- goto command mode from visual mode
		goto_command_mode = "<F1>",
		-- cursor move in visual mode
		go_up_5line = "<C-k>",
		go_down_5line = "<C-j>",
		cp_to_sysClipboard = "Y",
	},
	-- command 模式下键盘映射
	cmand = {
		-- 命令补全下拉菜单中 上下选择
		select_next = "<C-j>",
		select_pre = "<C-k>",
	},
	-- terminal模式下键盘映射
	term = {
		-- terminal split
		horizontal_split = "st",
		vertical_split = "stv",
		-- terminal mode to normal mode
		term_to_normal = "<Esc>",
		-- terminal window motion
		window_left = "s<left>",
		window_down = "s<down>",
		window_up = "s<up>",
		window_right = "s<right>",
		-- go to command mode
		goto_command_mode = "<F1>",
	},
	------------------------------------------
	--插件键位映射
	nvimTree = {
		NvimTreeToggle = "<space>1",
	},
	undotree = {
		UndotreeToggle = "<space>2",
	},
	lsp = {
		--treesitter rename
		tsRename = "ra",
		rename = "rn",
		code_action = "ca",
		definition = "gd",
		hover = "gh",
		references = "gr",
		signature_help = "<leader>gh",
		type_definitions = "<leader>gl",
		implementations = "<leader>gi",
		-- diagnostic
		open_flow = "gl",
		goto_next = "gj",
		goto_prev = "gk",
		format = "<leader>f",
		-- outline
		LSoutline = "<space>3",
	},
	bufferline = {
		BufferLineCyclePrev = "<Leader>j",
		BufferLineCycleNext = "<Leader>k",
		BufferLineMovePrev = "<Leader>h",
		BufferLineMoveNext = "<Leader>l",
	},
	telescope = {
		fuzzy_find = "<C-f>",
		fuzzy_find_insertmode = "<C-f>",
		find_files = "<space>4",
		buffer_select = "<space>5",
		session_load = "<space>s",
	},
	cmp = {
		cmp_next = "<Tab>",
		cmp_pre = "<S-Tab>",
		cmp_confirm = "<CR>",
		cmp_scroll_doc_up = "<C-u>",
		cmp_scroll_doc_down = "<C-d>",
		cmp_select_prev_item = "<C-k>",
		cmp_select_next_item = "<C-j>",
		cmp_trigge = "<C-Space>",
		cmp_abort = "<leader>ee",
		-- luasnip
		luasnip_node_next = "<C-j>",
		luasnip_node_prev = "<C-k>",
	},
	toggerterm = {
		toggleA = "<leader>ta",
		toggleB = "<leader>tb",
		toggleC = "<leader>tc",
		toggleG = "<Leader>tg",
	},
	yanky = {
		yanky_after = "p",
		yanky_before = "P",
		iopen_yank_history = "<leader>yy",
		nopen_yank_history = "<leader>yy",
	},
	hop = {
		ihop_word = "<leader>gg",
		nhop_word = "<leader>gg",
		ihop_line = "<leader>gv",
		nhop_line = "<leader>gv",
		ihop_pattern = "<leader>gb",
	},
	comment = {
		iline_comment = [[<C-_>]],
		vline_comment = [[<C-_>]],
		nline_comment = [[<C-_>]],
	},
	switch = {
		vmagicSearch = "on",
		nmagicSearch = "on",
	},
}

return M
