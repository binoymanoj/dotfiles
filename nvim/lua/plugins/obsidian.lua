if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

vim.opt.conceallevel = 2
return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended: use the latest stable release
  lazy = true,
  -- Only load this plugin for markdown files in your vault
  event = {
    "BufReadPre " .. vim.fn.expand "~/Notes/*.md",
    "BufNewFile " .. vim.fn.expand "~/Notes/*.md",
  },
  -- fix for windows
  -- event = {
  --       -- Using forward slashes instead of backslashes
  --       "BufReadPre C:/Users/binoy/Obsidian-Git-Sync/**/*",
  --       "BufNewFile C:/Users/binoy/Obsidian-Git-Sync/**/*",
  --   },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "Notes",
        path = "~/Notes",
      },
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    new_notes_location = "current_dir",
    ui = {
      enable = true,
    },
    note_extensions = { "md", "markdown" },
    open_notes_in = "current",
  },
  keys = {
    -- { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New Obsidian note", mode = "n" },
    -- { "<leader>oo", "<cmd>ObsidianSearch<cr>", desc = "Search Obsidian notes", mode = "n" },
    -- { "<leader>os", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick Switch", mode = "n" },
    -- { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Show backlinks", mode = "n" },
    -- { "<leader>ot", "<cmd>ObsidianTemplate<cr>", desc = "Insert template", mode = "n" },
    -- { "<leader>op", "<cmd>ObsidianPasteImg<cr>", desc = "Paste image", mode = "n" },
  },
}
