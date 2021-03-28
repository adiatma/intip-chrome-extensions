@module("./Map") @react.component
external make: (
  ~lng: float,
  ~lat: float,
  ~zoom: int,
  ~width: string,
  ~height: string,
) => React.element = "default"
