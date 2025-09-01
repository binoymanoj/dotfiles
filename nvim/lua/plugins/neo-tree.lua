if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- implemented for testing the git undo last commit feature, I've contributed neo-tree
return {
  "nvim-neo-tree/neo-tree.nvim",
  url = "https://github.com/binoymanoj/neo-tree.nvim.git", -- Replace with your fork URL
  branch = "main", -- or whatever branch you're using
  opts = {
    -- Your existing neo-tree configuration
    window = {
      mappings = {
        -- ["gd"] = "git_undo_last_commit", -- Add your new mapping
        -- ... other existing mappings
      },
    },
  },
}
