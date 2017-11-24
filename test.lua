local specs = {
  './spec/test_runner/test_runner_spec.lua'
}

require 'luvit'(function()
  local errors = {}

  local function Test(spec)
    return function(name, f)
      local ok, err = pcall(f)
      if not ok then
        io.write('x')
        table.insert(errors, spec .. ' ' .. name .. ' failed with error "' .. err .. '"')
      else
        io.write('o')
      end
    end
  end

  for _, spec in ipairs(specs) do
    require(spec)(Test(spec))
  end

  if #errors > 0 then
    io.write('\n\n')
    for _, error in ipairs(errors) do
      io.write(error .. '\n')
    end
  end

  io.write('\n')
end)
