let identity = a => a
let getRandomInt = max => Js.Math.random_int(0, max)
let log = a => {
  Js.log(a)
  a
}
let flat = arr => Belt.Array.reduce(arr, [], Belt.Array.concat)
let greaterThen = (a, b, ()) => a > b
let greaterThenOrEqual = (a: int, b: int, ()) => a >= b
let lessThen = (a, b, ()) => a < b
let both = (a, b) => a() && b()
let isEqual = (a, b) => a == b
let either = (a, b) => a() || b()
let add = (a, b) => a + b
