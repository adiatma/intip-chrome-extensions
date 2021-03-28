module Root = {
  @react.component
  let make = () => {
    <React.StrictMode> <App /> </React.StrictMode>
  }
}

switch ReactDOM.querySelector("#root") {
| Some(root) => ReactDOM.render(<Root />, root)
| None => ()
}
