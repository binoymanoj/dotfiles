return {
  "nvim-neorg/neorg",
  lazy = false,
  version = "*",
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.concealer"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "~/Notes/01 Inbox/",
          },
          default_workspace = "notes",
        },
      },
      ["core.keybinds"] = {
        config = {
          default_keybinds = true,
        },
      },
    },
  },
}
