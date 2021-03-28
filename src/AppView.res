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
