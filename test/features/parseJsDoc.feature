Feature: Parse JsDoc

Scenario: [case]

   Given a JsDoc [case]
    When parse jsdoc [jsdoc]
    Then result must be [json] with tests

Examples:
case:ID          ┆ jsdoc                ┆ json
---------------------------------------------------------------------------------------
without star     ┆ /** sample           ┆ [{"operator": "true", 
                 ┆ @test a()            ┆  "name": "a", "args": [],
                 ┆ */                   ┆  "lineNumber": 1}]
---------------------------------------------------------------------------------------
with star        ┆ /** sample           ┆ [{"operator": "true", 
                 ┆ * @test a()          ┆  "name": "a", "args": [],
                 ┆ */                   ┆  "lineNumber": 1}]
