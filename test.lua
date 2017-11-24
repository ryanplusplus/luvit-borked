require 'luvit'(function()
  local function Test(spec)
    return function(name, f)
      local ok, err = pcall(f)
      if not ok then
        print('x ' .. spec .. ' ' .. name .. ' failed with error "' .. err .. '"')
      end
    end
  end

  local specs = {
    './spec/test_runner_spec.lua'
  }

  for _, spec in ipairs(specs) do
    require(spec)(Test(spec))
  end
end)
