path = require 'path'
vows = require 'vows'
assert = require 'assert'
coffeelint = require path.join('..', 'lib', 'coffeelint')

vows.describe('blank_lines').addBatch({

    'too many blank lines':

        topic:
            """
            x = 1



            y = 2
            """

        'are permitted by default' : (source) ->
            errors = coffeelint.lint(source)
            assert.isEmpty(errors)

        'can be forbidden' : (source) ->
            config = {blank_lines : {level:'error'}}
            errors = coffeelint.lint(source, config)
            assert.equal(errors.length, 1)

    "too few blank lines":
        topic:
            """
            x = 1

            y = 2
            """

        'are permitted by default' : (source) ->
            errors = coffeelint.lint(source)
            assert.isEmpty(errors)

        'can be configured' : (source) ->
            config =
                blank_lines:
                    level:'error'
                    min: 2
                    max: 2

            errors = coffeelint.lint(source, config)
            assert.equal(errors.length, 1)

    "blank lines in strings":
        topic:
            """
            foo = '''one


            three'''

            # Comment lines are not blank, but may not have tokens.  This is
            # included to verify that comments don't break CoffeeLint.
            bar = 'baz'
            """

        'are ignored': (source) ->
            config =
                blank_lines:
                    level:'error'
                    min: 1
                    max: 1

            errors = coffeelint.lint(source, config)
            assert.isEmpty(errors)



}).export(module)

