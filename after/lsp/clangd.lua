-- -- https://clangd.llvm.org/extensions.html#switch-between-sourceheader
-- local function switch_source_header(bufnr)
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
-- 						if vim.api.nvim_buf_get_name(win["bufnr"]) ~= name
--                          and vim.api.nvim_buf_get_name(win["bufnr"])  ~= vim.api.nvim_buf_get_name(0) then
-- 							vim.api.nvim_win_close(win["winid"], false)
-- 						end
-- 					end
-- 					vim.api.nvim_command("vs | edit " .. name)
-- 				end
-- 			end
-- 			-- vim.api.nvim_command('edit ' .. vim.uri_to_fname(result))
-- 		end, bufnr)
-- 	else
-- 		print("method textDocument/switchSourceHeader is not supported by any servers active on the current buffer")
-- 	end
-- end
