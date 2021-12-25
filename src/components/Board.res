let root = ReactDOM.Style.make(
  ~border="1px solid black",
  ~display="grid",
  ~gridTemplateRows="repeat(8, 1fr)",
  ~gridTemplateColumns="repeat(8, 1fr)",
  (),
)

@react.component
let make = () => {
  <div style={root}>
    {React.array(Js.Array2.map(Game.cells, value => <Cell value={value} />))}
  </div>
}
