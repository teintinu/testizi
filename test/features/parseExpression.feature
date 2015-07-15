Feature: Parse expression

Scenario: [operator]

   Given parseExpression must support [operator]
    When parse expression [assertion]
    Then result must be [json] with test

Examples:
operator:ID      ┆ assertion            ┆ json
---------------------------------------------------------------------------------------
true             ┆ a()                  ┆ {"operator": "true", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "call": "a()"}
---------------------------------------------------------------------------------------
false            ┆ !a()                 ┆ {"operator": "false", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "call": "a()"}
---------------------------------------------------------------------------------------
equals           ┆ a() == b             ┆ {"operator": "==", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "call": "a()"}
---------------------------------------------------------------------------------------
deep equals      ┆ a() === b            ┆ {"operator": "===", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "call": "a()"}
---------------------------------------------------------------------------------------
greater then     ┆ a() > b              ┆ {"operator": ">", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "call": "a()"}
---------------------------------------------------------------------------------------
less then        ┆ a() < b              ┆ {"operator": "<", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "call": "a()"}
---------------------------------------------------------------------------------------
greater or equal ┆ a() >= b             ┆ {"operator": ">=", "annotations": {},
    then         ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "call": "a()"}
---------------------------------------------------------------------------------------
less or equal    ┆ a() <= b             ┆ {"operator": "<=", "annotations": {},
    then         ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "call": "a()"}
---------------------------------------------------------------------------------------
not equals       ┆ a() != b             ┆ {"operator": "!=", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "call": "a()"}
---------------------------------------------------------------------------------------
not deep equals  ┆ a() !== b            ┆ {"operator": "!==", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "call": "a()"}
---------------------------------------------------------------------------------------
in               ┆ a() in b             ┆ {"operator": "in", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "call": "a()"}

---------------------------------------------------------------------------------------
true             ┆ a() // comment       ┆ {"operator": "true", "annotations": {},
  with comment   ┆                      ┆  "callee": "a", "args": [],
                 ┆                      ┆  "call": "a()", "comment": "comment"}
                 
---------------------------------------------------------------------------------------
single           ┆ @pending a()         ┆ {"operator": "true", 
                 ┆                      ┆  "annotations": {"pending": true},
  annotations    ┆                      ┆  "callee": "a", "args": [],
                 ┆                      ┆  "call": "a()", "comment": ""}

---------------------------------------------------------------------------------------
nvp              ┆ @key=value a()       ┆ {"operator": "true",
  annotations    ┆                      ┆  "annotations": {"key": "value"},
                 ┆                      ┆  "callee": "a", "args": [],
                 ┆                      ┆  "call": "a()"}

---------------------------------------------------------------------------------------
many             ┆ @x=1 @only @y=2 a()  ┆ {"operator": "true",
  annotations    ┆                      ┆  "annotations": {
                 ┆                      ┆    "x": "1",
                 ┆                      ┆    "only": true,
                 ┆                      ┆    "y": "2"
                 ┆                      ┆  },
                 ┆                      ┆  "callee": "a", "args": [],
                 ┆                      ┆  "call": "a()"}

