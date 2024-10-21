import "animate.css";

export const ANI_TIME = 0.3;

const animation = {
  animation: `${ANI_TIME * 2}s backInDown ease backwards`,
  animationDelay: 0,
};

export const Animate = ({ delay, children, active }) => (
  <div
    style={active ? { ...animation, animationDelay: `${delay}s` } : undefined}
  >
    {children}
  </div>
);
