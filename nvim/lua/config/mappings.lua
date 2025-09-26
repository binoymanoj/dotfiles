-- React component template function
local function insert_react_component_template()
  local lines = {
    "const ComponentName = () => {",
    "  return (",
    "    <div>",
    "    </div>",
    "  )",
    "}",
    "",
    "export default ComponentName"
  }
  
  -- Get current cursor position
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  
  -- Insert the template at cursor position
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, lines)
  
  -- Move cursor to first placeholder (ComponentName) and select it
  vim.api.nvim_win_set_cursor(0, {row, 6}) -- Position after "const "
  vim.cmd("normal! viw") -- Select the word "ComponentName"
  
  -- Set up tab navigation to export default line
  -- vim.keymap.set("i", "<Tab>", function()
  --   -- Exit insert mode first
  --   vim.cmd("normal! \27") -- Escape key
  --
  --   -- Find and jump to export default line
  --   local buf_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  --   for i, line in ipairs(buf_lines) do
  --     if line:match("^export default") then
  --       vim.api.nvim_win_set_cursor(0, {i, 15}) -- Position after "export default "
  --       vim.cmd("normal! viw") -- Select the word under cursor
  --       break
  --     end
  --   end
  -- end, { buffer = true, desc = "Jump to export default" })
end

-- Add the keybind to your mappings table
local mappings = {
  n = {
    ["<M-y>"] = { "ggVG", desc = "Select entire buffer" },
    ["<Leader><Tab>"] = { ":bnext<CR>", desc = "Next buffer" },
    ["YF"] = { "va{Vy", desc = "Select entire function" },
    ["<Leader>rc"] = { insert_react_component_template, desc = "Insert React component template" },
    ["<Leader>="] = {
      function()
        local line = vim.api.nvim_get_current_line()
        local expr = line:match("^(.-)%s*=")
        if expr then
          local ok, result = pcall(load("return " .. expr))
          if ok and result ~= nil then
            vim.api.nvim_set_current_line(expr .. " = " .. result)
          else
            vim.notify("Invalid expression", vim.log.levels.ERROR)
          end
        else
          vim.notify("No expression found before '='", vim.log.levels.WARN)
        end
      end,
      desc = "Evaluate expression before =",
    },
    ["<leader>tw"] = {
      function()
        local file = vim.fn.expand("%:p") -- full path of current file
        if vim.fn.fnamemodify(file, ":e") == "typ" then
          vim.cmd("split | terminal typst watch " .. file)
        else
          print("Not a Typst file")
        end
      end,
      desc = "Typst Watch PDF",
    },

    -- Typst: Open compiled PDF in Zathura
    ["<leader>to"] = {
      function()
        local file = vim.fn.expand("%:p:r") .. ".pdf" -- same name, .pdf
        vim.cmd("!zathura " .. file .. " & disown")
      end,
      desc = "Open Typst PDF in Zathura",
    },
  },
  v = {
    ["<M-j>"] = { ":m '>+1<CR>gv=gv", desc = "Move selection down" },
    ["<M-k>"] = { ":m '<-2<CR>gv=gv", desc = "Move selection up" },
    ["<Leader>="] = {
      function()
        local start_pos = vim.fn.getpos("'<")[2]
        local end_pos = vim.fn.getpos("'>")[2]
        local lines = vim.api.nvim_buf_get_lines(0, start_pos - 1, end_pos, false)
        for i, line in ipairs(lines) do
          local expr = line:match("^(.-)%s*=")
          if expr then
            local ok, result = pcall(load("return " .. expr))
            if ok and result ~= nil then
              lines[i] = expr .. " = " .. result
            else
              vim.notify("Invalid expression on line " .. (start_pos + i - 1), vim.log.levels.ERROR)
            end
          end
        end
        vim.api.nvim_buf_set_lines(0, start_pos - 1, end_pos, false, lines)
      end,
      desc = "Evaluate expressions for selected lines",
    },
  },
  i = {
    ["<M-j>"] = { "<Esc>:m .+1<CR>==gi", desc = "Move line down" },
    ["<M-k>"] = { "<Esc>:m .-2<CR>==gi", desc = "Move line up" },
  },
}

for mode, mode_mappings in pairs(mappings) do
  for lhs, mapping in pairs(mode_mappings) do
    local rhs = mapping[1]
    local opts = { noremap = true, silent = true, desc = mapping.desc }
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end
