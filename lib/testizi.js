var fs = require('fs'),
    recast = require('recast'),
    doctrine = require('doctrine');

function getTestsFromFile(filename) {}

function getTestsFromSource(source) {}

function getTestsFromAST(ast) {}

/**
 */

function parseExpression(expression, loc) {
    var ast = recast.parse(expression);
    var expr = ast && ast.program &&
        ast.program.body.length == 1 &&
        ast.program.body[0].expression;
    if (expr.type == 'CallExpression')
        return ret('true', expr);
    else if (expr.type == 'UnaryExpression' && expr.operator == '!')
        return ret('false', expr.argument);
    else if (expr.type == 'BinaryExpression' && //
        ['==', '>', '<', '>=', '<=', '!=', '===', '!==']. //
        indexOf(expr.operator) != -1)
        return ret(expr.operator, expr.left, expr.right);

    throw new Error("Sintax error");

    function ret(op, callexpr, expected) {
        if (callexpr.type != 'CallExpression')
            throw new Error("can't detect function");
        return {
            operator: op,
            name: callexpr.callee.name,
            args: callexpr.arguments,
            expected: expected
        }
    }
}

module.exports = {
    getTestsFromFile: getTestsFromFile,
    getTestsFromSource: getTestsFromSource,
    getTestsFromAST: getTestsFromAST,
    parseExpression: parseExpression
}
