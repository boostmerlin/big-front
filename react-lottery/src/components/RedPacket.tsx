import "./RedPacket.css";
import React, { useEffect, useState } from "react";
import cx from "classnames";
import { Prize } from "common/model";
interface IProps {
  active: boolean;
  round: number;
  onOpen: (prize: Prize) => void;
  prize: Prize;
}

export default function RedPacket(props: IProps): React.ReactElement {
  const handleOpen = () => {
    setOpen(true);
    props.onOpen(props.prize);
  };
  const [open, setOpen] = useState(true);

  useEffect(() => {
    setOpen(false);
  }, [props.round]);

  return (
    <div className="redpacket">
      <div className="prize">
        <span>{props.prize.name}</span>
      </div>
      <div className={cx("redpacket-lower", { open })} />
      <div className={cx("redpacket-upper", { open })}>
        <div
          className={cx("redpacket-button", { fade: open })}
          onClick={props.active ? handleOpen : undefined}
        >
          開
        </div>
      </div>
    </div>
  );
}
