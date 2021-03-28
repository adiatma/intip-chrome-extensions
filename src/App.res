open Utils

@react.component
let make = () => {
  let (ip, setIp) = React.useState(_ => "")
  let data = Hooks.useGetIP(~ip, ())
  let onChange = event => {
    let value = ReactEvent.Form.target(event)["value"]
    isValidIP(value) ? setIp(_prev => value) : ()
  }

  switch data {
  | Init => React.null
  | Loading =>
    <AppView
      variantView={Fail(
        <div className="d-flex align-items-center">
          <strong> {"Loading..." |> React.string} </strong>
        </div>,
      )}
      onChange
    />
  | Reloading(Ok(ok)) => <AppView variantView={Success(ok)} onChange />
  | Reloading(Error(_)) =>
    <AppView
      variantView={Fail(
        <div className="alert alert-danger" role="alert">
          {React.string("Oops.. something went wrong!")}
        </div>,
      )}
      onChange
    />
  | Complete(Ok(ok)) => <AppView variantView={Success(ok)} onChange />
  | Complete(Error(_)) =>
    <AppView
      variantView={Fail(
        <div className="alert alert-warning" role="alert">
          {React.string("Oops.. something went wrong!")}
        </div>,
      )}
      onChange
    />
  }
}

let default = make
