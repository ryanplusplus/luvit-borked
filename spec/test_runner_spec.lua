return function(test)
  local test_runner = require '../src/test_runner'
  local equal = require 'deep-equal'

  test('it should run a single passing test', function()
    local actual = test_runner(function()
      describe('describe', function()
        it('it', function()
        end)
      end)
    end)

    local expected = {
      { name = 'describe it', pass = true }
    }

    assert(equal(expected, actual))
  end)

  test('it should run a single failing test', function()
    local actual = test_runner(function()
      describe('describe', function()
        it('it', function()
          error('fail :(', math.huge)
        end)
      end)
    end)

    local expected = {
      { name = 'describe it', pass = false, error = 'fail :(' }
    }

    assert(equal(expected, actual))
  end)
end
