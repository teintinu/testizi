Feature: Plugin mocha

Scenario: operator [operator]

   Given parseExpression must support [operator]
    When parse expression [assertion]
    Then chai.expectjs result must be [json]

Examples:

case:ID          ┆ js                                        ┆ generated test
---------------------------------------------------------------------------------------
simple test      ┆ /** Returns the sum of a and b            ┆ var expect=require('chai').expect;
                 ┆  * @param {Number} a                      ┆ 
                 ┆  * @param {Number} b                      ┆ describe('simple test', function(){
                 ┆  * @returns {Number} Sum of a and b       ┆   describe('function: sum', function(){
                 ┆  * @test sum(1,1) == 2                    ┆     it('sum(1,1) must be equals to 2', function() {
                 ┆  * @test @pending sum(4,2) == 6           ┆       var $actual = sum(1,1);
                 ┆  * @test sum(7,-3) == 4                   ┆       expect(actual, 'sum(1,1) == 2')
                 ┆ */                                        ┆         .to.be.equal(2); 
                 ┆ function sum(a,b) {                       ┆     });
                 ┆   return a + b;                           ┆     itx('sum(4,2) must be equals to 6', functi
                 ┆ }                                         ┆       var $actual = sum(4,2);
                 ┆                                           ┆       expect(actual, 'sum(4,2)')
                 ┆                                           ┆         .to.be.equal(6); 
                 ┆                                           ┆     });
                 ┆                                           ┆     it('sum(1,1) must be equals to 2', function() {
                 ┆                                           ┆       var $actual = sum(1,1);
                 ┆                                           ┆       expect(actual, 'sum(1,1) == 2')
                 ┆                                           ┆         .to.be.equal(2); 
                 ┆                                           ┆     });
                 ┆                                           ┆   });
                 ┆                                           ┆ });                 