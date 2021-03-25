import React from "react";

const Head = ({ title, smallTitle }) =>
  React.useMemo(
    () => (
      <div>
        <h3 className="text-center">
          {title}
          <br />
          <small className="text-muted">{smallTitle}</small>
        </h3>
      </div>
    ),
    [title, smallTitle]
  );

export default Head;
