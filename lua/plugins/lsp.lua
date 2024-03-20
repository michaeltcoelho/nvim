local M = {}
M.get_python_path = function(workspace)
  local lsp_util = require("lspconfig/util")
  local path = lsp_util.path
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end
  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ "*", ".*" }) do
    local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
    if match ~= "" then
      return path.join(path.dirname(match), "bin", "python")
    end
  end
  -- Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

LSP_SERVERS = {
  "bashls",
  "dockerls",
  "jsonls",
  "gopls",
  "pyright",
  "lua_ls",
  "terraformls",
  "yamlls",
}

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "onsails/lspkind-nvim" },
      { "folke/neoconf.nvim", config = true, ft = "lua" }, -- must be loaded before lsp
    },
    config = function()
      local nvim_lsp = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- enable autocompletion via nvim-cmp
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      for _, lsp in ipairs(LSP_SERVERS) do
        nvim_lsp[lsp].setup({
          before_init = function(_, config)
            if lsp == "pyright" then
              config.settings.python.pythonPath = M.get_python_path(config.root_dir)
            end
          end,
          capabilities = capabilities,
          flags = { debounce_text_changes = 150 },
          settings = {
            redhat = { telemetry = { enabled = false } },
          },
        })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = true,
    cmd = "Mason",
    dependencies = {
      { "williamboman/mason-lspconfig.nvim", module = "mason" },
    },
    config = function()
      -- install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }),
      require("mason").setup()

      -- install LSPs
      require("mason-lspconfig").setup({
        ensure_installed = LSP_SERVERS,
      })
    end,
  },
}
