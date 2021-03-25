open Relude.Globals
open Js.Promise
open Shape
open Utils

let useGetIP = (~ip=?, ()) => {
  let didCancel = React.useRef(false)
  let (data, setData) = React.useState(() => AsyncResult.init)
  let guard = guardByDidCancel(didCancel)

  React.useEffect0(() => Some(() => didCancel.current = true))

  React.useEffect2(() => {
    guard(() => setData(prev => prev |> AsyncResult.toBusy))

    Fetch.fetch(Endpoint.getIp(~ip?, ()))
    |> then_(parseJsonIfOk)
    |> then_(getErrorBodyJson)
    |> then_(result =>
      result
      |> Result.flatMap(json => json |> IP.decode |> Result.mapError(Error.decode))
      |> resolve
    )
    |> then_(data =>
      guard(() =>
        setData(_prev =>
          switch data {
          | Ok(ok) => AsyncResult.completeOk(ok)
          | Error(err) => AsyncResult.completeError(err)
          }
        )
      ) |> resolve
    )
    |> ignore

    None
  }, (setData, ip))

  data
}
