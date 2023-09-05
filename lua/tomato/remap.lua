local imap = require("tomato.keymap").imap
local nmap = require("tomato.keymap").nmap
local vmap = require("tomato.keymap").vmap

-- note this freezes neovim

vim.keymap.set("n", "<S-k>", "<NOP>")
vim.keymap.set("n", "Q", "<nop>")


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("x", "<leader>p", "\"_dp")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")


vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- vim.keymap.set("n", "gd", "<C-]>")
vim.keymap.set("n", "<leader>tn", "<cmd>tn<CR>")
vim.keymap.set("n", "<leader>tp", "<cmd>tp<CR>")
vim.keymap.set("n", "<leader>tl", "<cmd>tl<CR>")
vim.keymap.set("n", "<leader>tl", "<C-W>}")

vim.keymap.set("n", "<leader>oH", "<cmd>FSSplitLeft<CR>")
vim.keymap.set("n", "<leader>oL", "<cmd>FSSplitRight<CR>")
vim.keymap.set("n", "<leader>oo", "<cmd>FSHere<CR>")
vim.keymap.set("n", "<leader>oh", "<cmd>FSLeft<CR>")
vim.keymap.set("n", "<leader>ol", "<cmd>FSRight<CR>")

vim.keymap.set("n", "<leader>tw", "<cmd>set wrap!<CR>")

vim.keymap.set("n", "<leader>qo", ":copen<cr>")
vim.keymap.set("n", "<leader>qp", ":ccl<cr>")

vim.keymap.set("n", "<leader>el", "<cmd>lua vim.diagnostic.setloclist()<cr>")

vim.keymap.set("n", "<leader>tt", "<cmd>:NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>th", "<cmd>:TSHighlightCapturesUnderCursor<cr>")

vim.keymap.set("i", "<F2>", '<cmd>lua require("renamer").rename()<cr>')
vim.keymap.set("n", "<leader>rn", '<cmd>lua require("renamer").rename()<cr>')
vim.keymap.set("v", "<leader>rn", '<cmd>lua require("renamer").rename()<cr>')

vim.keymap.set("n", "<leader>zb", "<cmd>:Zig build<cr>")
vim.keymap.set("n", "<leader>zn", "<cmd>:Zig build_run<cr>")
vim.keymap.set("n", "<leader>zt", "<cmd>:Zig build_test<cr>")
vim.keymap.set("n", "<leader>zk", "<cmd>:Zig fmt<cr>")

vim.keymap.set("n", "<leader>cb", "<cmd>:CMake build<cr>")
vim.keymap.set("n", "<leader>ca", "<cmd>:CMake build_all<cr>")
vim.keymap.set("n", "<leader>cn", "<cmd>:CMake build_and_run<cr>")
vim.keymap.set("n", "<leader>cr", "<cmd>:CMake run<cr>")
vim.keymap.set("n", "<leader>ct", "<cmd>:CMake select_build_target<cr>")
vim.keymap.set("n", "<leader>cu", "<cmd>:CMake select_build_type<cr>")
vim.keymap.set("n", "<leader>cc", ":CMake configure")

function switch_source_header()
    for i, win in ipairs(vim.api.nvim_list_wins()) do
        if i > 1 then
            vim.api.nvim_win_close(win, false)
        end
    end
    vim.cmd("FSSplitRight")
end


-- function switch_source_header(bufnr)
-- 	bufnr = lspconfig_util.validate_bufnr(bufnr)
-- 	local clangd_client = lspconfig_util.get_active_client_by_name(bufnr, "clangd")
-- 	local params = { uri = vim.uri_from_bufnr(bufnr) }
-- 	if clangd_client then
-- 		clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
-- 			if err then
-- 				error(tostring(err))
-- 			end
-- 			if not result then
-- 				print("Corresponding file cannot be determined")
-- 				return
-- 			end
--
-- 			win_cnt = 1
-- 			for i, win in ipairs(vim.api.nvim_list_wins()) do
-- 				if i == 2 then
-- 					win_cnt = 2
-- 				end
-- 				if i > 2 then
-- 					vim.api.nvim_win_close(win, false)
-- 				end
-- 			end
--
-- 			name = (vim.uri_to_fname(result))
-- 			exit = false
-- 			if win_cnt == 1 then
-- 				vim.api.nvim_command("vs | edit " .. name)
-- 				vim.cmd("wincmd W")
-- 			elseif win_cnt == 2 then
-- 				for _, win in pairs(vim.fn.getwininfo()) do
-- 					if vim.api.nvim_buf_get_name(win["bufnr"]) == name then
-- 						-- vim.api.nvim_set_current_win(win['winid'])
-- 						vim.cmd("wincmd W")
-- 						exit = true
-- 					end
-- 				end
-- 				if exit == false then
-- 					for _, win in pairs(vim.fn.getwininfo()) do
-- 						-- print(win_cnt)
-- 						if vim.api.nvim_buf_get_name(win["bufnr"]) ~= name then
-- 							vim.api.nvim_win_close(win["winid"], false)
-- 						end
-- 					end
-- 					vim.api.nvim_command("vs | edit " .. name)
-- 					vim.cmd("wincmd W")
-- 				end
-- 			end
-- 			-- vim.api.nvim_command('edit ' .. vim.uri_to_fname(result))
-- 		end, bufnr)
-- 	else
-- 		print("method textDocument/switchSourceHeader is not supported by any servers active on the current buffer")
-- 	end
-- end

vim.keymap.set("n", "<M-o>", "<cmd>lua switch_source_header()<cr>", { noremap = true })


-- function RTags()
--   vim.cmd("!ctags -f .tags --extras=+q --exclude= --exclude=build --exclude=.git -R --sort=foldcase")
-- end

-- vim.keymap.set("n", "<leader>rt", "<cmd>lua RTags()<cr>")
