vim.g.neovide_refresh_rate = 165
vim.g.neovide_remember_window_size = true
vim.g.neovide_cursor_trail_legnth = 0
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_hide_mouse_when_typing = true

vim.o.guifont = "Hack NF:h11"

vim.api.nvim_set_keymap('n', '<F11>', ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {})

