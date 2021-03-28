@react.component
let make = (~onChange: ReactEvent.Form.t => unit) => {
  <input className="form-control m-2" placeholder="eg: 125.167.114.30" onChange />
}
