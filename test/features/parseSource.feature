Feature: Parse Javascript Source

Scenario: [case]

   Given a javascript source [case]
    When parse javascript [js]
    Then result must be [json] with tests for source

Examples:
case:ID          ┆ js                                        ┆ json
---------------------------------------------------------------------------------------
one test         ┆ /** Returns the sum of a and b            ┆ [{name: 'sum',
                 ┆  * @param {Number} a                      ┆  tests: [
                 ┆  * @param {Number} b                      ┆    {"operator": "true",
                 ┆  * @returns {Number} Sum of a and b       ┆      "callee": "sum", 
                 ┆  * @test sum(1,1) == 2                    ┆      "args": [1, 1],
                 ┆ */                                        ┆      "lineNumber": 5}
                 ┆ function sum(a,b) {                       ┆  ]
                 ┆   return a + b;                           ┆ }]
                 ┆ }                                         ┆ 

