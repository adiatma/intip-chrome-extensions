import React from "react";

const Search = ({ onChange }) =>
  React.useMemo(
    () => (
      <input
        className="form-control m-2"
        placeholder="eg: 125.167.114.30"
        onChange={onChange}
      />
    ),
    [onChange]
  );

export default Search;
