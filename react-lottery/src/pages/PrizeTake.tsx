import { FiArrowLeftCircle } from "react-icons/fi";
import { useNavigate, Navigate } from "react-router-dom";
import "common/css/PrizeTake.css";
import RedPacket from "../components/RedPacket";
import { loadPrizes, Prize, takePrize, hasAnyPrizes } from "common/model";
import { useState } from "react";
import { memoize } from 'lodash'
import Row from "../components/Row";
import { ANI_TIME, Animate } from "../components/Animate";
import { generateCandidates } from "common/model/util";

function Back() {
  const navi = useNavigate();
  const handleBack = async () => {
    window.playAppear();
    navi("/configure");
  };
  return (
    <div className="back" onClick={handleBack}>
      <FiArrowLeftCircle color="#c3a26e" size="4vh" />
    </div>
  );
}

const candidatesMemo = memoize(generateCandidates);

export default function PrizeTake() {
  const [prizes, setPrizes] = useState(loadPrizes);
  const [selected, setSelected] = useState<Prize | null>(null);
  const [round, setRound] = useState(0);

  const onOpen = (prize: Prize) => {
    window.playHooray();
    setSelected(prize);
  };
  const onTakePrize = () => {
    if (!selected) {
      window.playError();
      return;
    }
    window.playAppear();
    console.log(`You got ${selected.name}`);
    setPrizes(takePrize(selected));
    setSelected(null);
    setRound(round + 1);
  };

  const active = selected === null;

  if (!hasAnyPrizes()) {
    return <Navigate to="/configure" />;
  }

  const candidates = candidatesMemo(prizes);
  console.log(candidates);

  return (
    <div>
      <Back />
      <div className="container" onClick={onTakePrize}>
        {candidates.map((c, i) => (
          <Row key={i}>
            {c.map((r, j) => (
              <Animate
                key={j}
                active={active}
                delay={(i * 3 + j) * ANI_TIME * 0.8}
              >
                <RedPacket
                  active={active}
                  round={round}
                  prize={r}
                  onOpen={onOpen}
                />
              </Animate>
            ))}
          </Row>
        ))}
      </div>
    </div>
  );
}
