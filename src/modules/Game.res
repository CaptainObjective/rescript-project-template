type value = Bomb | Warning(int)

type cell = {
  x: int,
  y: int,
  value: value,
  mutable isRevealed: bool,
}

let totalWidth = 8
let totalHeight = 8
let totalBombs = 8
let neighbours = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
let neighbours2 = [(-1, 0), (0, -1), (0, 1), (1, 0)]

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

let createCells = x => makeBy(totalHeight, y => {x: x, y: y, value: Warning(0), isRevealed: false})
let setBomb = ({x, y}) => {x: x, y: y, value: isBomb((x, y)) ? Bomb : Warning(0), isRevealed: false}
let setValue = cell => {x: cell.x, y: cell.y, value: getCellValue(cell), isRevealed: false}

let cells = makeBy(totalWidth, identity)->map(createCells)->flat->map(setBomb)->map(setValue)

//----

let findNeighbours2 = cell => map(neighbours2, ((x, y)) => (add(cell.x, x), add(cell.y, y)))
let pointToCell = ((x, y), cells) =>
  getBy(cells, cell => both(_ => isEqual(x, cell.x), _ => isEqual(y, cell.y)))

let isCellNotRevealed = cell => !cell.isRevealed

let markRevealed = cell => {
  cell.isRevealed = true
  cell
}

let getNearbyCells = (cell, cells) =>
  findNeighbours2(cell)
  ->map(pointToCell(_, cells))
  ->mapOptionsToValues
  ->keep(isCellNotRevealed)
  ->map(markRevealed)

let rec getCellsToReveal = (clickedCell, cells) => {
  switch clickedCell.value {
  | Warning(0) =>
    map(getNearbyCells(clickedCell, cells), getCellsToReveal(_, cells))->flat->concat([clickedCell])
  | Warning(_) => [markRevealed(clickedCell)]
  | Bomb => []
  }
}
let isRevealed = (cell, updatedCells) =>
  some(updatedCells, ({x, y}) => both(_ => isEqual(x, cell.x), _ => isEqual(y, cell.y)))

let updateCell = (updatedCells, cell) => isRevealed(cell, updatedCells) ? markRevealed(cell) : cell
let updateCells = (updatedCells, cells) => map(cells, updateCell(updatedCells))
let revealCells = (cells, clickedCell) => clickedCell->getCellsToReveal(cells)->updateCells(cells)
