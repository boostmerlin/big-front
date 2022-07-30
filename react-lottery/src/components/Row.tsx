import React from "react";
import "common/css/Row.css";

export default function Row({
  children,
}: {
  children: React.ReactNode;
}): React.ReactElement {
  return <div className="Row">{children}</div>;
}
