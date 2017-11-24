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

  test('it should support before_each in a flat describe', function()
    local actual = test_runner(function()
      describe('describe', function()
        local x = 1

        before_each(function()
          x = x + 1
        end)

        it('first', function()
          assert(x == 2)
        end)

        it('second', function()
          assert(x == 3)
        end)
      end)
    end)

    local expected = {
      { name = 'describe first', pass = true },
      { name = 'describe second', pass = true }
    }

    assert(equal(expected, actual))
  end)

  test('it should support after_each in a flat describe', function()
    local actual = test_runner(function()
      describe('describe', function()
        local x = 3

        after_each(function()
          x = x - 1
        end)

        it('first', function()
          assert(x == 3)
        end)

        it('second', function()
          assert(x == 2)
        end)

        it('third', function()
          assert(x == 1)
        end)
      end)
    end)

    local expected = {
      { name = 'describe first', pass = true },
      { name = 'describe second', pass = true },
      { name = 'describe third', pass = true }
    }

    assert(equal(expected, actual))
  end)
end
