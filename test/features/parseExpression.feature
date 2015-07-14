Feature: Parse expression

Scenario: [operator]

   Given parseExpression must support [operator]
    When parse expression [assertion]
    Then result must be [json] with test

Examples:
operator:ID      ┆ assertion            ┆ json
---------------------------------------------------------------------------------------
true             ┆ a()                  ┆ {"operator": "true", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": []}
---------------------------------------------------------------------------------------
false            ┆ !a()                 ┆ {"operator": "false", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": []}
---------------------------------------------------------------------------------------
equals           ┆ a() == b             ┆ {"operator": "==", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b"}
---------------------------------------------------------------------------------------
deep equals      ┆ a() === b             ┆ {"operator": "===", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b"}
---------------------------------------------------------------------------------------
greater          ┆ a() > b              ┆ {"operator": ">", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b"}
---------------------------------------------------------------------------------------
less             ┆ a() < b              ┆ {"operator": "<", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b"}
---------------------------------------------------------------------------------------
greater or equal ┆ a() >= b             ┆ {"operator": ">=", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b"}
---------------------------------------------------------------------------------------
less or equal    ┆ a() <= b             ┆ {"operator": "<=", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b"}
---------------------------------------------------------------------------------------
not equals       ┆ a() != b             ┆ {"operator": "!=", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b"}
---------------------------------------------------------------------------------------
not deep equals  ┆ a() !== b            ┆ {"operator": "!==", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b"}

---------------------------------------------------------------------------------------
true             ┆ a() // comment       ┆ {"operator": "true", "annotations": {},
  with comment   ┆                      ┆  "callee": "a", "args": [],
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
false            ┆ !a() // comment      ┆ {"operator": "false", "annotations": {},
  with comment   ┆                      ┆  "callee": "a", "args": [],
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
equals           ┆ a() == b // comment  ┆ {"operator": "==", "annotations": {},
  with comment   ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
deep equals      ┆ a() === b // comment ┆ {"operator": "===", "annotations": {},
  with comment   ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
greater          ┆ a() > b // comment   ┆ {"operator": ">", "annotations": {},
  with comment   ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
less             ┆ a() < b // comment   ┆ {"operator": "<", "annotations": {},
  with comment   ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
greater or equal ┆ a() >= b // comment  ┆ {"operator": ">=", "annotations": {},
  with comment   ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
less or equal    ┆ a() <= b // comment  ┆ {"operator": "<=", "annotations": {},
  with comment   ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
not equals       ┆ a() != b // comment  ┆ {"operator": "!=", "annotations": {},
  with comment   ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
not deep equals  ┆ a() !== b // comment ┆ {"operator": "!==", "annotations": {},
  with comment   ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "comment": "comment"}
---------------------------------------------------------------------------------------
single           ┆ @pending a()         ┆ {"operator": "true", 
                 ┆                      ┆  "annotations": {"pending": true},
  annotations    ┆                      ┆  "callee": "a", "args": []}

---------------------------------------------------------------------------------------
nvp              ┆ @key=value a()       ┆ {"operator": "true",
  annotations    ┆                      ┆  "annotations": {"key": "value"},
                 ┆                      ┆  "callee": "a", "args": []}

---------------------------------------------------------------------------------------
many             ┆ @x=1 @only @y=2 a()  ┆ {"operator": "true",
  annotations    ┆                      ┆  "annotations": {
                 ┆                      ┆    "x": "1",
                 ┆                      ┆    "only": true,
                 ┆                      ┆    "y": "2"
                 ┆                      ┆  },
                 ┆                      ┆  "callee": "a", "args": []}

