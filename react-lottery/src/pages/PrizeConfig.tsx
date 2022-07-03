import React from 'react';
import { PRIZE_CONFIG, NO_PRIZE } from '../model/Strings';
import {
    loadPrizes,
    updatePrize,
    Prize,
    totalPrizes,
    removePrize,
    addPrize,
    hasAnyPrizes,
} from '../model';
import { FiMinusCircle, FiPlayCircle, FiPlusCircle } from 'react-icons/fi';
import Row from '../components/Row'
import './PrizeConfig.css';

export default class PrizeConfig extends React.Component< any, { prizes: Prize[] } > {
    constructor(props: object) {
        super(props);
        this.state = {
            prizes: loadPrizes(),
        };
    }

    //注意，这里不需要绑定this对象
    handleNameChange(index: number) {
        return (event: React.ChangeEvent<HTMLInputElement>) => {
            const name = event.target.value;
            console.log(index)
            const newState = updatePrize(index, { name });
            this.setState({ prizes: newState });
        };
    }

    handleCountChange(index: number) {
        return (event: React.ChangeEvent<HTMLInputElement>) => {
            const value = event.target.value;
            const newState = updatePrize(index, { count: parseInt(value) });
            this.setState({ prizes: newState });
        };
    }

    handleRemove(index: number) {
        return () => {
            if (window.confirm(`确定要删除奖品：${this.state.prizes[index].name}`)) {
                const newState = removePrize(index);
                this.setState({ prizes: newState });
            }
        };
    }

    handleAdd = () => {
        this.setState({ prizes: addPrize() });
    };

    handleStart = () => {
        if (hasAnyPrizes()) {
            window.location.href = '/take'
            // useNavigate()('/take')
        } else {
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
                            <th>奖品</th>
                            <th>数量</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        {this.state.prizes.map(({ name, count }, index) => (
                            <tr key={index}>
                                <td>
                                    <input
                                        name="name"
                                        placeholder="奖品名称"
                                        value={name}
                                        onChange={this.handleNameChange(index)}
                                    />
                                </td>
                                <td>
                                    <input
                                        name="count"
                                        type="number"
                                        max={99}
                                        min={0}
                                        value={count}
                                        onChange={this.handleCountChange(index)}
                                    />
                                </td>
                                <td>
                                    <div className="button" onClick={this.handleRemove(index)}>
                                        <FiMinusCircle size="4vh" color={'red'} />
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
                    <div className="button" onClick={this.handleAdd}>
                        <FiPlusCircle size="5vh" color="#c3a26e" />
                    </div>
                    <div className="button" onClick={this.handleStart}>
                        <FiPlayCircle size="5vh" color="green" />
                    </div>
                </Row>
            </div>
        );
    }
}
