if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "searleser97/mermaid-nvim",
  ft = { "markdown" },
  build = "pip install termaid",
  opts = {
    cmd = { 'termaid' },
    preview_mode = 'tab', -- or 'float'
  },
  config = function()
    -- Disable mermaid rendering in render-markdown to avoid conflicts
    require('render-markdown').setup({
      code = { disable = { 'mermaid' } },
    })
    require('mermaid-nvim').setup()
  end,
}
