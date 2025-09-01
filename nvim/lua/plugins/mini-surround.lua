return {
  "echasnovski/mini.surround",
  version = false,
  event = "VeryLazy",
  opts = {
    -- Add custom keymaps
    mappings = {
      add = "gz", -- Add surrounding in Normal and Visual modes
      delete = "gzD", -- Delete surrounding
      find = "gzf", -- Find surrounding (to the right)
      find_left = "gzF", -- Find surrounding (to the left)
      highlight = "gzh", -- Highlight surrounding
      replace = "gzr", -- Replace surrounding
      update_n_lines = "gzn", -- Update `n_lines`

      suffix_last = "l", -- Suffix to search with "prev" method
      suffix_next = "n", -- Suffix to search with "next" method
    },
    -- Custom surroundings
    custom_surroundings = {
      -- Markdown bold with ** 
      b = {
        input = { left = "%*%*", right = "%*%*" },
        output = { left = "**", right = "**" },
      },
      -- Markdown italic with *
      i = {
        input = { left = "%*", right = "%*" },
        output = { left = "*", right = "*" },
      },
      -- HTML div tag
      d = {
        input = { left = "<div>", right = "</div>" },
        output = { left = "<div>", right = "</div>" },
      },
      -- HTML span tag
      s = {
        input = { left = "<span>", right = "</span>" },
        output = { left = "<span>", right = "</span>" },
      },
      -- React/Nextjs JSX tag
      c = {
        input = {left= "{%/%", right = "%/%}"},
        output = {left= "{/* ", right = " */}"}
      },
      -- Generic HTML tag - special handler
      t = {
        input = function()
          local tag = vim.fn.input("Enter tag name: ")
          if tag == "" then return nil end
          return { left = "<" .. tag .. ">", right = "</" .. tag .. ">" }
        end,
        output = function()
          local tag = vim.fn.input("Enter tag name: ")
          if tag == "" then return nil end
          return { left = "<" .. tag .. ">", right = "</" .. tag .. ">" }
        end,
      },
    },
  },
}
