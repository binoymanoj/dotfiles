local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

-- JS/TS console.log macro
vim.api.nvim_create_augroup("JSLogMacro", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "JSLogMacro",
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pa:', " .. esc .. "pa);" .. esc .. "gs")
  end,
})

-- Go fmt.Printf macro
vim.api.nvim_create_augroup("GoLogMacro", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "GoLogMacro",
  pattern = { "go" },
  callback = function()
    vim.fn.setreg("l", "yofmt.Printf(\"" .. esc .. "pa: %v\\n\", " .. esc .. "pa)" .. esc .. "gs")
  end,
})
