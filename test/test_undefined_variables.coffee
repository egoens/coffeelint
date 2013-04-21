path = require 'path'
vows = require 'vows'
assert = require 'assert'
coffeelint = require path.join('..', 'lib', 'coffeelint')

vows.describe('Undefined Variables').addBatch({

    'Undefined Variables' :

        topic : """
            test = () ->
              myVar = 'Hello, World'
              do =>
                console.log myvar # Oops, typoed here.
            """

        'foo' : (source) ->
            errors = coffeelint.lint(source)
            assert.equal(errors.length, 1)

    'Destructuring Assignments':

        topic : """
            source = [ 'a', 'b' ]
            [ a, b ] = source

            futurists =
              sculptor: "Umberto Boccioni"
              painter:  "Vladimir Burliuk"
              poet:
                name:   "F.T. Marinetti"
                address: [
                  "Via Roma 42R"
                  "Bellagio, Italy 22021"
                ]

            {poet: {name, address: [street, city]}} = futurists

            tag = "<impossible>"

            [open, contents..., close] = tag.split("")
        """

        'foo' : (source) ->
            errors = coffeelint.lint(source)
            assert.equal(errors.length, 0)



}).export(module)

