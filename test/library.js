/* jslint node: true */
"use strict";

var chai = require('chai');
var Yadda = require('yadda');
var recast = require('recast');

var English = Yadda.localisation.English;
var Dictionary = Yadda.Dictionary;

var assert = chai.assert;

var testizi = require('../lib/testizi');

var parsed_expression, parse_error;

var dictionary = new Dictionary()
    .define('TEXT', /([^\u0000]*)/)
    .define('NUM', /(\d*)/);

var library = English.library(dictionary)

.given("parseExpression must support $TEXT", function (op, next) {
    parsed_expression = null;
    parse_error = null;
    next();
})

.when("(?:try )?parse expression $TEXT", function (assertion, next) {
    try {
        parsed_expression = testizi.parseExpression(assertion);
    } catch (e) {
        parse_error = e;
    }
    next();
})

.then("result must be $TEXT with test", function (json, next) {
    assert.isNull(parse_error, parse_error);
    var expected_expression = JSON.parse(json);

    assert.isObject(parsed_expression, 'parsed expression is not an object');

    if (expected_expression.expected)
        parsed_expression.expected = recast.print(parsed_expression.expected).code;
    compare_obj(parsed_expression, expected_expression, '');

    next();
})


.given("a JsDoc $TEXT", function (jsdoc_caase, next) {
    parsed_expression = null;
    parse_error = null;
    next();
})

.when("(?:try )?parse jsdoc $TEXT", function (jsdoc, next) {
    try {
        parsed_expression = testizi.parseJsDoc(jsdoc);
    } catch (e) {
        parse_error = e;
    }
    next();
})

.then("result must be $TEXT with tests", function (json, next) {
    assert.isNull(parse_error, parse_error);
    var expected_expression = JSON.parse('{"tests":' +
        json + "}").tests;

    assert.isArray(parsed_expression, 'parsed expression is not an array');

    if (expected_expression.expected)
        parsed_expression.expected = recast.print(parsed_expression.expected);
    compare_obj(parsed_expression, expected_expression, '');

    next();
})

.given("a javascript source $TEXT", function (jsdoc_case, next) {
    parsed_expression = null;
    parse_error = null;
    next();
})

.when("(?:try )?parse javascript $TEXT", function (js, next) {
    try {
        parsed_expression = testizi.parseSourceFromString(js);
    } catch (e) {
        parse_error = e;
    }
    next();
})

.then("result must be $TEXT with tests for source", function (json, next) {
    assert.isNull(parse_error, parse_error);
    var expected_expression = JSON.parse('{"functions":' +
        json + "}").functions;

    assert.isArray(parsed_expression, 'parsed expression is not an array');

    parsed_expression.forEach(function (fn) {
        fn.tests.forEach(function (t) {
            if (t.expected)
                t.expected = recast.print(t.expected).code;
            t.args = t.args.map(function (a) {
                return recast.print(a).code;
            });
        });
    });

    compare_obj(parsed_expression, expected_expression, '');

    next();
})

.then("must throw $TEXT", function (error, next) {
    assert.throw(function () {
        if (parse_error)
            throw parse_error;
    }, new RegExp(error));
    next();
});

module.exports = library;

function compare_obj(obj_actual, obj_expected, pref) {
    for (var p in obj_expected) {
        assert.isDefined(obj_actual[p], "Expected property " + p + (pref == '' ? '' : ' in ' + pref));
        compare_value(obj_actual[p], obj_expected[p], pref + '.' + p);
    }
}

function compare_value(actual, expected, pref) {
    if (typeof expected === 'object') {
        if (expected instanceof RegExp)
            assert.match(actual, expected, pref);
        else
            compare_obj(actual, expected, pref);
    } else {
        assert.equal(actual, expected, pref);
    }
}
