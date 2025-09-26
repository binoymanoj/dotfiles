-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazySpec
return {
  -- Treesitter plugin
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "html",
        "javascript",
        "typescript",
        "tsx",
        "astro",
        "go",
        -- "typst",
      },
    },
  },
}
