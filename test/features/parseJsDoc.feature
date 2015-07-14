Feature: Parse JsDoc

Scenario: [case]

   Given a JsDoc [case]
    When parse jsdoc [jsdoc]
    Then result must be [json] with tests

Examples:
case:ID          ┆ jsdoc                ┆ json
---------------------------------------------------------------------------------------
simple           ┆ /** sample           ┆ {"title": "sample",
                 ┆ * @test a()          ┆  "tests":[{"operator": "true", 
                 ┆ */                   ┆  "callee": "a", "args": [],
                 ┆                      ┆  "lineNumber": 1}]}
---------------------------------------------------------------------------------------
star forgotten   ┆ /** sample           ┆ {"title": "sample",
                 ┆ @test a()            ┆  "tests":[{"operator": "true", 
                 ┆ */                   ┆  "callee": "a", "args": [],
                 ┆                      ┆  "lineNumber": 1}]}
