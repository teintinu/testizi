var recast = require('recast');
var b = recast.types.builders;

function bdd_exporter(parsedSources, asserter, filenameSuffix) {

    return b.program(parsedSources.map(describeSource));

    function describeSource(source) {

        return b.expressionStatement(
            b.callExpression(b.identifier('describe'), [ //
                b.literal(source.fileName + filenameSuffix ? filenameSuffix : ' (testize)'), //
                b.functionExpression(null, [],
                    source.functions.map(describeFunction)
        )]));

    }

    function describeFunction(fn) {
        return b.expressionStatement(
            b.callExpression(b.identifier('describe'), [ //
                b.literal(fn.title || fn.name), //
                b.functionExpression(null, [], [clone_fn(fn)].concat(
                    fn.tests.map(describeTest)))]));
    }

    function describeTest(test) {

        return b.expressionStatement(
            b.callExpression(it_fn_name(), [ //
                b.literal(fn.title || fn.name), //
                b.functionExpression(null, it_fn_args(),
                    test.async ? it_fn_async_body() : it_fn_sync_body())
            ]));

        function it_fn_name() {
            if (test.annotations.pending)
                return b.identifier('xit');
            if (test.annotations.only)
                return b.identifier('it.only');
            return b.identifier('it');
        }

        function it_fn_args() {
            if (test.async)
                [b.identifier('done')];
            return []
        }

        function it_fn_sync_body() {
            var actual = b.identifier('actual');
            var invoke = b.variableDeclaration('var', [
                          b.variableDeclarator(actual, call_fn(test.args))
                        ]);
            var assert_result = asserter.make(actual, test);
            return [invoke_fn, assert_result]
        }

        function it_fn_async_body() {
            switch (test.async) {
                case "callback":
                    throw "TODO";
                case "async":
                    throw "TODO";
                case "promise":
                    throw "TODO";
            }
        }

        if (test.async)
            it_fn(test.message, function (done) {
                asserter(test, done);
            });
        else
            it_fn(test.message, function () {
                var actual =
                    asserter(test);
            });
    }

    function clone_fn(fn) {
        return fn.code;
    }

    function call_fn(fn, args) {
        return b.callExpression(fn.id, args);
    }


}

module.exports = bdd_exporter;
