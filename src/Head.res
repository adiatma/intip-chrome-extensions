@react.component
let make = (~title: string, ~smallTitle: string) => {
  <div>
    <h3 className="text-center">
      {title |> React.string}
      <br />
      <small className="text-muted"> {smallTitle |> React.string} </small>
    </h3>
  </div>
}
