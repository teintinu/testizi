Feature: Plugin chai.ExpectJs

Scenario: operator [operator]

   Given parseExpression must support [operator]
    When parse expression [assertion]
    Then chai.expectjs result must be [json]

Examples:
operator:ID      ┆ assertion            ┆ json
---------------------------------------------------------------------------------------
true             ┆ a()                  ┆ { "code": "expect($actual,'a()').to.be.true;", 
                 ┆                      ┆   "flags": {} }

---------------------------------------------------------------------------------------
false            ┆ !a()                 ┆ { "code": "expect($actual,'a()').to.be.false;", 
                 ┆                      ┆   "flags": {} }
                 

---------------------------------------------------------------------------------------
equals           ┆ a() == b             ┆ { "code": "expect($actual,'a()').to.be.equal(b);", 
                 ┆                      ┆   "flags": {} }

---------------------------------------------------------------------------------------
deep equals      ┆ a() === b            ┆ { "code": "expect($actual,'a()').to.deep.equal(b);", 
                 ┆                      ┆   "flags": {} }

---------------------------------------------------------------------------------------
greater then     ┆ a() > b              ┆ { "code": "expect($actual,'a()').to.be.above(b);", 
                 ┆                      ┆   "flags": {} }

less then        ┆ a() < b              ┆ { "code": "expect($actual,'a()').to.be.below(b);", 
                 ┆                      ┆   "flags": {} }

greater or       ┆ a() >= b             ┆ { "code": "expect($actual,'a()').to.be.at.least(b);", 
  equal          ┆                      ┆   "flags": {} }

less or          ┆ a() <= b             ┆ { "code": "expect($actual,'a()').to.be.at.most(b);", 
  equal          ┆                      ┆   "flags": {} }

---------------------------------------------------------------------------------------
not equals       ┆ a() != b             ┆ { "code": "expect($actual,'a()').to.not.equal(b);", 
                 ┆                      ┆   "flags": {} }

---------------------------------------------------------------------------------------
not deep equals  ┆ a() !== b            ┆ { "code": "expect($actual,'a()').to.not.deep.equal(b);", 
                 ┆                      ┆   "flags": {} }


@Pending                 
---------------------------------------------------------------------------------------
in               ┆ a() in b             ┆ { "code": "assert.in($actual, b, 'a() in b')", "flags": {in: true} }


@Pending                 
---------------------------------------------------------------------------------------
true             ┆ a() // comment       ┆ { "code": "assert.isTrue($actual, 'a() // comment');", 
  with comment   ┆                      ┆  "flags": {} }

