
vim.g.mapleader = ","

-- Mouse, copy/paste
vim.opt.mouse = "nv"
vim.opt.clipboard = "unnamedplus"

-- Tab, ident
vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.shiftwidth = 4          -- Shift 4 spaces when tab
vim.opt.tabstop = 4             -- 1 tab == 4 spaces
vim.opt.smartindent = true      -- Autoindent new lines
vim.o.number = true
vim.o.numberwidth = 2
vim.o.showtabline = true
vim.o.relativenumber = true
vim.o.termguicolors = true

-- Memory, CPU
vim.opt.hidden = true           -- Enable background buffers
vim.opt.history = 100           -- Remember N lines in history
vim.opt.lazyredraw = true       -- Faster scrolling
vim.opt.synmaxcol = 240         -- Max column for syntax highlight
vim.opt.updatetime = 250        -- ms to wait for trigger an event

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
