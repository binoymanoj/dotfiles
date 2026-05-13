hl.curve("smoothSlide", { type = "bezier", points = { { 0.4, 0 }, { 0.2, 1 } } })
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 4, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 0.5, bezier = "easeOutQuint" })
hl.animation({ leaf = "fade", enabled = true, speed = 1, bezier = "quick" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 0.5, bezier = "smoothSlide", style = "slide" })
