import "common/css/RedPacket.css";
import React, { useEffect, useState } from "react";
import cx from "classnames";
import { Prize } from "common/model";
import { OPEN } from "common/model/Strings";
interface IProps {
  active: boolean
  round: number;
  onOpen: (prize: Prize) => void;
  prize: Prize;
}

export default function RedPacket(props: IProps): React.ReactElement {
  const handleOpen = () => {
    setOpen(true);  
    window.playAppear();
    props.onOpen(props.prize);
  };
  const [open, setOpen] = useState(true);

  useEffect(() => {
    setOpen(false);
  }, [props.round]);

  return (
    <div className={cx("redpacket", { shake: open })}>
      <div className="prize">
        <span>{props.prize.name}</span>
      </div>
      <div className={cx("redpacket-lower", { open })} />
      <div className={cx("redpacket-upper", { open })}>
        <div
          className={cx("redpacket-button", { fade: open })}
          onClick={props.active ? handleOpen : undefined}
        >
          {OPEN}
        </div>
      </div>
    </div>
  );
}
