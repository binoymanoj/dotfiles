-- Neovim Configuration
-- Author: Binoy Manoj
-- GitHub: https://github.com/binoymanoj
-- Forked from https://github.com/AstroNvim/AstroNvim
-- AstroNvim is a great distro for Neovim. Been using since I started neovim, never switched. I did a few customizations like adding plugins, keymaps, few predefined macros and such (you can find it in this repo)

-- Lazy.nvim bootstrap
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 5

if not pcall(require, "lazy") then
  vim.api.nvim_echo({
    { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" },
    { "Press any key to exit...", "MoreMsg" },
  }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

-- Core setup
require("lazy_setup")
require("polish")

-- AstroNvim bootstrap
require("astronvim").setup()

-- Custom modules
require("config.mappings")
require("config.macros")
require("config.debug")

-- end 

-- -- Load user configurations
-- require("user.init")

-- Load custom keybindings
-- local mappings = require("config.mappings")
-- for mode, mode_mappings in pairs(mappings) do
--   for lhs, mapping in pairs(mode_mappings) do
--     local rhs = mapping[1]
--     local opts = { noremap = true, silent = true, desc = mapping.desc }
--     vim.keymap.set(mode, lhs, rhs, opts)
--   end
-- end

--------------------
-- CUSTOM MACROS -- 
--------------------

-- Macro for console.log("<text> :", <text>);
-- local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

-- -- Create a new augroup for JS/TS log macro
-- vim.api.nvim_create_augroup("JSLogMacro", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
--   group = "JSLogMacro",
--   pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" }, -- js, ts, jsx, tsx
--   callback = function()
--     -- Set 'l' register macro: console.log('<var>:', <var>);
--     vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pa:', " .. esc .. "pa);" .. esc .. "gs")
--   end,
-- })
--
-- Create a new augroup for Go log macro
-- vim.api.nvim_create_augroup("GoLogMacro", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
--   group = "GoLogMacro",
--   pattern = { "go" },
--   callback = function()
--     -- Set 'l' register macro: log.Printf("<var>: %v", <var>)
--     vim.fn.setreg("l", "yofmt.Printf(\"" .. esc .. "pa: %v\", " .. esc .. "pa)" .. esc .. "gs")
--   end,
-- })

-- Older Version
-- Macro for console.log()
-- vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pa:', " .. esc .. "pa);" .. esc .. "gs") -- with save
-- vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pa :', " .. esc .. "pa);" .. esc .. "") -- without save

