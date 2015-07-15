var chai = require('chai');
var recast = require('recast');
var b = recast.types.builders;

function chai_expectjs_asserter(actual, test) {
    switch (test.operator) {
        case 'true':
            return gen('to.be.true');
        case 'false':
            return gen('to.be.false');
        case '==':
            return gen('to.be', 'equal');
        case '===':
            return gen('to.deep', 'equal');
        case '>':
            return gen('to.be', 'above');
        case '<':
            return gen('to.be', 'below');
        case '>=':
            return gen('to.be.at', 'least');
        case '<=':
            return gen('to.be.at', 'most');
        case '!=':
            return gen('to.not', 'equal');
        case '!==':
            return gen('to.not.deep', 'equal');
        default:
            throw new Error("Unsupported operator: " + test.operator);
    }

    function gen_expect() {
        return b.callExpression(b.identifier('expect'), [actual, b.literal(test.call)]);
    }

    function gen(members, fn) {
        var code = append_members(gen_expect(), members);
        if (fn)
            code = b.callExpression(append_members(code, [fn]), [
                test.expected
            ]);
        return {
            code: b.expressionStatement(code),
            flags: []
        }
    }

    function append_members(obj, members) {
        if (typeof members === 'string')
            members = members.split('.');
        members.forEach(function (p) {
            if (typeof p === 'string')
                p = b.identifier(p);
            obj = b.memberExpression(obj, p);
        });
        return obj;
    }
}


module.exports = {
    expectjs: chai_expectjs_asserter
};
