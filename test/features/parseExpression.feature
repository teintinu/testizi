Feature: Parse expression

Scenario: [operator]

   Given parseExpression must support [operator]
    When parse expression [assertion]
    Then result must be [json] with test

Examples:
operator:ID      ┆ assertion            ┆ json
---------------------------------------------------------------------------------------
true             ┆ a()                  ┆ {"operator": "true", 
                 ┆                      ┆  "callee": "a", "args": []}
---------------------------------------------------------------------------------------
false            ┆ !a()                 ┆ {"operator": "false", 
                 ┆                      ┆  "callee": "a", "args": []}
---------------------------------------------------------------------------------------
equals           ┆ a() == b             ┆ {"operator": "==",
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b"}
---------------------------------------------------------------------------------------
deep equals      ┆ a() === b             ┆ {"operator": "===",
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b"}
---------------------------------------------------------------------------------------
greater          ┆ a() > b              ┆ {"operator": ">",
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b"}
---------------------------------------------------------------------------------------
less             ┆ a() < b              ┆ {"operator": "<", 
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b"}
---------------------------------------------------------------------------------------
greater or equal ┆ a() >= b             ┆ {"operator": ">=",
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b"}
---------------------------------------------------------------------------------------
less or equal    ┆ a() <= b             ┆ {"operator": "<=", 
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b"}
---------------------------------------------------------------------------------------
not equals       ┆ a() != b             ┆ {"operator": "!=", 
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b"}
---------------------------------------------------------------------------------------
not deep equals  ┆ a() !== b            ┆ {"operator": "!==", 
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b"}

---------------------------------------------------------------------------------------
true             ┆ a() // comment       ┆ {"operator": "true", 
  with comment   ┆                      ┆  "callee": "a", "args": [],
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
false            ┆ !a() // comment      ┆ {"operator": "false", 
  with comment   ┆                      ┆  "callee": "a", "args": [],
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
equals           ┆ a() == b // comment  ┆ {"operator": "==", 
  with comment   ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
deep equals      ┆ a() === b // comment ┆ {"operator": "===",
  with comment   ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
greater          ┆ a() > b // comment   ┆ {"operator": ">", 
  with comment   ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
less             ┆ a() < b // comment   ┆ {"operator": "<", 
  with comment   ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
greater or equal ┆ a() >= b // comment  ┆ {"operator": ">=", 
  with comment   ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
less or equal    ┆ a() <= b // comment  ┆ {"operator": "<=", 
  with comment   ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
not equals       ┆ a() != b // comment  ┆ {"operator": "!=", 
  with comment   ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
not deep equals  ┆ a() !== b // comment ┆ {"operator": "!==", 
  with comment   ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "comment": "comment"}
