-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    -- configure flash here
    labels = "asdfghjklqwertyuiopzxcvbnm",
    search = {
      -- search options
      mode = "fuzzy", -- fuzzy search
    },
    modes = {
      char = {
        enabled = true,
        jump_labels = true, -- show jump labels
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
