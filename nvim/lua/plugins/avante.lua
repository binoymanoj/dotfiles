if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
--
-- commented because config didn't work properly (not complete)


return {
  "thenbe/avante.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  event = "VeryLazy",
  opts = {
    -- Avante configuration
    model = {
      -- Use one of the free models
      provider = "ollama", -- Local model using Ollama
      name = "codellama", -- You can also try "llama2" or other models available in Ollama
      
      -- Alternative free option using API
      -- provider = "huggingface",
      -- name = "bigcode/starcoder", -- Free coding model
      -- api_token = os.getenv("HUGGINGFACE_API_TOKEN"), -- Set your HF token in env vars
    },
    
    ui = {
      auto_resize = true,
      width = 50, -- percentage of editor width
      border = "rounded",
    },
    
    keymaps = {
      -- Customize keymaps as needed
      toggle = "<leader>a", -- Toggle Avante
      accept = "<C-y>",    -- Accept suggestion
      reject = "<C-n>",    -- Reject suggestion
      next_suggestion = "<M-j>", -- Navigate to next suggestion
      prev_suggestion = "<M-k>", -- Navigate to previous suggestion
    },
    
    -- Configure code completion behavior
    completion = {
      auto_trigger = true,
      trigger_chars = { ".", ":", "(", "'", '"', ",", " " },
      trigger_delay = 300, -- ms
    },
    
    -- Context settings for AI
    context = {
      include_buffer = true,
      include_cursor_position = true,
      max_lines = 100,
    },
  },
  config = function(_, opts)
    require("avante").setup(opts)
    
    -- Additional custom keymaps if needed
    vim.keymap.set("n", "<leader>ac", function()
      require("avante").complete_line()
    end, { desc = "Avante: Complete current line" })
    
    vim.keymap.set("n", "<leader>af", function()
      require("avante").complete_function()
    end, { desc = "Avante: Complete function" })
  end,
}
