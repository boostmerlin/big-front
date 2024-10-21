import {
  BrowserRouter as Router,
  Routes,
  Route,
  Navigate,
} from "react-router-dom";
import PrizeConfig from "../PrizeConfig";
import PrizeTake from "../PrizeTake";

function Index() {
  return (
    <Router>
      <Routes>
        <Route path='*' element={<Navigate to='/configure' />} />
        <Route path='/configure' element={<PrizeConfig />} />
        <Route path='/take' element={<PrizeTake />} />
      </Routes>
    </Router>
  );
}

export default Index;
