require('remap')
require('set')
require('plugin-manager')
require('custom-config-loader')

if (os.getenv("TERM_PROGRAM") == "WezTerm") then
  require('wezterm')
end

if vim.g.vscode then
    require("vscode")
end

if vim.g.neovide then
  require('neovide')
end
