Feature: Parse Javascript Source

Scenario: [case]

   Given a javascript source [case]
    When parse javascript [js]
    Then result must be [json] with tests for source

Examples:
case:ID          ┆ js                                        ┆ json
---------------------------------------------------------------------------------------
one test         ┆ /** Returns the sum of a and b            ┆ {
                 ┆  * @param {Number} a                      ┆  "filename": "one test",
                 ┆  * @param {Number} b                      ┆  "functions": [{
                 ┆  * @returns {Number} Sum of a and b       ┆    "name": "sum",
                 ┆  * @test sum(1,1) == 2                    ┆    "title": "Returns the sum of a and b",
                 ┆ */                                        ┆    "tests": [   
                 ┆ function sum(a,b) {                       ┆      {
                 ┆   return a + b;                           ┆       "operator": "==", 
                 ┆ }                                         ┆        "callee": "sum", 
                 ┆                                           ┆        "args": [1, 1],
                 ┆                                           ┆        "expected": 2,
                 ┆                                           ┆        "title": "sum(1,1) == 2",
                 ┆                                           ┆        "lineNumber": 4
                 ┆                                           ┆      }
                 ┆                                           ┆    ],
                 ┆                                           ┆    "code": "function sum(a,b) {return a + b; }"
                 ┆                                           ┆  }]
                 ┆                                           ┆ }
