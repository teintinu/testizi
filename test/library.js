/* jslint node: true */
"use strict";

var chai = require('chai');
var Yadda = require('yadda');
var recast = require('recast');

var English = Yadda.localisation.English;
var Dictionary = Yadda.Dictionary;

var assert = chai.assert;

var testizi = require('../lib/testizi');

module.exports = (function () {

    var parsed_expression, parse_error;

    var dictionary = new Dictionary()
        .define('OPERATOR', /([^\u0000]*)/)
        .define('ASSERTION', /([^\u0000]*)/)
        .define('ERROR', /([^\u0000]*)/)
        .define('LINE', /(\d*)/)
        .define('COL', /(\d*)/)
        .define('JSON', /([^\u0000]*)/);

    return English.library(dictionary)

    .given("parseExpression must support $OPERATOR", function (op, next) {
        parsed_expression = null;
        parse_error = null;
        next();
    })

    .when("(?:try )?parse expression $ASSERTION", function (assertion, next) {
        try {
            parsed_expression = testizi.parseExpression(assertion);
        } catch (e) {
            parse_error = e;
        }
        next();
    })

    .then("result must be $JSON", function (json, next) {
        if (parse_error)
            assert.fail(parse_error);
        var expected_expression = JSON.parse(json);
        assert.isObject(parsed_expression, 'parsed expression is not an object');
        assert.equal(parsed_expression.operator, expected_expression.operator, 'operator');
        assert.equal(parsed_expression.name, expected_expression.name, 'function name');
        assert.deepEqual(parsed_expression.args, expected_expression.args, 'args');
        if (expected_expression.expected)
            assert.equal(recast.print(parsed_expression.expected),
                expected_expression.expected, 'expected');
        next();
    })

    .then("must throw $ERROR", function (error, next) {
        assert.throw(function () {
            if (parse_error)
                throw parse_error;
        }, new RegExp(error));
        next();
    });

})();
