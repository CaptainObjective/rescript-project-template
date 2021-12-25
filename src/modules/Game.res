type value = Bomb | Warning(int)

type cell = {
  x: int,
  y: int,
  value: value,
}

let totalWidth = 8
let totalHeight = 8
let totalBombs = 8
let neighbours = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]

open Belt.Array
open Utils

let getRandomPoint = _ => (getRandomInt(totalWidth), getRandomInt(totalHeight))
let bombs = makeBy(totalBombs, getRandomPoint)

let isBomb = candidate => some(bombs, point => isEqual(point, candidate))
let addBombs = cells => reduce(cells, 0, (sum, point) => isBomb(point) ? add(sum, 1) : sum)

let findNeighbours = cell => map(neighbours, ((x, y)) => (add(cell.x, x), add(cell.y, y)))
let isInsideBoard = (coordinate, ()) =>
  both(greaterThen(coordinate, -1), lessThen(coordinate, totalWidth))
let dropOutsiders = keep(_, ((x, y)) => both(isInsideBoard(x), isInsideBoard(y)))

let calculateValue = cell => findNeighbours(cell)->dropOutsiders->addBombs->Warning
let getCellValue = cell => isEqual(cell.value, Bomb) ? Bomb : calculateValue(cell)

let createCells = x => makeBy(totalHeight, y => {x: x, y: y, value: Warning(0)})
let setBomb = ({x, y}) => {x: x, y: y, value: isBomb((x, y)) ? Bomb : Warning(0)}
let setValue = cell => {x: cell.x, y: cell.y, value: getCellValue(cell)}
let getValue = cell => cell.value

let cells =
  makeBy(totalWidth, identity)->map(createCells)->flat->map(setBomb)->map(setValue)->map(getValue)
