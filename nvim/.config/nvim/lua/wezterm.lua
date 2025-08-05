local function can_move_window_old(direction)
  local current_win = vim.api.nvim_get_current_win()
  local current_pos = vim.api.nvim_win_get_position(current_win)
  local wins = vim.api.nvim_list_wins()

  for _, win in ipairs(wins) do
    if win ~= current_win then
      local pos = vim.api.nvim_win_get_position(win)
      if direction == 'h' and pos[2] < current_pos[2] and pos[1] == current_pos[1] then
        return true
      elseif direction == 'l' and pos[2] > current_pos[2] and pos[1] == current_pos[1] then
        return true
      elseif direction == 'k' and pos[1] < current_pos[1] and pos[2] == current_pos[2] then
        return true
      elseif direction == 'j' and pos[1] > current_pos[1] and pos[2] == current_pos[2] then
        return true
      end
    end
  end
  return false
end

local function can_move_window(direction)
  -- Quick check using winnr first
  local current_winnr = vim.fn.winnr()
  local target_winnr = vim.fn.winnr(direction)

  if current_winnr == target_winnr then
    return false
  end

  -- Double-check by attempting movement
  local current_win = vim.api.nvim_get_current_win()
  local ok, _ = pcall(vim.cmd, 'wincmd ' .. direction)

  if not ok then
    return false
  end

  local new_win = vim.api.nvim_get_current_win()

  local moved = (new_win ~= current_win)
  if moved then
    vim.api.nvim_set_current_win(current_win)
  end

  return moved
end

local function smart_move(direction)
  if can_move_window(direction) then
    vim.cmd('wincmd ' .. direction)
  else
    local dir_map = {
      h = "left",
      j = "down",
      k = "up",
      l = "right",
    }
    vim.fn.system("wezterm cli activate-pane-direction " .. dir_map[direction])
  end
end

vim.keymap.set('n', '<C-h>', function() smart_move('h') end, { silent = true })
vim.keymap.set('n', '<C-j>', function() smart_move('j') end, { silent = true })
vim.keymap.set('n', '<C-k>', function() smart_move('k') end, { silent = true })
vim.keymap.set('n', '<C-l>', function() smart_move('l') end, { silent = true })
