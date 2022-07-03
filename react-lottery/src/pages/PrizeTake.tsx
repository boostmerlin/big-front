import { FiChevronLeft } from 'react-icons/fi';
import { useNavigate } from 'react-router-dom';
import './PrizeTake.css';
import RedPacket from '../components/RedPacket';
import { shuffle, flatten, take, chunk } from 'lodash';
import { loadPrizes, Prize, takePrize } from '../model';
import { useState } from 'react';
import Row from '../components/Row';
import Animate from '../components/Animate';

const numberOfCandidates = 6;
const numberOfCandidatesInAChunk = numberOfCandidates / 2;

const generateCandidates = (prizes: Prize[]): Prize[][] =>
  chunk(take(shuffle(flatten(prizes.map(v=>{
    return new Array(v.count).fill({name: v.name, count: 1})
  }))), numberOfCandidates), numberOfCandidatesInAChunk);

function Back() {
  const navi = useNavigate();
  const handleBack = async () => {
    navi('/configure');
  };
  return (
    <div className="back" onClick={handleBack}>
      <FiChevronLeft color="#c3a26e" size="4vh" />
    </div>
  );
}

export default function PrizeTake() {
  const [prizes, setPrizes] = useState(loadPrizes)
  const candidates = generateCandidates(prizes)
  return (
    <div> 
      <Back />
      <div className="container">
        {candidates.map((c, i)=> (
          <Row key={i}>
            {c.map((r, j)=>(
              <Animate play={true}>
                <RedPacket key={j} name={r.name} open={false}/>
              </Animate>
            ))}
          </Row>
        ))}
      </div>
    </div>
  );
}
