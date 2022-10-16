-- copied from https://github.com/wbthomason/packer.nvim
--
local download_packer = function()
    print('download_packer')
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  print(install_path)
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

-- this part copied from https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/first_load.lua
return function()
    if not pcall(require, "packer") then
        download_packer()

        return true
    end

    return false
end
