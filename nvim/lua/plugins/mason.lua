-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        "typescript-language-server", 
        "emmet-ls",   -- for html, css autocompletion
        "tailwindcss-language-server", 
        "gopls", -- Go language server
        "biome", -- rust based plugin replacement for eslint & prettier (it does both linting and formatting ts,js,json files) (struggling for larger tsx files over 1800 lines)
        -- "eslint-lsp", -- sometimes causing unwanted issues in ts files
        -- "tinymist", -- for typst
      },
    },
  },
}
