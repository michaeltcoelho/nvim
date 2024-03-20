
vim.g.mapleader = ","

-- Mouse, copy/paste
vim.opt.mouse = "nv"
vim.opt.clipboard = "unnamedplus"

-- Tab, ident
vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.shiftwidth = 4          -- Shift 4 spaces when tab
vim.opt.tabstop = 4             -- 1 tab == 4 spaces
vim.opt.smartindent = true      -- Autoindent new lines

-- Memory, CPU
vim.opt.hidden = true           -- Enable background buffers
vim.opt.history = 100           -- Remember N lines in history
vim.opt.lazyredraw = true       -- Faster scrolling
vim.opt.synmaxcol = 240         -- Max column for syntax highlight
vim.opt.updatetime = 250        -- ms to wait for trigger an event
