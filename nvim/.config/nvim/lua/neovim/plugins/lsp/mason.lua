return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'whoIsSethDaniel/mason-tool-installer.nvim'
  },
  config = function()
    -- import mason
    local mason = require('mason')

    -- import mason-lspconfig
    local mason_lspconfig = require('mason-lspconfig')

    local mason_tool_installer = require('mason-tool-installer')

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        -- Core/Neovim config
        'lua_ls',           -- for Lua (your Neovim config)
        'vimls',            -- Vimscript (optional, if you touch .vim files)

        -- General Programming
        'pyright',          -- Python
        'clangd',           -- C/C++ (only if you actually work in C/C++)

        -- Web/React
        'ts_ls',            -- JavaScript, TypeScript, TSX
        'html',             -- HTML
        'cssls',            -- CSS
        'jsonls',           -- JSON/JSONC
        'eslint',           -- optional but recommended for linting JS/TS

        -- Markdown/Hugo
        'marksman',         -- Markdown
        'yamlls',           -- YAML
        'taplo',            -- TOML
        -- 'gopls',            -- Go (needed for Hugo Go templates 'gottmpl')

        -- DevOps/Sysadmin
        'bashls',           -- Bash/ZSH scripts
        'dockerls',         -- Dockerfiles
        'docker_compose_language_service',        -- docker-compose.yaml
        'ansiblels',        -- Ansible playbooks
        'nginx_language_server',        -- if/when you touch nginx configs
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        'prettier',         -- prettier formatter
        'stylua',           -- lua formatter
        'isort',            -- python formatter
        'black',            -- python formatter
        'pylint',           -- python linter
        'eslint_d',         -- js linter
      },
    })
  end,
}
