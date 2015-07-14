Feature: Report errors

Scenario: [error]

   Given parseExpression must support [operator]
    When try parse expression [assertion]
    Then must throw [error]

Examples:
    assertion          ┆ error
  --------------------------------------------------------------------
    a+1                ┆ Sintax error
                       ┆ 
  --------------------------------------------------------------------
    a+1                ┆ Sintax error
                       ┆ 
