open Utils

module Map = {
  @module("./Map") @react.component
  external make: (
    ~lng: float,
    ~lat: float,
    ~zoom: int,
    ~width: string,
    ~height: string,
  ) => React.element = "default"
}

module Search = {
  @module("./Search") @react.component
  external make: (~onChange: ReactEvent.Form.t => unit) => React.element = "default"
}

module Table = {
  @module("./Table") @react.component
  external make: (
    ~lat: float,
    ~lng: float,
    ~country: string,
    ~city: string,
    ~_as: string,
    ~isp: string,
  ) => React.element = "default"
}

module Head = {
  @module("./Head") @react.component
  external make: (~title: string, ~smallTitle: string) => React.element = "default"
}

module AppView = {
  type variantView = Success(Shape.IP.t) | Fail(React.element)

  @react.component
  let make = (~variantView: variantView, ~onChange) => {
    switch variantView {
    | Success(ok) => <>
        <Head title="intip - chrome extension" smallTitle="crafted by - adiatma" />
        <Search onChange />
        <Map lat={ok.lat} lng={ok.lon} zoom={12} width="100%" height="400px" />
        <Table
          lat={ok.lat} lng={ok.lon} city={ok.city} _as={ok._as} country={ok.country} isp={ok.isp}
        />
      </>
    | Fail(children) => <>
        <Head title="intip - chrome extension" smallTitle="crafted by - adiatma" />
        <Search onChange />
        <Map lat={-6.1872} lng={106.779} zoom={12} width="100%" height="400px" />
        {children}
      </>
    }
  }
}

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
