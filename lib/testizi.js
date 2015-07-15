var fs = require('fs'),
    recast = require('recast'),
    doctrine = require('doctrine');

var REMOVE_STARS_FROM_BEGINNING = /^\s*\*\s*/;
var SIMPLE_ANNOTATION_REGEX = /^\s*@([^= ]*)/;
var NVP_ANNOTATION_REGEX = /^\s*@([^= ]*)=([^= ]*)/;
var VALID_OPERATORS = ['==', '>', '<', '>=', '<=', '!=', '===', '!==', 'in']

function parseSourceFromFile(filename) {
    return parseSourceFromString(filename, fs.readFileSync(filename, 'utf-8'));
}

function parseSourceFromString(filename, source) {
    var ast = recast.parse(source);
    return parseSourceFromAST(filename, ast);
}

function parseSourceFromAST(filename, ast) {
    var functions = [];
    recast.visit(ast, {
        visitExportDeclaration: function (path) {
            parseTestsForFunction(path.node.declaration, path.node);
            this.traverse(path);
        },
        visitFunctionDeclaration: function (path) {
            parseTestsForFunction(path.node, path.node);
            this.traverse(path);
        }
    });

    return {
        filename: filename,
        functions: functions
    };

    function parseTestsForFunction(decl, stmt) {
        var fntests;
        if (typeof decl.comments && decl.comments.length)
            fntests = parseJsDoc(decl.comments[0].value);
        else if (typeof stmt.comments && stmt.comments.length)
            fntests = parseJsDoc(stmt.comments[0].value);
        if (fntests) {
            fntests.name = decl.id && decl.id.name;
            fntests.code = decl;
            functions.push(fntests);
        }
    }
}

function parseExpression(expression) {
    var match, annotations = {};

    do {
        if (match = NVP_ANNOTATION_REGEX.exec(expression)) {
            annotations[match[1].trim()] = match[2].trim();
            expression = expression.replace(NVP_ANNOTATION_REGEX, '').trim();
        } else if (match = SIMPLE_ANNOTATION_REGEX.exec(expression)) {
            annotations[match[1].trim()] = true;
            expression = expression.replace(SIMPLE_ANNOTATION_REGEX, '').trim();
        }
    } while (match);

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
    else if (expr.type == 'SequentialExpressionTODO')
        new Error("TODO: typeof 'string', a<1");
    else if (expr.type == 'BetweenExpressionTODO')
        new Error("TODO: 1<a()<=5");
    else if (expr.type == 'TAGExpressionTODO')
        new Error("TODO: a() == TAG");
    else if (expr.type == 'RegularExpressionsTODO')
        new Error("TODO: a() matches /.*/");

    throw new Error("Sintax error");

    function ret(op, callexpr, expected) {
        if (callexpr.type != 'CallExpression')
            throw new Error("Can't detect function");
        return {
            operator: op,
            call: recast.prettyPrint(callexpr, {
                reuseWhitespace: false,
                tabWidth: 2,
                trailingComma: false
            }).code,
            callee: callexpr.callee.name,
            args: callexpr.arguments,
            expected: expected,
            comment: (expr.comments && expr.comments.length) ? expr.comments[0].value.trim() : '',
            annotations: annotations
        }
    }
}

function parseJsDoc(text) {
    var jsdoc = doctrine.parse(text, {
        unwrap: true,
        tags: ['test', 'throw'],
        lineNumbers: true
    });

    return {
        title: jsdoc.description,
        tests: jsdoc.tags.map(function (tag) {
            if (tag.title == 'test') {
                var expr = tag.description.replace(REMOVE_STARS_FROM_BEGINNING, '');
                var parsed_expr = parseExpression(expr);
                parsed_expr.lineNumber = tag.lineNumber
                return parsed_expr;
            } else {
                throw 'TODO: throw'
            }
        })
    };
}

module.exports = {
    parseSourceFromFile: parseSourceFromFile,
    parseSourceFromString: parseSourceFromString,
    parseSourceFromAST: parseSourceFromAST,
    parseExpression: parseExpression,
    parseJsDoc: parseJsDoc
}
