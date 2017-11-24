local addfenv = require '../util/addfenv'
local It = require './It'

local function Describe(results, parent_before, parent_after, prefix)
  local its = {}
  local next
  local before, after

  local function do_before()
    if parent_before then parent_before() end
    if before then before() end
  end

  local function do_after()
    if after then after() end
    if parent_after then parent_after() end
  end

  local function setup(name, f)
    if prefix then
      name = prefix .. ' ' .. name
    end

    next = Describe(results, do_before, do_after, name)

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
      do_before()
      local ok, err = pcall(it.f)
      do_after()

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
