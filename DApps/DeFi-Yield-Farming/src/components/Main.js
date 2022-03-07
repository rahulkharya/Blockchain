import React, { Component } from "react";
import Web3 from "web3";
import tether from "../tether.png";

class Main extends Component {
	render() {
		return (
			<div id="content" className="mt-3">
				<table className="table text-muted text-center">
					<thead>
						<tr style={{ color: "white" }}>
							<th scope="col">Staking Balance</th>
							<th scope="col">Reward Balance</th>
						</tr>
					</thead>
					<tbody>
						<tr style={{ color: "white" }}>
							<td>
								{Web3.utils.fromWei(this.props.stakingBalance, "ether")} USDT
							</td>
							<td>{Web3.utils.fromWei(this.props.rwdBalance, "ether")} RWD</td>
						</tr>
					</tbody>
				</table>

				<div className="card mb-2" style={{ opacity: ".9" }}>
					<form
						onSubmit={(event) => {
							event.preventDefault();
							let amount;
							amount = this.input.value.toString();
							amount = Web3.utils.toWei(amount, "ether");
							this.props.stakeTokens(amount);
						}}
						className="mb-3"
					>
						<div style={{ borderSpacing: "0 1em" }}>
							<label className="float-left" style={{ marginLeft: "15px" }}>
								<b>Stake Tokens</b>
							</label>
							<span className="float-right" style={{ marginLeft: "8px" }}>
								Balance: {Web3.utils.fromWei(this.props.tetherBalance, "ether")}
							</span>
							<div className="input-group mb-4">
								<input
									ref={(input) => {
										this.input = input;
									}}
									type="text"
									placeholder="0"
									required
								/>
								<div className="input-group-open">
									<div className="input-group-text">
										<img alt="tether" src={tether} height="32" />
										&nbsp;&nbsp;&nbsp;USDT
									</div>
								</div>
							</div>
							<button
								type="submit"
								className="btn btn-primary btn-lg btn-block"
							>
								DEPOSIT
							</button>
						</div>
					</form>
					<button
						type="submit"
						onClick={(event) => {
							event.preventDefault(this.props.unstakeTokens());
						}}
						className="btn btn-primary btn-lg btn-block"
					>
						WITHDRAW
					</button>
					<div className="card-body text-center" style={{ color: "blue" }}>
						AIRDROP
					</div>
				</div>
			</div>
		);
	}
}

export default Main;
