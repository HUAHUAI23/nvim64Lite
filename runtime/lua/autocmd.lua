local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {
	clear = true,
})
local autocmd = vim.api.nvim_create_autocmd

-- nvim-tree 自动关闭
autocmd("BufEnter", {
	nested = true,
	group = myAutoGroup,
	callback = function()
		if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
			vim.cmd("quit")
		end
	end,
})

-- 进入Terminal 自动进入插入模式
autocmd("TermOpen", {
	group = myAutoGroup,
	command = "startinsert",
})

-- 保存时自动格式化
autocmd("BufWritePre", {
	group = myAutoGroup,
	pattern = { "*.lua", "*.py", "*.sh" },
	callback = vim.lsp.buf.formatting_sync,
})

-- Highlight on yank
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = myAutoGroup,
	pattern = "*",
})

-- 用o换行不要延续注释
autocmd("BufEnter", {
	group = myAutoGroup,
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions
			- "o" -- O and o, don't continue comments
			+ "r" -- But do continue when pressing enter.
	end,
})

-- if vim.fn.has("wsl") then
-- 	vim.cmd([[
--     augroup Yank
--     autocmd!
--     autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
--     augroup END
--     ]])
-- end
-- 当在wsl环境下，剪切内容到系统寄存器时会将内容同步复制到win的剪切板中
if vim.fn.has("wsl") then
	vim.cmd([[
    augroup wslYank
    autocmd!
    autocmd TextYankPost * if v:event.regname ==# '+' | call system('/mnt/c/windows/system32/clip.exe ',@") | endif
    augroup END
    ]])
end
