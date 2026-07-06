local map = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { buffer = true, desc = desc })
end

-- Promote / Demote
map("<leader>rp", "<Plug>(neorg.promo.promote)",        "[neorg] Promote")
map("<leader>rP", "<Plug>(neorg.promo.promote.nested)", "[neorg] Promote Nested")
map("<leader>rd", "<Plug>(neorg.promo.demote)",         "[neorg] Demote")
map("<leader>rD", "<Plug>(neorg.promo.demote.nested)",  "[neorg] Demote Nested")

-- Lists
map("<leader>rli", "<Plug>(neorg.pivot.list.invert)", "[neorg] Invert List")
map("<leader>rlt", "<Plug>(neorg.pivot.list.toggle)", "[neorg] Toggle List")

-- Misc
map("<leader>ro", "<cmd>Neorg toc<CR>",                              "[neorg] TOC")
map("<leader>ri", "<Plug>(neorg.tempus.insert-date)",                "[neorg] Insert Date")
map("<leader>rz", "<Plug>(neorg.looking-glass.magnify-code-block)",  "[neorg] Magnify Code Block")

-- Todo / Mark states
map("<leader>rmu", "<Plug>(neorg.qol.todo-items.todo.task-undone)",    "[neorg] Todo: Undone")
map("<leader>rmd", "<Plug>(neorg.qol.todo-items.todo.task-done)",      "[neorg] Todo: Done")
map("<leader>rmp", "<Plug>(neorg.qol.todo-items.todo.task-pending)",   "[neorg] Todo: Pending")
map("<leader>rmh", "<Plug>(neorg.qol.todo-items.todo.task-on-hold)",   "[neorg] Todo: On Hold")
map("<leader>rmc", "<Plug>(neorg.qol.todo-items.todo.task-cancelled)", "[neorg] Todo: Cancelled")
map("<leader>rmi", "<Plug>(neorg.qol.todo-items.todo.task-important)", "[neorg] Todo: Important")
map("<leader>rma", "<Plug>(neorg.qol.todo-items.todo.task-ambiguous)", "[neorg] Todo: Ambiguous")
map("<leader>rmr", "<Plug>(neorg.qol.todo-items.todo.task-recurring)", "[neorg] Todo: Recurring")
