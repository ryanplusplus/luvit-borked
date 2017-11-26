local luassert = require 'luassert'
local addfenv = require '../util/addfenv'

return function(results, prefix, its)
  return function(name, f)
    addfenv(f, { assert = luassert })
    table.insert(its, { name = prefix .. ' ' .. name, f = f })
  end
end
