open Relude.Globals

module Decode = Decode.AsResult.OfParseError

module IP = {
  type t = {
    _as: string,
    city: string,
    country: string,
    isp: string,
    lat: float,
    lon: float,
    org: string,
  }

  let make = (_as, city, country, isp, lat, lon, org) => {
    _as: _as,
    city: city,
    country: country,
    isp: isp,
    lat: lat,
    lon: lon,
    org: org,
  }

  let decode = (json: Js.Json.t): Result.t<t, Decode.ParseError.failure> => {
    open Decode.Pipeline
    succeed(make)
    |> field("as", string)
    |> field("city", string)
    |> field("country", string)
    |> field("isp", string)
    |> field("lat", floatFromNumber)
    |> field("lon", floatFromNumber)
    |> field("org", string)
    |> run(json)
  }
}
