Feature: Parse Javascript Source

Scenario: [case]

   Given a javascript source [case]
    When parse javascript [js]
    Then result must be [json] with tests for source

Examples:
case:ID          ┆ js                                        ┆ json
---------------------------------------------------------------------------------------
one test         ┆ /** Returns the sum of a and b            ┆ [{
                 ┆  * @param {Number} a                      ┆  "name": "sum",
                 ┆  * @param {Number} b                      ┆  "tests": [  
                 ┆  * @returns {Number} Sum of a and b       ┆    {"operator": "==",  
                 ┆  * @test sum(1,1) == 2                    ┆      "callee": "sum", 
                 ┆ */                                        ┆      "args": [1, 1],
                 ┆ function sum(a,b) {                       ┆      "expected": 2,
                 ┆   return a + b;                           ┆      "lineNumber": 4}
                 ┆ }                                         ┆ ]}]

