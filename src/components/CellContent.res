@react.component
let make = (~content: Game.value) =>
  switch content {
  | Warning(0) => React.string("")
  | Warning(i) => React.string(Belt.Int.toString(i))
  | Bomb => <img src="https://img.icons8.com/emoji/48/000000/bomb-emoji.png" />
  }
