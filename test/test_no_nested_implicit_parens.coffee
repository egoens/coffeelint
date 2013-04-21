path = require 'path'
vows = require 'vows'
assert = require 'assert'
coffeelint = require path.join('..', 'lib', 'coffeelint')

vows.describe('nested implicit parameters').addBatch({

    'nested implicit parameters' :

        topic : """
            # With implicit params it's not clear which of these are intended:
            # someFunction paramOne(paramTwo)
            # someFunction paramOne, paramTwo

            someFunction paramOne paramTwo
            """

        'nested implicit parameters' : (source) ->
            config =
                no_nested_implicit_parens:
                    level : 'error'
            errors = coffeelint.lint(source, config)
            assert.equal(errors.length, 1)
            assert.equal(errors[0].rule, 'no_nested_implicit_parens')

}).export(module)
