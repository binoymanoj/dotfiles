-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
--
-- Plugin for viewing/editing CSV and TSV files within Neovim
return {
  "hat0uma/csvview.nvim",
  -- load when editing CSV/TSV
  ft = { "csv", "tsv" },
  opts = {
    parser = {
      -- which comment prefixes to ignore
      comments = { "#", "//" },
      -- Reduced async processing for better responsiveness
      -- async_chunksize = 10,
      -- Quote character for fields containing delimiters
      -- quote_char = '"',
      -- Max lines to look ahead for multi-line fields
      -- max_lookahead = 50,
    },
    view = {
      min_column_width = 5,
      spacing = 2,
      -- to get the vertical borders like Excel:
      display_mode = "border",
      header_lnum = true,
      sticky_header = {
        enabled = true,
        separator = "─",   -- line under header
      },
    },
    -- Auto-detection fallbacks (in priority order)
    -- fallbacks = { ",", "\t", ";", "|", ":", " " },
    keymaps = {
      -- for Excel-like navigation
      jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
      jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
      jump_next_row = { "<Enter>", mode = { "n", "v" } },
      jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      textobject_field_inner = { "if", mode = { "o", "x" } },
      textobject_field_outer = { "af", mode = { "o", "x" } },
      -- Additional mappings
      -- { "<leader>cv", ":CsvViewToggle<CR>", mode = "n", desc = "Toggle CSV view" },
      -- { "<leader>cb", ":CsvViewToggle display_mode=border<CR>", mode = "n", desc = "CSV border mode" },
      -- { "<leader>ch", ":CsvViewToggle display_mode=highlight<CR>", mode = "n", desc = "CSV highlight mode" },
    },
    parser_delimiter = nil, -- use auto detection
  },
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  config = function(_, opts)
    require("csvview").setup(opts)
    -- Custom highlight groups for better Excel-like appearance
    vim.api.nvim_set_hl(0, "CsvViewDelimiter", { fg = "#6c7086", bold = true })
    vim.api.nvim_set_hl(0, "CsvViewHeaderLine", { fg = "#f9e2af", bg = "#313244", bold = true })
    vim.api.nvim_set_hl(0, "CsvViewStickyHeaderSeparator", { fg = "#89b4fa", bold = true })
    -- Alternating column colors for better readability
    vim.api.nvim_set_hl(0, "CsvViewCol0", { bg = "#1e1e2e" })
    vim.api.nvim_set_hl(0, "CsvViewCol1", { bg = "#181825" })
    vim.api.nvim_set_hl(0, "CsvViewCol2", { bg = "#1e1e2e" })
    vim.api.nvim_set_hl(0, "CsvViewCol3", { bg = "#181825" })
    vim.api.nvim_set_hl(0, "CsvViewCol4", { bg = "#1e1e2e" })
    vim.api.nvim_set_hl(0, "CsvViewCol5", { bg = "#181825" })
    vim.api.nvim_set_hl(0, "CsvViewCol6", { bg = "#1e1e2e" })
    vim.api.nvim_set_hl(0, "CsvViewCol7", { bg = "#181825" })
    vim.api.nvim_set_hl(0, "CsvViewCol8", { bg = "#1e1e2e" })
    -- Auto-enable CSV view for CSV/TSV files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "csv", "tsv" },
      callback = function()
        -- Auto-enable CSV view with border mode for CSV files
        vim.defer_fn(function()
          if vim.bo.filetype == "csv" or vim.bo.filetype == "tsv" then
            vim.cmd("CsvViewEnable")
          end
        end, 100)
      end,
      desc = "Auto-enable CSV view for CSV/TSV files"
    })
  end,
}
