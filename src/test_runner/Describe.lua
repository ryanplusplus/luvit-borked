local addfenv = require '../util/addfenv'
local It = require './It'

local function Describe(results, prefix)
  local its = {}
  local next

  local function setup(name, f)
    if prefix then
      name = prefix .. ' ' .. name
    end

    next = Describe(results, name)

    addfenv(f, {
      it = It(results, name, its),
      describe = next.setup
    })()
  end

  local function run()
    for _, it in ipairs(its) do
      local ok, err = pcall(it.f)
      table.insert(results, { name = it.name, pass = ok, error = err })
    end

    if next then
      next.run()
    end
  end

  return {
    setup = setup,
    run = run
  }
end

return Describe
