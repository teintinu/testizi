# testizi - Easy Test for Node/Javascript
[![Build Status](https://travis-ci.org/thr0w/testizi.png)](https://travis-ci.org/thr0w/testizi) [![Dependencies](https://david-dm.org/thr0w/testizi.svg)](https://david-dm.org/thr0w/testizi) [![Coverage Status](https://img.shields.io/coveralls/thr0w/testizi.svg)](https://coveralls.io/r/thr0w/testizi?branch=master)

> still working, carefull in production enviroments

Parse JSDOC of functions and generates tests for them. 

## For functions simple functions

```javascript
/** 
  @test sum(1, 1) == 2
  @test sum(1, 1) > 1  
*/

function sum(a,b){
  return a+b;
}

```

### Support
* async (pending)
* callbacks (pending)
* promises (pending)

### Pluggins
* mocha (pending)
