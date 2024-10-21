import React from "react";
import "common/css/Row.css";
import { View } from "@tarojs/components";

export default function Row({
  children,
}: {
  children: React.ReactNode;
}): React.ReactElement {
  return <View className="Row">{children}</View>;
}
