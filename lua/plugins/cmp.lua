local M = {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "quangnguyen30192/cmp-nvim-ultisnips",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-calc",
    "lukas-reineke/cmp-rg",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    local sources = {
      { name = "nvim_lsp" },
      { name = "gopls" },
      { name = "buffer", keyword_length = 5 },
      { name = "luasnip" },
      { name = "calc" },
      { name = "path" },
      { name = "rg", keyword_length = 5 },
    }

    local format = {
      mode = "symbol_text",
      max_width = 50,
      symbol_map = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
      },
    }

    local t = function(str)
      return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    cmp.setup({
      formatting = {
        format = lspkind.cmp_format({ format }),
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = {
        -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        -- ["<C-u>"] = cmp.mapping.scroll_docs(4),
        -- ["<C-Space>"] = cmp.mapping.complete(),
        -- ["<C-e>"] = cmp.mapping.close(),
        -- ["<CR>"] = cmp.mapping.confirm({
        --   behavior = cmp.ConfirmBehavior.Replace,
        --   select = false,
        -- }),
        --
        -- ["<Tab>"] = cmp.mapping({
        --     c = function()
        --         if cmp.visible() then
        --             cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        --         else
        --             cmp.complete()
        --         end
        --     end,
        --     i = function(fallback)
        --         if cmp.visible() then
        --             cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        --         elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
        --             vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
        --         else
        --             fallback()
        --         end
        --     end,
        --     s = function(fallback)
        --         if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
        --             vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
        --         else
        --             fallback()
        --         end
        --     end
        -- }),
        -- ["<S-Tab>"] = cmp.mapping({
        --     c = function()
        --         if cmp.visible() then
        --             cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        --         else
        --             cmp.complete()
        --         end
        --     end,
        --     i = function(fallback)
        --         if cmp.visible() then
        --             cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        --         elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
        --             return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
        --         else
        --             fallback()
        --         end
        --     end,
        --     s = function(fallback)
        --         if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
        --             return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
        --         else
        --             fallback()
        --         end
        --     end
        -- }),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
        ['<C-n>'] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end
        }),
        ['<C-p>'] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                    vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end
        }),
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<C-e>'] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
        ['<CR>'] = cmp.mapping({
            i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
            c = function(fallback)
                if cmp.visible() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end
        }),
      },
      sources = sources,
    })
  end,
}

return M
