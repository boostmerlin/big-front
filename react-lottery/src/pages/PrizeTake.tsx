import { FiChevronLeft } from "react-icons/fi";
import { useNavigate, Navigate } from "react-router-dom";
import "./PrizeTake.css";
import RedPacket from "../components/RedPacket";
import { loadPrizes, Prize, takePrize, hasAnyPrizes } from "common/model";
import { useEffect, useRef, useState } from "react";
import Row from "../components/Row";
import { ANI_TIME, Animate } from "../components/Animate";
import { generateCandidates } from "common/model/util";

function Back() {
  const navi = useNavigate();
  const handleBack = async () => {
    navi("/configure");
  };
  return (
    <div className="back" onClick={handleBack}>
      <FiChevronLeft color="#c3a26e" size="4vh" />
    </div>
  );
}

export default function PrizeTake() {
  const [prizes, setPrizes] = useState(loadPrizes);
  const [selected, setSelected] = useState<Prize | null>(null);
  const [round, setRound] = useState(0);

  const candidatesRef = useRef<Prize[][]>(generateCandidates(prizes));

  const onOpen = (prize: Prize) => {
    setSelected(prize);
  };

  useEffect(() => {
    candidatesRef.current = generateCandidates(prizes);
  }, [prizes, round]);

  const onTakePrize = () => {
    if (!selected) return;
    console.log(`You got ${selected.name}`);
    setPrizes(takePrize(selected));
    setSelected(null);
    setRound(round + 1);
  };

  const active = selected === null;

  if (!hasAnyPrizes()) {
    return <Navigate to="/configure" />;
  }

  return (
    <div>
      <Back />
      <div className="container" onClick={onTakePrize}>
        {candidatesRef.current?.map((c, i) => (
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

