return {

  {
    'neovim/nvim-lspconfig',

    dependencies = {
      { 'j-hui/fidget.nvim', opts = {}, },
    },

    config = function()
      local util = require 'lspconfig.util'

      vim.lsp.config('lua_ls', {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath('config')
                and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT',
            },
            path = {
              'lua/?.lua',
              'lua/?/init.lua',
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                vim.fn.stdpath("data") .. "/lazy/plenary.nvim",
              },
            },
          })
        end,
        settings = {
          Lua = {},
        },
      })

      vim.lsp.config('csharp-ls', {
        cmd = function(dispatchers, config)
          return vim.lsp.rpc.start({ 'csharp-ls' }, dispatchers, {
            -- csharp-ls attempt to locate sln, slnx or csproj files from cwd, so set cwd to root directory.
            -- If cmd_cwd is provided, use it instead.
            cwd = config.cmd_cwd or config.root_dir,
            env = config.cmd_env,
            detached = config.detached,
          })
        end,
        root_dir = function(bufnr, on_dir)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          on_dir(util.root_pattern '*.sln' (fname) or util.root_pattern '*.slnx' (fname) or
            util.root_pattern '*.csproj' (fname))
        end,
        filetypes = { 'cs' },
        init_options = {
          AutomaticWorkspaceInit = true,
        },
        get_language_id = function(_, ft)
          if ft == 'cs' then
            return 'csharp'
          end
          return ft
        end,
      })

      vim.lsp.enable('lua_ls')
      vim.lsp.enable('gopls')
      vim.lsp.enable('csharp-ls')

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          if not client then return end

          if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end,
      })
    end,
  }
}
