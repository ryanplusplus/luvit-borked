  return {
    name = 'ryanplusplus/luvit-borked',
    version = '0.0.1',
    description = 'RSpec-like testing framework for Luvit',
    tags = { 'test', 'testing', 'tdd', 'bdd' },
    license = 'MIT',
    author = { name = 'Ryan Hartlage', email = 'ryanplusplus@gmail.com' },
    homepage = 'https://github.com/ryanplusplus/luvit-borked',
    dependencies = {
      'luvit/luvit@2.9.1',
      'luvit/deep-equal@0.1.2'
    },
    files = {
      '**.lua',
      '!spec*'
    }
  }
