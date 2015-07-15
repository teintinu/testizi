var testizi = require('../testizi'),
    bdd_plugin = require('./bdd'),
    chai_expectjs_plugin = require('./chai').expectjs,
    recast = require('recast'),
    Mocha = require('mocha'),
    chai = require('chai').use(require('chai-subset'));

var expect = chai.expect;

function createMochaTestFromFile(files) {
    var parsed = files.map(testizi.parseSourceFromFile);
    var bdd_test = bdd_plugin(parsed, chai_expectjs_plugin);
    var code = recast.print(bdd_test).code;
    var def = new Function('require', 'module', 'exports', code);
    var module = {
        exports: {}
    };

    var mocha = new Mocha({
        ui: "tdd",
        reporter: "spec",
        timeout: 60000,
        slow: 10000,
        delay: true
    });

    var suite = new Mocha.Suite('testizi', 'root');
    var runner = new Mocha.Runner(suite);
    var mochaReporter = new mocha._reporter(runner);

    setTimeout(function(){
    def(require, module, module.exports);
    },1);

    runner.run(function (failures) {
        console.log(testResults);
    });
}

module.exports = createMochaTestFromFile;
