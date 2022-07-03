import './RedPacket.css';
import React from 'react';

interface IProps {
  name: string;
  open: boolean;
}

export default function RedPacket(props: IProps): React.ReactElement {
  const handleOpen = () => {
    console.log('open');
  };
  return (
    <div className="redpacket">
      <div className="prize">
        <span>{props.name}</span>
      </div>
      <div className="redpacket-lower"></div>
      <div className="redpacket-upper">
        <div className="redpacket-button" onClick={handleOpen}>
          開
        </div>
      </div>
    </div>
  );
}
