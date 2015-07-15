Feature: Plugin mocha

Scenario: BDD [case]

   Given a javascript source [case]
    When parse javascript [js]
    Then bdd test must be [bdd test]

Examples:

case:ID          ┆ js                                        ┆ bdd test
---------------------------------------------------------------------------------------
simple test      ┆ /** Returns the sum of a and b            ┆ var expect=require('chai').expect;
                 ┆  * @param {Number} a                      ┆ 
                 ┆  * @param {Number} b                      ┆ describe('simple test.', function(){
                 ┆  * @returns {Number} Sum of a and b       ┆   describe('sum - Returns the sum of a and b', function(){
                 ┆  * @test sum(1,1) == 2  // two            ┆     function sum(a,b) {
                 ┆  * @test @pending sum(4,2) == 6           ┆       return a + b;
                 ┆  * @test sum(7,-3) == 4                   ┆     }
                 ┆ */                                        ┆     it('sum(1,1) == 2  // two', function() {
                 ┆ function sum(a,b) {                       ┆       var $actual = sum(1,1);
                 ┆   return a + b;                           ┆       expect($actual, 'sum(1, 1)')
                 ┆ }                                         ┆         .to.be.equal(2); 
                 ┆                                           ┆     });
                 ┆                                           ┆     xit('sum(4,2) == 6', function() {
                 ┆                                           ┆       var $actual = sum(4,2);
                 ┆                                           ┆       expect($actual, 'sum(4, 2)')
                 ┆                                           ┆         .to.be.equal(6); 
                 ┆                                           ┆     });
                 ┆                                           ┆     it('sum(7,-3) == 4', function() {
                 ┆                                           ┆       var $actual = sum(7,-3);
                 ┆                                           ┆       expect($actual, 'sum(7, -3)')
                 ┆                                           ┆         .to.be.equal(4); 
                 ┆                                           ┆     });                 
                 ┆                                           ┆   });                 
                 ┆                                           ┆ });                                  
                 