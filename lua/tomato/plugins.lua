-- local has = function(x)
--     return vim.fn.has(x) == 1
-- end

-- local executable = function(x)
--     return vim.fn.executable(x) == 1
-- end

-- local is_wsl = (function()
--     local output = vim.fn.systemlist('uname -r')
--     return not not string.find(output[1] or '', 'WSL')
-- end)()

-- local is_mac = has('macunix')
-- local is_linux = not is_wsl and not is_mac

-- local max_jobs = nil
-- if is_mac then
--     max_jobs = 32
-- end

return require('lazy').setup({
        'ellisonleao/gruvbox.nvim',
        'L3MON4D3/LuaSnip',
        'neovim/nvim-lspconfig',
        'j-hui/fidget.nvim', 
        {
            'ericpubu/lsp_codelens_extensions.nvim',
            config = function()
                require('codelens_extensions').setup()
            end,
        },

        'jose-elias-alvarez/null-ls.nvim',
        'ray-x/lsp_signature.nvim', 
        -- ' p00f/clangd_extensions.nvim'

        'onsails/lspkind-nvim',
        'jose-elias-alvarez/nvim-lsp-ts-utils',

        {
            'folke/lsp-trouble.nvim',
            cmd = 'Trouble',
            config = function()
                -- Can use P to toggle auto movement
                require('trouble').setup({
                    auto_preview = false,
                    auto_fold = true,
                })
            end,
        },

        'rcarriga/nvim-notify',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        },
        'nvim-telescope/telescope-rs.nvim',
        'nvim-telescope/telescope-fzf-writer.nvim',
        'tsakirist/telescope-lazy.nvim',
        'nvim-telescope/telescope-github.nvim',
        'nvim-telescope/telescope-symbols.nvim',
        'nvim-telescope/telescope-hop.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
        'nvim-telescope/telescope-ui-select.nvim',

        'chaoren/vim-wordmotion',
        'derekwyatt/vim-fswitch',
        'JoseConseco/vim-case-change',
        'feline-nvim/feline.nvim',

        'rktjmp/lush.nvim',
        -- 'p00f/nvim-ts-rainbow',

        {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end,
        },

        {
            'AckslD/nvim-neoclip.lua',
            config = function()
                require('neoclip').setup()
            end,
        },

        -- For narrowing regions of text to look at them alone
        {
            'chrisbra/NrrwRgn',
            cmd = { 'NarrowRegion', 'NarrowWindow' },
        },

        -- Pretty colors
        'norcalli/nvim-colorizer.lua',
        {
            'norcalli/nvim-terminal.lua',
            config = function()
                require('terminal').setup()
            end,
        },

        'hrsh7th/nvim-cmp',
        -- 'hrsh7th/cmp-cmdline'
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-document-symbol',
        'saadparwaiz1/cmp_luasnip',
        'tamago324/cmp-zsh',
        
         -- use ({
         --    'ms-jpq/coq_nvim',
         --    branch = 'coq',
         --    dependencies = {
         --      { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
         --      {
         --        'ms-jpq/coq.thirdparty',
         --        branch = '3p',
         --        config = function()
         --          require 'coq_3p' { { src = 'copilot', short_name = 'COP', accept_key = '<c-f>' } }
         --        end,
         --      },
         --    },
         --  })

        {
            'windwp/nvim-autopairs',
            config = function()
                require('nvim-autopairs').setup({})
            end,
        },

        {
            'nvim-tree/nvim-tree.lua',
            dependencies = {
                'nvim-tree/nvim-web-devicons', -- optional, for file icons
            },
        },

        -- {
        --     'nvim-neo-tree/neo-tree.nvim',
        --     branch = 'v2.x',
        --     dependencies = {
        --         'nvim-lua/plenary.nvim',
        --         'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        --         'MunifTanjim/nui.nvim',
        --     },
        --     setup = function()
        --         vim.g.neo_tree_remove_legacy_commands = true
        --     end,
        -- },

        {
            'folke/todo-comments.nvim',
            dependencies = 'nvim-lua/plenary.nvim',
        },

        {
            'folke/which-key.nvim',
            config = function()
                require('which-key').setup({
                    triggers = '<leader>',

                    -- your configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                })
            end,
        },

        {
            'kylechui/nvim-surround',
            config = function()
                require('nvim-surround').setup({
                    -- Configuration here, or leave empty to use defaults
                })
            end,
        },

        {
            'nvim-treesitter/nvim-treesitter',
            build = function()
                require('nvim-treesitter.install').update({ with_sync = true })
            end,
        },
        'nvim-treesitter/playground',
        -- use 'vigoux/architext.nvim'

        -- use('nvim-treesitter/nvim-treesitter-textobjects')
        'RRethy/nvim-treesitter-textsubjects',
        -- use 'sindrets/diffview.nvim'
        --
        'mrjones2014/nvim-ts-rainbow',

        -- -- Git worktree utility
        -- use {
        --   'ThePrimeagen/git-worktree.nvim',
        --   config = function()
        --     require('git-worktree').setup {}
        --   end,
        -- }

        'ThePrimeagen/harpoon',
        'mbbill/undotree',
        'tpope/vim-fugitive',
        -- use 'untitled-ai/jupyter_ascending.vim'
        --
        -- 'ziglang/zig.vim',

         'kevinhwang91/nvim-bqf',

        {
            'junegunn/fzf',
            build = function()
                vim.fn['fzf#install']()
            end,
        },

        {
            'filipdutescu/renamer.nvim',
            branch = 'master',
            dependencies = { { 'nvim-lua/plenary.nvim' } },
        },

        {
            'SmiteshP/nvim-navic',
            dependencies = 'neovim/nvim-lspconfig',
        },

         'mhartington/formatter.nvim',

        -- 'Hoffs/omnisharp-extended-lsp.nvim',

        -- 'ludovicchabant/vim-gutentags',
        --
        -- {
        --   "dhananjaylatkar/cscope_maps.nvim",
        --   dependencies = {
        --     "folke/which-key.nvim", -- optional [for whichkey hints]
        --     "nvim-telescope/telescope.nvim", -- optional [for picker="telescope"]
        --     "ibhagwan/fzf-lua", -- optional [for picker="fzf-lua"]
        --     "nvim-tree/nvim-web-devicons", -- optional [for devicons in telescope or fzf]
        --   },
        --   opts = {
        --       skip_input_prompt = true,
        --       cscope = {
        --           skip_picker_for_single_result = true,
        --       },
        --   },
        -- },

        {dir = 'C:/dev/Neovim/neovim_tomato'},
        {dir = 'C:/dev/Neovim/neovim_tomato_theme'},
})
