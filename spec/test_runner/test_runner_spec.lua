return function(test)
  local test_runner = require '../../src/test_runner/test_runner'
  local equal = require 'deep-equal'

  test('it should run tests in a flat describe', function()
    local actual = test_runner(function()
      describe('describe', function()
        it('pass', function() end)

        it('fail', function()
          error('fail :(', math.huge)
        end)
      end)
    end)

    local expected = {
      { name = 'describe pass', pass = true },
      { name = 'describe fail', pass = false, error = 'fail :(' }
    }

    assert(equal(expected, actual))
  end)

  test('it should run tests in a nested describe', function()
    local actual = test_runner(function()
      describe('outer', function()
        it('pass', function() end)

        it('fail', function()
          error('fail outer :(', math.huge)
        end)

        describe('inner', function()
          it('pass', function() end)

          it('fail', function()
            error('fail inner :(', math.huge)
          end)
        end)
      end)
    end)

    local expected = {
      { name = 'outer pass', pass = true },
      { name = 'outer fail', pass = false, error = 'fail outer :(' },
      { name = 'outer inner pass', pass = true },
      { name = 'outer inner fail', pass = false, error = 'fail inner :(' }
    }

    assert(equal(expected, actual))
  end)
end
