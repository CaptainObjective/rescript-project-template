@val external alert: string => unit = "alert"

let root = ReactDOM.Style.make(
  ~border="1px solid black",
  ~display="grid",
  ~gridTemplateRows="repeat(8, 1fr)",
  ~gridTemplateColumns="repeat(8, 1fr)",
  (),
)

@react.component
let make = () => {
  let (cells, setCells) = React.useState(() => Game.cells)

  let gameOver = () => {
    let _ = Js.Global.setTimeout(() => alert("Game over"), 300)
  }

  let revealCells = cell => {
    let cellsToReveal = Game.revealCells(cell)
    setCells(_ => cellsToReveal)
  }

  let handleCellClick = (cell: Game.cell) => {
    switch cell.value {
    | Game.Bomb => gameOver()
    | Warning(_) => revealCells(cell)
    }
  }

  <div style={root}>
    {React.array(
      Js.Array2.map(cells, cell =>
        <Cell
          handleCellClick value={cell.value} x={cell.x} y={cell.y} isRevealed={cell.isRevealed}
        />
      ),
    )}
  </div>
}
