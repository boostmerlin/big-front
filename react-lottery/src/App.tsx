import {
  BrowserRouter as Router,
  Routes,
  Route,
  Navigate,
} from "react-router-dom";
import PrizeConfig from "./pages/PrizeConfig";
import PrizeTake from "./pages/PrizeTake";
import "common/js/Sound"
window.playBg();

function App() {
  return (
    <Router>
      <Routes>
        <Route path="*" element={<Navigate to="/configure" />} />
        <Route path="/configure" element={<PrizeConfig />} />
        <Route path="/take" element={<PrizeTake />} />
      </Routes>
    </Router>
  );
}

export default App;
