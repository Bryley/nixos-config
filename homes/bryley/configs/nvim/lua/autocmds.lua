

-- Set textwidth for markdown and norg files
vim.cmd([[autocmd FileType markdown,norg,txt setlocal textwidth=80]])

-- Set nix files to have tab be 2 spaces instead of 4
vim.cmd([[autocmd FileType nix setlocal tabstop=2 shiftwidth=2]])
