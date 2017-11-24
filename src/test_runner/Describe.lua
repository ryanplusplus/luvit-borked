local addfenv = require '../util/addfenv'
local It = require './It'

local function Describe(results, prefix)
  local its = {}
  local next
  local before, after

  local function setup(name, f)
    if prefix then
      name = prefix .. ' ' .. name
    end

    next = Describe(results, name)

    addfenv(f, {
      it = It(results, name, its),
      describe = next.setup,
      before_each = function(f)
        before = f
      end,
      after_each = function(f)
        after = f
      end
    })()
  end

  local function run()
    for _, it in ipairs(its) do
      if before then before() end
      local ok, err = pcall(it.f)
      if after then after() end

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
