local addfenv = require '../util/addfenv'
local Describe = require './Describe'

return function(f)
  local results = {}

  local describe = Describe(results)
  addfenv(f, { describe = describe.setup })()
  describe.run()

  return results
end
