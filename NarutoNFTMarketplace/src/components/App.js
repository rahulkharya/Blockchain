import React, { Component } from "react";
import Web3 from "web3";
import "./App.css";
import NarutoNFT from "../abis/NarutoNFT.json";
import detectEthereumProvider from "@metamask/detect-provider";
import {
	MDBCard,
	MDBCardBody,
	MDBCardTitle,
	MDBCardText,
	MDBCardImage,
	MDBBtn,
} from "mdb-react-ui-kit";

class App extends Component {

	async componentDidMount() {
		await this.loadWeb3();
		await this.loadBlockchainData();
	}

	async loadWeb3() {
		const provider = await detectEthereumProvider();

		// checking whether web3 provider is available
		if (provider) {
			console.log("ethereum wallet is connected");
			window.web3 = new Web3(provider);
		} else {
			console.log("no ethereum wallet detected");
		}
	}

	async loadBlockchainData() {
		const web3 = window.web3;
		const accounts = await web3.eth.getAccounts();
		this.setState({ account: accounts[0] });

		// creating constant and assigning blockchain network id
		const networkId = await web3.eth.net.getId();
		const networkData = NarutoNFT.networks[networkId];

		if(networkData) {
			const abi = NarutoNFT.abi;
			const address = networkData.address;
			const contract = new web3.eth.Contract(abi, address);
			this.setState({ contract });

			// calling totalSupply and integrating it with front end
			const totalSupply = await contract.methods.totalSupply().call();
			this.setState({ totalSupply });

			// loading naruto nfts
			for (let i = 1; i <= totalSupply; i++) {
				const NarutoNFT = await contract.methods.narutoNFT(i - 1).call();

				// handling state on the front end
				this.setState({
					narutoNFT: [...this.state.narutoNFT, NarutoNFT],
				});
			}
		} else {
			window.alert("smart contract not deployed");
		}
	}

	// with minting we are sending the information and we need to
	// specify the account
	mint = (naruto) => {
		this.state.contract.methods.mint(naruto).send({ from: this.state.account })
		.once("receipt", (receipt) => {
			this.setState({
				narutoNFT: [...this.state.narutoNFT, NarutoNFT],
			});
		});
	};

	constructor(props) {
		super(props);
		this.state = {
			account: "",
			contract: null,
			totalSupply: 0,
			narutoNFT: [],
		};
	}

	render() {
		return (
			<div className="container-filled">
				{console.log(this.state.narutoNFT)}
				<nav className="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
					<div
						className="navbar-brand col-sm-3 col-md-3 mr-0"
						style={{ color: "white" }}
					>
						Naruto NFTs (Non Fungible Tokens)
					</div>
					<ul className="navbar-nav px-3">
						<li className="nav-item text-nowrap d-none d-sm-none d-sm-block">
							<small className="text-white">{this.state.account}</small>
						</li>
					</ul>
				</nav>

				<div className="container-fluid mt-1">
					<div className="row">
						<main role="main" className="col-lg-12 d-flex text-center">
							<div
								className="content mr-auto ml-auto"
								style={{ opacity: "0.8" }}
							>
								<h1 style={{ color: "black" }}>NarutoNFT - NFT Marketplace</h1>
								<form
									onSubmit={(event) => {
										event.preventDefault();
										const naruto = this.naruto.value;
										this.mint(naruto);
									}}
								>
									<input
										type="text"
										placeholder="Add a file location"
										className="form-control mb-1"
										ref={(input) => (this.naruto = input)}
									/>
									<input
										style={{ margin: "6px" }}
										type="submit"
										className="btn btn-primary btn-black"
										value="MINT"
									/>
								</form>
							</div>
						</main>
					</div>
					<hr></hr>
					<div className="row textCenter">
						{this.state.narutoNFT.map((naruto, key) => {
							return (
								<div>
									<div>
										<MDBCard
											className="token img"
											style={{ maxWidth: "22rem" }}
										>
											<MDBCardImage
												src={naruto}
												position="top"
												height="250rem"
												style={{ marginRight: "4px" }}
											/>
											<MDBCardBody>
												<MDBCardTitle> NarutoNFT </MDBCardTitle>
												<MDBCardText>
													{" "}
													The Naruto NFTs are uniquely generated Naruto images
													from the Naruto universe! There is only one of each
													image and each image can be owned by a single person
													on the Ethereum blockchain.{" "}
												</MDBCardText>
												<MDBBtn href={naruto}>Download</MDBBtn>
											</MDBCardBody>
										</MDBCard>
									</div>
								</div>
							);
						})}
					</div>
				</div>
			</div>
		);
	}
}

export default App;
