local lspconfig = vim.F.npcall(require, "lspconfig")
if not lspconfig then
	return
end

local imap = require("tomato.keymap").imap
local nmap = require("tomato.keymap").nmap
local vmap = require("tomato.keymap").vmap

local autocmd = require("tomato.auto").autocmd
local autocmd_clear = vim.api.nvim_clear_autocmds

local navic = require("nvim-navic")


local is_mac = vim.fn.has("macunix") == 1

local lspconfig_util = require("lspconfig.util")

local telescope_mapper = require("tomato.telescope.mappings")
local handlers = require("tomato.lsp.handlers")

local ts_util = require("nvim-lsp-ts-utils")

local custom_init = function(client)
	client.config.flags = client.config.flags or {}
	client.config.flags.allow_incremental_sync = true
end

local buf_nnoremap = function(opts)
	if opts[3] == nil then
		opts[3] = {}
	end
	opts[3].buffer = 0

	nmap(opts)
end

local buf_inoremap = function(opts)
	if opts[3] == nil then
		opts[3] = {}
	end
	opts[3].buffer = 0

	imap(opts)
end

local buf_vnoremap = function(opts)
	if opts[3] == nil then
		opts[3] = {}
	end
	opts[3].buffer = 0

	vmap(opts)
end

local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
local augroup_codelens = vim.api.nvim_create_augroup("custom-lsp-codelens", { clear = true })
local augroup_format = vim.api.nvim_create_augroup("custom-lsp-format", { clear = true })
-- local augroup_semantic = vim.api.nvim_create_augroup("custom-lsp-semantic", { clear = true })

-- local on_full = semantic.on_full
-- local on_full = require("nvim-semantic-tokens.semantic_tokens").on_full

function vim.lsp.buf.semantic_tokens_range(start_pos, end_pos)
	local params = vim.lsp.util.make_given_range_params(start_pos, end_pos)
	vim.lsp.buf_request(
		0,
		"textDocument/semanticTokens/range",
		params,
		vim.lsp.with(on_full, {
			on_token = function(ctx, token)
				vim.notify(token.type .. "." .. table.concat(token.modifiers .. "man"))
			end,
		})
	)
end

local autocmd_format = function(async, filter)
	vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_format })
	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = 0,
		callback = function()
			vim.lsp.buf.format({ async = async, filter = filter })
		end,
	})
end

local filetype_attach = setmetatable({
	go = function()
		autocmd_format(false)
	end,

	scss = function()
		autocmd_format(false)
	end,

	css = function()
		autocmd_format(false)
	end,

	rust = function()
		telescope_mapper("<space>fw", "lsp_workspace_symbols", {
			ignore_filename = true,
			query = "#",
		}, true)

		autocmd_format(false)
	end,

	racket = function()
		autocmd_format(false)
	end,

	cpp = function()
		autocmd_format(true)
	end,

	typescript = function()
		autocmd_format(false, function(client)
			return client.name ~= "tsserver"
		end)
	end,
	zig = function()
		-- autocmd_format(false)
	end,
}, {
	__index = function()
		return function() end
	end,
})

local custom_attach = function(client, bufnr)
	local filetype = vim.api.nvim_buf_get_option(0, "filetype")

	buf_nnoremap({ "<space>lr", vim.lsp.buf.rename })
	buf_nnoremap({ "<space>la", vim.lsp.buf.code_action })

	buf_nnoremap({ "gd", vim.lsp.buf.definition })
	buf_nnoremap({ "gD", vim.lsp.buf.declaration })
	buf_nnoremap({ "go", vim.lsp.buf.type_definition })
	buf_nnoremap({
		"<space>lk",
		function()
			vim.lsp.buf.format({ async = true })
		end,
	})

	buf_nnoremap({ "<space>gI", handlers.implementation })
	buf_nnoremap({ "<space>le", "<cmd>lua R('tomato.lsp.codelens').run()<CR>" })
	buf_nnoremap({ "<space>rr", "LspRestart" })

	telescope_mapper("gr", "lsp_references", nil, true)
	telescope_mapper("gI", "lsp_implementations", nil, true)
	telescope_mapper("<space>wd", "lsp_document_symbols", { ignore_filename = true }, true)
	telescope_mapper("<space>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)

	buf_nnoremap({ "gh", vim.lsp.buf.hover, { desc = "lsp:hover" } })

	vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

	if client.server_capabilities.format then
		if filetype ~= zig then
			buf_nnoremap({
				"<space>lk",
				function()
					vim.lsp.buf.format({ async = true })
				end,
			})
		end
	end


	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end

    -- NOTE: this is a hacky work around
    -- if client.name == "omnisharp" then
    -- client.server_capabilities.semanticTokensProvider = {
    --   full = vim.empty_dict(),
    --   legend = {
    --     tokenModifiers = { "static_symbol" },
    --     tokenTypes = {
    --       "comment",
    --       "excluded_code",
    --       "identifier",
    --       "keyword",
    --       "keyword_control",
    --       "number",
    --       "operator",
    --       "operator_overloaded",
    --       "preprocessor_keyword",
    --       "string",
    --       "whitespace",
    --       "text",
    --       "static_symbol",
    --       "preprocessor_text",
    --       "punctuation",
    --       "string_verbatim",
    --       "string_escape_character",
    --       "class_name",
    --       "delegate_name",
    --       "enum_name",
    --       "interface_name",
    --       "module_name",
    --       "struct_name",
    --       "type_parameter_name",
    --       "field_name",
    --       "enum_member_name",
    --       "constant_name",
    --       "local_name",
    --       "parameter_name",
    --       "method_name",
    --       "extension_method_name",
    --       "property_name",
    --       "event_name",
    --       "namespace_name",
    --       "label_name",
    --       "xml_doc_comment_attribute_name",
    --       "xml_doc_comment_attribute_quotes",
    --       "xml_doc_comment_attribute_value",
    --       "xml_doc_comment_cdata_section",
    --       "xml_doc_comment_comment",
    --       "xml_doc_comment_delimiter",
    --       "xml_doc_comment_entity_reference",
    --       "xml_doc_comment_name",
    --       "xml_doc_comment_processing_instruction",
    --       "xml_doc_comment_text",
    --       "xml_literal_attribute_name",
    --       "xml_literal_attribute_quotes",
    --       "xml_literal_attribute_value",
    --       "xml_literal_cdata_section",
    --       "xml_literal_comment",
    --       "xml_literal_delimiter",
    --       "xml_literal_embedded_expression",
    --       "xml_literal_entity_reference",
    --       "xml_literal_name",
    --       "xml_literal_processing_instruction",
    --       "xml_literal_text",
    --       "regex_comment",
    --       "regex_character_class",
    --       "regex_anchor",
    --       "regex_quantifier",
    --       "regex_grouping",
    --       "regex_alternation",
    --       "regex_text",
    --       "regex_self_escaped_character",
    --       "regex_other_escape",
    --     },
    --   },
    --   range = true,
    -- }
    -- end


	filetype_attach[filetype](client)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Completion configuration
-- require("cmp_nvim_lsp").default_capabilities(updated_capabilities)
-- updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

-- Semantic token configuration
if semantic then
	semantic.setup({
		preset = "default",
		highlighters = { require("nvim-semantic-tokens.table-highlighter") },
	})

	semantic.extend_capabilities(updated_capabilities)
end

updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }

local rust_analyzer, rust_analyzer_cmd = nil, { "rustup", "run", "nightly", "rust-analyzer" }
local has_rt, rt = pcall(require, "rust-tools")
if has_rt then
	local extension_path = vim.fn.expand("~/.vscode/extensions/sadge-vscode/extension/")
	local codelldb_path = extension_path .. "adapter/codelldb"
	local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

	rt.setup({
		server = {
			cmd = rust_analyzer_cmd,
			capabilities = updated_capabilities,
			on_attach = custom_attach,
		},
		dap = {
			adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
		},
		tools = {
			inlay_hints = {
				auto = false,
			},
		},
	})
else
	rust_analyzer = {
		cmd = rust_analyzer_cmd,
	}
end

local pid = vim.fn.getpid()
-- local omnisharp_bin = "C:\\ProgramData\\chocolatey\\lib\\omnisharp\\tools\\OmniSharp.exe"
-- local omnisharp_cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid)}

local servers = {
	-- Also uses `shellcheck` and `explainshell`
	bashls = true,

	eslint = true,
	gdscript = true,
	-- graphql = true,
	html = true,
	pyright = true,
	vimls = true,
	yamlls = true,
	-- glslls = true,
	zls = true,
	-- hlsl = {
	-- 	cmd = {
	-- 		"ShaderTools.LanguageServer",
	-- 	},
	-- 	filetypes = { "hlsl" },
	-- },

	cmake = (1 == vim.fn.executable("cmake-language-server")),
	dartls = pcall(require, "flutter-tools"),

	-- ccls = {
	-- 	init_options = {
	-- 		compilationDatabaseDirectory = "build",
	-- 		index = {
	-- 			threads = 0,
	-- 		},
	-- 		clang = {
	-- 			excludeArgs = { "-frounding-math" },
	-- 		},
	-- 		cache = { directory = ".ccls-cache" },
	-- 		highlight = {
	-- 			lsRanges = true,
	-- 		},
	-- 	},
	-- },

	clangd = {
		cmd = {
			"clangd",
			"--header-insertion=never",
			"--all-scopes-completion=true",
			"--completion-style=bundled",
			"--cross-file-rename",
			"--enable-config",
			"--pch-storage=disk",
			"--header-insertion-decorators",
			"--background-index",
		},
		init_options = {
			clangdFileStatus = true,
		},
	},

	-- omnisharp = {
	-- 	cmd = { vim.fn.expand("~/build/omnisharp/run"), "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
	-- },


    -- omnisharp = {
    --     cmd = omnisharp_cmd,
    --     on_new_config = function(new_config,new_root_dir)
    --         new_config.cmd = omnisharp_cmd
    --     end,
    --     on_attach = on_attach,
    --     root_dir = function(file, _)
    --         if file:sub(-#".csx") == ".csx" then
    --             return util.path.dirname(file)
    --         end
    --         return lspconfig_util.root_pattern("*.sln")(file) or lspconfig_util.root_pattern("*.csproj")(file)
    --     end,
    --     handlers = {
    --         ["textDocument/definition"] = require('omnisharp_extended').handler,
    --     },
    -- },

	gopls = {
		-- root_dir = function(fname)
		--   local Path = require "plenary.path"
		--
		--   local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
		--   local absolute_fname = Path:new(fname):absolute()
		--
		--   if string.find(absolute_cwd, "/cmd/", 1, true) and string.find(absolute_fname, absolute_cwd, 1, true) then
		--     return absolute_cwd
		--   end
		--
		--   return lspconfig_util.root_pattern("go.mod", ".git")(fname)
		-- end,

		settings = {
			gopls = {
				codelenses = { test = true },
			},
		},

		flags = {
			debounce_text_changes = 200,
		},
	},


	rust_analyzer = rust_analyzer,

	racket_langserver = true,

	elmls = true,
	cssls = true,
	tsserver = {
		init_options = ts_util.init_options,
		cmd = { "typescript-language-server", "--stdio" },
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},

		on_attach = function(client)
			custom_attach(client)

			ts_util.setup({ auto_inlay_hints = false })
			ts_util.setup_client(client)
		end,
	},
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = {
						-- vim
						"vim",

						-- Busted
						"describe",
						"it",
						"before_each",
						"after_each",
						"teardown",
						"pending",
						"clear",

						-- Colorbuddy
						"Color",
						"c",
						"Group",
						"g",
						"s",

						-- Custom
						"RELOAD",
					},
				},

				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
			},
		},
	},
}

local setup_server = function(server, config)
	if not config then
		return
	end

	if type(config) ~= "table" then
		config = {}
	end

	config = vim.tbl_deep_extend("force", {
		on_init = custom_init,
		on_attach = custom_attach,
		capabilities = updated_capabilities,
		flags = {
			debounce_text_changes = nil,
		},
	}, config)

	lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
	setup_server(server, config)
end


--[ An example of using functions...
-- 0. nil -> do default (could be enabled or disabled)
-- 1. false -> disable it
-- 2. true -> enable, use defaults
-- 3. table -> enable, with (some) overrides
-- 4. function -> can return any of above
--
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, method, params, client_id, bufnr, config)
--   local uri = params.uri
--
--   vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics, {
--       underline = true,
--       virtual_text = true,
--       signs = sign_decider,
--       update_in_insert = false,
--     }
--   )(err, method, params, client_id, bufnr, config)
--
--   bufnr = bufnr or vim.uri_to_bufnr(uri)
--
--   if bufnr == vim.api.nvim_get_current_buf() then
--     vim.lsp.diagnostic.set_loclist { open_loclist = false }
--   end
-- end
--]]

-- Set up null-ls
local use_null = true
if use_null then
	require("null-ls").setup({
		sources = {
			require("null-ls").builtins.formatting.stylua,
			-- require("null-ls").builtins.diagnostics.eslint,
			-- require("null-ls").builtins.completion.spell,
			-- require("null-ls").builtins.diagnostics.selene,
			require("null-ls").builtins.formatting.prettierd,
		},
	})
end

return {
	on_init = custom_init,
	on_attach = custom_attach,
	capabilities = updated_capabilities,
}
