--  _______                    _
-- |__   __|                  | |
--    | | ___  _ __ ___   __ _| |_ ___
--    | |/ _ \| '_ ` _ \ / _` | __/ _ \
--    | | (_) | | | | | | (_| | || (_) |
--    |_|\___/|_| |_| |_|\__,_|\__\___/
--
-- Derek Nord
-- derekj.nord@gmail.com
-- github.com/thetomato2
-- -----------------------------------------------------

vim.opt.rtp:append("C:/dev/repos/neovim/runtime")

require("tomato.globals")
require("tomato.first_load")


if vim.g.neovide then
	require("tomato.neovide")
end

vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.g.snippets = "luasnip"

require("tomato.disable_builtin")

-- vim.cmd [[runtime plugin/astronauta.vim]]

require("tomato.plugins")
require("tomato.lsp")
require("tomato.telescope.setup")
require("tomato.telescope.mappings")
require("tomato.setup")
require("tomato.remap")

