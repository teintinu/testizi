Feature: Parse expression

Scenario: [operator]

   Given parseExpression must support [operator]
    When parse expression [assertion]
    Then result must be [json] with test

Examples:
operator:ID      ┆ assertion            ┆ json
---------------------------------------------------------------------------------------
true             ┆ a()                  ┆ {"operator": "true", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "title": "a()"}
---------------------------------------------------------------------------------------
false            ┆ !a()                 ┆ {"operator": "false", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "title": "!a()"}
---------------------------------------------------------------------------------------
equals           ┆ a() == b             ┆ {"operator": "==", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "title": "a() == b"}
---------------------------------------------------------------------------------------
deep equals      ┆ a() === b            ┆ {"operator": "===", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "title": "a() === b"}
---------------------------------------------------------------------------------------
greater then     ┆ a() > b              ┆ {"operator": ">", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "title": "a() > b"}
---------------------------------------------------------------------------------------
less then        ┆ a() < b              ┆ {"operator": "<", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "title": "a() < b"}
---------------------------------------------------------------------------------------
greater or equal ┆ a() >= b             ┆ {"operator": ">=", "annotations": {},
    then         ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "title": "a() >= b"}
---------------------------------------------------------------------------------------
less or equal    ┆ a() <= b             ┆ {"operator": "<=", "annotations": {},
    then         ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "title": "a() <= b"}
---------------------------------------------------------------------------------------
not equals       ┆ a() != b             ┆ {"operator": "!=", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "title": "a() != b"}
---------------------------------------------------------------------------------------
not deep equals  ┆ a() !== b            ┆ {"operator": "!==", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "title": "a() !== b"}
---------------------------------------------------------------------------------------
in               ┆ a() in b             ┆ {"operator": "in", "annotations": {},
                 ┆                      ┆  "callee": "a", "args": [], "expected": "b",
                 ┆                      ┆  "title": "a() in b"}

---------------------------------------------------------------------------------------
true             ┆ a() // comment       ┆ {"operator": "true", "annotations": {},
  with comment   ┆                      ┆  "callee": "a", "args": [],
                 ┆                      ┆  "title": "a() // comment"}
                 
---------------------------------------------------------------------------------------
single           ┆ @pending a()         ┆ {"operator": "true", 
                 ┆                      ┆  "annotations": {"pending": true},
  annotations    ┆                      ┆  "callee": "a", "args": [],
                 ┆                      ┆  "title": "a()"}

---------------------------------------------------------------------------------------
nvp              ┆ @key=value a()       ┆ {"operator": "true",
  annotations    ┆                      ┆  "annotations": {"key": "value"},
                 ┆                      ┆  "callee": "a", "args": [],
                 ┆                      ┆  "title": "a()"}

---------------------------------------------------------------------------------------
many             ┆ @x=1 @only @y=2 a()  ┆ {"operator": "true",
  annotations    ┆                      ┆  "annotations": {
                 ┆                      ┆    "x": "1",
                 ┆                      ┆    "only": true,
                 ┆                      ┆    "y": "2"
                 ┆                      ┆  },
                 ┆                      ┆  "callee": "a", "args": [],
                 ┆                      ┆  "title": "a()"}

