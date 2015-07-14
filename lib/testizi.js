var fs = require('fs'),
    recast = require('recast'),
    doctrine = require('doctrine');

function getTestsFromFile(filename) {}

function getTestsFromSource(source) {}

function getTestsFromAST(ast) {}

var REMOVE_STARS_FROM_BEGINNING = /^\s*\*\s*/;
var VALID_OPERATORS = ['==', '>', '<', '>=', '<=', '!=', '===', '!==']

function parseExpression(expression) {
    var ast = recast.parse(expression);
    var expr = ast && ast.program &&
        ast.program.body.length == 1 &&
        ast.program.body[0].expression;
    if (expr.type == 'CallExpression')
        return ret('true', expr);
    else if (expr.type == 'UnaryExpression' && expr.operator == '!')
        return ret('false', expr.argument);
    else if (expr.type == 'BinaryExpression' && //
        VALID_OPERATORS. //
        indexOf(expr.operator) != -1)
        return ret(expr.operator, expr.left, expr.right);

    throw new Error("Sintax error");

    function ret(op, callexpr, expected) {
        if (callexpr.type != 'CallExpression')
            throw new Error("Can't detect function");
        return {
            operator: op,
            name: callexpr.callee.name,
            args: callexpr.arguments,
            expected: expected,
            comment: (expr.comments && expr.comments.length) ? expr.comments[0].value.trim() : undefined
        }
    }
}

function parseJsDoc(text) {
    var jsdoc = doctrine.parse(text, {
        unwrap: true,
        tags: ['test'],
        lineNumbers: true
    });

    return jsdoc.tags.map(function (tag) {
        var expr = tag.description.replace(REMOVE_STARS_FROM_BEGINNING, '');
        var parsed_expr = parseExpression(expr);
        parsed_expr.lineNumber = tag.lineNumber
        return parsed_expr;
    });
}

module.exports = {
    getTestsFromFile: getTestsFromFile,
    getTestsFromSource: getTestsFromSource,
    getTestsFromAST: getTestsFromAST,
    parseExpression: parseExpression,
    parseJsDoc: parseJsDoc
}
