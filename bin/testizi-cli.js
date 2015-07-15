var testizi = require('../lib/testizi'),
    glob = require('glob'),
    program = require('commander'),
    mocha_plugin=require('../lib/plugins/mocha');

program.executables = true;
program
    .version('0.0.1');

program
    .command('test [path]')
    .description('run all tests on path')
    .action(runTests);

program.parse(process.argv);

function runTests(path) {
    glob(path + "/**/*.js", {}, function (err, files) {
        if (err)
            throw err;
        mocha_plugin(files);
    })
}
