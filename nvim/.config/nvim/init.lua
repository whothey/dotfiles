require('remap')
require('set')
require('abbrev')
require('plugin-manager')
require('autocmds')
require('custom-config-loader')

require('vim._core.ui2').enable();

if (os.getenv("TERM_PROGRAM") == "WezTerm") then
  require('wezterm')
end

if vim.g.vscode then
    require("vscode")
end

if vim.g.neovide then
  require('neovide')
end
