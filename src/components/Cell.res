let getStyle = isChecked =>
  ReactDOM.Style.make(
    ~width="10vh",
    ~height="10vh",
    ~fontSize="3rem",
    ~border="1px solid black",
    ~display="flex",
    ~justifyContent="center",
    ~alignItems="center",
    ~backgroundColor=isChecked ? "#A0A0A0" : "#D0D0D0",
    (),
  )

@react.component
let make = (
  ~value: Game.value,
  ~x: int,
  ~y: int,
  ~handleCellClick: Game.cell => unit,
  ~isRevealed: bool,
) => {
  let style = getStyle(isRevealed)
  let content = isRevealed ? value : Game.Warning(0)
  // let content = value
  let onClick = _ => {
    handleCellClick({x: x, y: y, value: value, isRevealed: false})
  }

  <div style onClick> {<CellContent content />} </div>
}
