return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- optional but desired:
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      -- { "nvim-telescope/telescope-ui-select.nvim" },
    },
    defaults = {
      -- prompt_prefix = lvim.icons.ui.Telescope .. " ",
      -- selection_caret = lvim.icons.ui.Forward .. " ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = nil,
      layout_strategy = nil,
      layout_config = {},
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
    },
    pickers = {
      find_files = {
        hidden = true,
      },
      git_files = {
        hidden = true,
        show_untracked = true,
      }
    },
    config = function ()
      pcall(require("telescope").load_extension, "fzf")

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end,
  },
}
