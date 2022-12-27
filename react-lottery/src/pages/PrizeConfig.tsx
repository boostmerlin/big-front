import React from "react";
import { PRIZE_CONFIG, NO_PRIZE, PRIZE_NAME, PRIZE_COUNT } from "common/model/Strings";
import { loadPrizes, Prize, totalPrizes, hasAnyPrizes } from "common/model";
import { FiMinusCircle, FiPlayCircle, FiPlusCircle } from "react-icons/fi";
import Row from "../components/Row";
import "common/css/PrizeConfig.css";

import * as util from "common/model/util";

export default class PrizeConfig extends React.Component< any, { prizes: Prize[] } > {
  constructor(props: any) {
    super(props);
    this.state = {
      prizes: loadPrizes(),
    };
  }

  updateState = (newState: Prize[]) => {
    this.setState({ prizes: newState });
  };

  handleStart = () => {
    if (hasAnyPrizes()) {
      window.playAppear();
      window.location.href = "/take";
    } else {
      window.playError();
      window.alert(NO_PRIZE);
    }
  };

  render() {
    return (
      <div className="LotteryView">
        <h1 className="title">{PRIZE_CONFIG}</h1>
        <table>
          <thead>
            <tr>
              <th>{PRIZE_NAME}</th>
              <th>{PRIZE_COUNT}</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            {this.state.prizes.map(({ name, count }, index) => (
              <tr key={index}>
                <td>
                  <input
                    name="name"
                    placeholder="配置名称"
                    value={name}
                    onChange={util.handleNameChange(index, this.updateState)}
                  />
                </td>
                <td>
                  <input
                    name="count"
                    type="number"
                    max={99}
                    min={0}
                    value={count}
                    onChange={util.handleCountChange(index, this.updateState)}
                  />
                </td>
                <td>
                  <div
                    className="button"
                    onClick={util.handleRemove(index, this.updateState)}
                  >
                    <FiMinusCircle size="4vh" color={"red"} />
                  </div>
                </td>
              </tr>
            ))}
          </tbody>
          <tfoot>
            <tr>
              <th>共计：</th>
              <td>{totalPrizes()}</td>
            </tr>
          </tfoot>
        </table>
        <Row>
          <div className="button" onClick={util.handleAdd(this.updateState)}>
            <FiPlusCircle size="5vh" color="#c3a26e" />
          </div>
          <div className="button" onClick={this.handleStart}>
            <FiPlayCircle size="5vh" color="green" />
          </div>
        </Row>
        <footer>
          Powered by ml@React
        </footer>
      </div>
    );
  }
}
