@val external alert: string => unit = "alert"

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
let make = (~value: Game.value) => {
  let (isClicked, setIsClicked) = React.useState(_ => false)
  let onClick = _ => {
    setIsClicked(_ => true)
    if value === Game.Bomb {
      let _ = Js.Global.setTimeout(() => alert("Game over"), 300)
    }
  }
  let style = getStyle(isClicked)
  let content = isClicked ? value : Game.Warning(0)
  // let content = value
  <div style onClick> {<CellContent content />} </div>
}
