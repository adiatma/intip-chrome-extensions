open Relude.Globals

let server = "http://ip-api.com/json/"
let getIp = (~ip=?, ()) =>
  Printf.sprintf("%s/%s", server, ip |> Option.map(ip' => ip') |> Option.getOrElse("/"))
