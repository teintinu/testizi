var testizi = require('../lib/testizi'),
    glob = require('glob'),
    program = require('commander');

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
        files.forEach(function (file) {
            var parsed=testizi.parseSourceFromFile(file);
            var mocha_test=
        })
    })
}
