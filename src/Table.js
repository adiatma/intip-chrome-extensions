import React from "react";

const Table = ({ lng, lat, city, country, isp, as }) =>
  React.useMemo(
    () => (
      <table className="table table-info">
        <thead>
          <tr>
            <th>Coordinate</th>
            <th>City</th>
            <th>Country</th>
            <th>ISP</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>{`${lng}, ${lat}`}</td>
            <td>{`${city}`}</td>
            <td>{`${country}`}</td>
            <td>{`${isp} (${as})`}</td>
          </tr>
        </tbody>
      </table>
    ),
    [as, city, country, isp, lat, lng]
  );

export default Table;
