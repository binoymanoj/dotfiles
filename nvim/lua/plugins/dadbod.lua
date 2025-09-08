-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    cmd = { "DB", "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = {
      { "<leader>D", "<cmd>DBUIToggle<cr>", desc = "Toggle DBUI" },
      { "<leader>db", "<cmd>DBUIFindBuffer<cr>", desc = "Find DB buffer" },
      { "<leader>dr", "<cmd>DBUIRenameBuffer<cr>", desc = "Rename DB buffer" },
      { "<leader>dl", "<cmd>DBUILastQueryInfo<cr>", desc = "Last query info" },
    },
    init = function()
      -- Database UI settings
      vim.g.db_ui_save_location = vim.fn.stdpath "data" .. "/db_ui_queries"
      vim.g.db_ui_tmp_query_location = vim.fn.stdpath "data" .. "/db_ui_tmp"
      -- Show database details in statusline
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_use_nerd_fonts = 1
      -- Auto execute table helpers
      vim.g.db_ui_auto_execute_table_helpers = 1
      -- Use telescope for selection if available
      if pcall(require, "telescope") then
        vim.g.db_ui_use_telescope = 1
      end
      -- Force write the buffer when executing queries
      vim.g.db_ui_force_echo_notifications = 1
      -- Default connection (optional - you can set this to your most used DB)
      -- vim.g.dbs = {
      --   dev = "postgresql://user:password@localhost:5432/mydb",
      --   staging = "mysql://user:password@localhost:3306/mydb",
      -- }
    end,
    config = function()
      -- Enable completion for SQL files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "sql,mysql,plsql",
        callback = function()
          require("cmp").setup.buffer {
            sources = {
              { name = "vim-dadbod-completion" },
              { name = "buffer" },
              { name = "path" },
            },
          }
        end,
      })
      -- Custom keymaps for SQL buffers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "sql,mysql,plsql",
        callback = function()
          local opts = { buffer = true, silent = true }
          vim.keymap.set("n", "<leader>r", "<Plug>(DBUI_ExecuteQuery)", opts)
          vim.keymap.set("v", "<leader>r", "<Plug>(DBUI_ExecuteQuery)", opts)
        end,
      })
    end,
  },
}
