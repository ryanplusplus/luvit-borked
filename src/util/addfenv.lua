return function(f, env)
  local env = setmetatable(env, { __index = getfenv(f) })
  setfenv(f, env)
  return f
end
