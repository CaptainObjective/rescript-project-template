let identity = a => a
let getRandomInt = max => Js.Math.random_int(0, max)
let log = a => {
  Js.log(a)
  a
}

let greaterThen = (a, b, ()) => a > b
let greaterThenOrEqual = (a: int, b: int, ()) => a >= b
let lessThen = (a, b, ()) => a < b
let both = (a, b) => a() && b()
let isEqual = (a, b) => a == b
let either = (a, b) => a() || b()
let add = (a, b) => a + b

open Belt.Array
let append = (arr, el) => concat(arr, [el])
let flat = arr => reduce(arr, [], concat)
let mapOptionsToValues = keepMap(_, el => el !== None ? el : None)
let toArray = el => [el]
