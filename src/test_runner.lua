local function addfenv(f, env)
  local env = setmetatable(env, { __index = getfenv(f) })
  setfenv(f, env)
  return f
end

return function(f)
  local results = {}

  local function It(prefix, its)
    return function(name, f)
      table.insert(its, { name = prefix .. ' ' .. name, f = f })
    end
  end

  local function describe(name, f)
    local its = {}

    local env = {
      -- describe = describe,
      it = It(name, its)
    }

    addfenv(f, env)()

    for _, it in ipairs(its) do
      local ok, err = pcall(it.f)
      table.insert(results, { name = it.name, pass = ok, error = err })
    end
  end

  local env = setmetatable({
    describe = describe
  }, { __index = getfenv(f) })

  setfenv(f, env)()

  return results
end
