# testizi - Easy Test for Node/Javascript
[![Build Status](https://travis-ci.org/thr0w/testizi.png)](https://travis-ci.org/thr0w/testizi) [![Dependencies](https://david-dm.org/thr0w/testizi.svg)](https://david-dm.org/thr0w/testizi) [![Coverage Status](https://img.shields.io/coveralls/thr0w/testizi.svg)](https://coveralls.io/r/thr0w/testizi?branch=master)

> still working, carefull in production enviroments

Parse JSDOC of functions and generates tests for them. 

## Easy function result tests

```javascript
/** 
  @test divide(10, 2) == 5
  @test divide(21, 7) > 20
  @throw divide(2, 0) - /Division by zero/
*/

function sum(a,b){
  if (b==0)
    throw new Error("Division by zero");
  return a/b;
}

```

### Get started

1. `$ npm install testizi`
2. write your code
> Tip: Try copy the sample above. Try force a fail.
3. `$ npm run testizi SOURCE_DIR TARGET_DIR`

### Support
* async (pending)
* callbacks (pending)
* promises (pending)

### Pluggins
* chai/expect.js 
* mocha (pending)
* chai/assert (pending)

### FAQ
1. Why this project?
> lazy to write repeated codes

2. This project solve all situations for write unit tests?
> No, just some situations, generally, repetitive situations.

3. Can I help this project?
> Yeah! We need help! 

4. How I can help?
> Writing documentations, testing, coding...

