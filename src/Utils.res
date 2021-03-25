open Relude.Globals
open Js.Promise

module Decode = Decode.AsResult.OfParseError

let guardByDidCancel: (React.ref<bool>, unit => unit) => unit = (didCancel, cb) =>
  !didCancel.current ? cb() : ()

let parseJsonIfOk: Fetch.Response.t => Js.Promise.t<
  Result.t<Js.Json.t, Fetch.Response.t>,
> = resp => {
  open Fetch
  if Fetch.Response.ok(resp) {
    resp
    |> Response.json
    |> then_(json => json |> Result.ok |> resolve)
    |> catch(_error => resp |> Result.error |> resolve)
  } else {
    resp |> Result.error |> resolve
  }
}

let getErrorBodyJson: Result.t<Js.Json.t, Fetch.Response.t> => Js.Promise.t<
  Result.t<Js.Json.t, Error.t>,
> = x => {
  open Fetch
  switch x {
  | Ok(_json) as ok => ok |> resolve
  | Error(resp) =>
    resp
    |> Response.json
    |> then_(json =>
      Error.fetch((resp |> Fetch.Response.status, resp |> Fetch.Response.statusText, #json(json)))
      |> Result.error
      |> resolve
    )
  }
}

let isValidIP = (x: string): bool =>
  {
    let re = %re(
      "/^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/"
    )

    Js.Re.test_(re, x)
  }
    ? true
    : false


let debug: AsyncResult.t<'a, 'b> => unit = asynResult =>
    switch asynResult {
    | Init => "Init" |> Js.log
    | Loading => "Loading" |> Js.log
    | Reloading(Ok(_)) => "Reloading(Ok())" |> Js.log
    | Reloading(Error(e)) => Js.log2("Reloading(Error(%o)", e)
    | Complete(Ok(_)) => "Complete(Ok())" |> Js.log
    | Complete(Error(e)) => Js.log2("Complete(Error(%o)", e)
    }
