# neovim

## install

```
mv ~/.config/nvim ~/.config/nvim-backup
git clone https://github.com/dhensen/my-nvim.git ~/.config/nvim

or
git clone git@github.com:dhensen/my-nvim.git ~/.config/nvim

nvim
```

The first line backs up your existing neovim config if you have it.
It will open up neovim and install plugins etc.

## Issues

- After moving from packer to Lazy, TSUpdate runs on every restart. Run :checkhealth and search for `packer` remove left over dirs/files and you're good.
