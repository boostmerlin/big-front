import React from "react";
import "./Row.css";

export default function Row({
  children,
}: {
  children: React.ReactNode;
}): React.ReactElement {
  return <div className="Row">{children}</div>;
}
