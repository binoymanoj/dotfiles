local dap = require("dap")
local mason_dap = require("mason-nvim-dap")

-- Ensure required DAP adapters are installed
mason_dap.setup({
  ensure_installed = {
    "delve",         -- Go
    "js-debug-adapter", -- JavaScript/TypeScript
  },
  automatic_installation = true,
})

-- Optional: JavaScript debug adapter
for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Node",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
  }
end
