return {
  -- add theme
  {
    "catppuccin/nvim",
    opts = {
      transparent_background = true,
    },
  },

  -- add theme to LazyVim
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}

