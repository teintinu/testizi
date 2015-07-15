/* jslint node: true */
"use strict";

var chai = require('chai');
var chai = chai.use(require('chai-subset'));
var expect = chai.expect;

var Yadda = require('yadda');
var recast = require('recast');
var b = recast.types.builders;

var English = Yadda.localisation.English;
var Dictionary = Yadda.Dictionary;


var testizi = require('../lib/testizi');

var chai_expectjs_plugin = require('../lib/plugins/chai').expectjs;
var bdd_plugin = require('../lib/plugins/bdd').expectjs;

var casename, parsed_expression, parse_error;

var dictionary = new Dictionary()
    .define('TEXT', /([^\u0000]*)/)
    .define('NUM', /(\d*)/);

var library = English.library(dictionary)

.given("parseExpression must support $TEXT", function (op, next) {
    casename = op;
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

    expect(parse_error, 'parse_error').to.be.null;

    var expected_expression = JSON.parse(json);

    expect(parsed_expression, 'parsed expression').to.be.an('object');

    if (expected_expression.expected)
        expected_expression.expected = formatJS('expected', expected_expression.expected);
    if (parsed_expression.expected)
        parsed_expression.expected = formatJS('actual', parsed_expression.expected);

    expect(parsed_expression).to.containSubset(expected_expression);

    next();
})


.given("a JsDoc $TEXT", function (jsdoc_case, next) {
    casename = jsdoc_case;
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
    expect(parse_error, 'parse_error').to.be.null;

    var expected_expression = JSON.parse(json);

    expect(parsed_expression, 'parsed expression').to.be.an('object');

    expected_expression.tests.forEach(function (test) {
        if (test.expected)
            test.expected = formatJS('actual', parsed_expression.expected);
    });
    expect(parsed_expression).to.containSubset(expected_expression);

    next();
})

.given("a javascript source $TEXT", function (jsdoc_case, next) {
    casename = jsdoc_case;
    parsed_expression = null;
    parse_error = null;
    next();
})

.when("(?:try )?parse javascript $TEXT", function (js, next) {
    try {
        parsed_expression = testizi.parseSourceFromString(casename, js);
    } catch (e) {
        parse_error = e;
    }
    next();
})

.then("result must be $TEXT with tests for source", function (json, next) {
    expect(parse_error, 'parse_error').to.be.null;

    var expected_expression = JSON.parse(json);

    expect(parsed_expression, 'parsed expression').to.be.an('object');

    parsed_expression.functions.forEach(function (fn) {
        if (fn.code)
            fn.code = formatJS('actual.' + fn.name + '.code', fn.code);
        fn.tests.forEach(function (t) {
            if (t.expected)
                t.expected = formatJS('actual.' + fn + '.' + t.title + '.expected', t.expected);
            t.args = t.args.map(function (a) {
                return formatJS('actual.' + fn + '.' + t.title + '.arg', a);
            });
        });
    });

    expected_expression.functions.forEach(function (fn) {
        if (fn.code)
            fn.code = formatJS('expected.' + fn.name + '.code', fn.code);
        fn.tests.forEach(function (t) {
            if (t.expected)
                t.expected = formatJS('expected.' + fn + '.' + t.title + '.expected', t.expected);
            t.args = t.args.map(function (a) {
                return formatJS('actual.' + fn + '.' + t.title + '.arg', a);
            });
        });
    });


    expect(parsed_expression).to.containSubset(expected_expression);

    next();

}).then("chai\.expectjs result must be $TEXT", function (json, next) {
    expect(parse_error, 'parse_error').to.be.null;

    var actual = chai_expectjs_plugin(b.identifier('$actual'), parsed_expression);
    var expected = JSON.parse(json);

    if (actual && actual.code)
        actual.code = formatJS('actual', actual.code);
    if (expected && expected.code)
        expected.code = formatJS('expected', expected.code);

    expect(actual).to.containSubset(expected);

    next();
}).then("bdd test must be $TEXT", function (bdd_test, next) {
    expect(parse_error, 'parse_error').to.be.null;

    var actual = bdd_plugin(parsed_expression);
    var expected = recast.parse(bdd_test);

    actual = formatJS('actual', actual);
    expected = formatJS('expected', expected);

    expect(actual).to.equals(expected);

    next();
})

.then("must throw $TEXT", function (error, next) {
    expect(function () {
        if (parse_error)
            throw parse_error;
    }, new RegExp(error));
    next();
});

function formatJS(msg, p) {
    try {
        if (typeof p === 'object' && p.type)
            return formatJS(msg, recast.print(p).code);
        return recast.prettyPrint(recast.parse(p), {
            reuseWhitespace: false,
            tabWidth: 2,
            quote: 'double',
            trailingComma: false
        }).code
    } catch (e) {
        console.error(msg);
        console.error(e);
        throw e;
    }
}

module.exports = library;
