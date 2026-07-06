-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "3rd/diagram.nvim",
  dependencies = { "3rd/image.nvim" },
  opts = {
    renderer_options = {
      mermaid = { theme = "dark" },
    },
  },
}
