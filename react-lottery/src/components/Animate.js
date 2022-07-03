import cx from "classnames";
import "./Animate.css";
import "animate.css";


const Animate = ({play, children}) => (
    <div className={cx("Animate", {play})}>
        {children}
    </div>
)

export default Animate;

