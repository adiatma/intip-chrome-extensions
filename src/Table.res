@react.component
let make = (
  ~lng: float,
  ~lat: float,
  ~city: string,
  ~country: string,
  ~isp: string,
  ~_as: string,
) => {
  <table className="table table-info">
    <thead>
      <tr>
        <th> {`Coordinate` |> React.string} </th>
        <th> {`City` |> React.string} </th>
        <th> {`Country` |> React.string} </th>
        <th> {`ISP` |> React.string} </th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td> {`${lng |> Belt.Float.toString}, ${lat |> Belt.Float.toString}` |> React.string} </td>
        <td> {city |> React.string} </td>
        <td> {country |> React.string} </td>
        <td> {`${isp} (${_as})` |> React.string} </td>
      </tr>
    </tbody>
  </table>
}
