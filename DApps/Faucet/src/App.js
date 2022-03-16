import detectEthereumProvider from "@metamask/detect-provider";
import { loadContract } from "./utils/load-contract";
import { useCallback, useEffect, useState } from "react";
import Web3 from "web3";
import "./App.css";

function App() {

	const [web3Api, setWeb3Api] = useState({
		provider: null,
		web3: null,
		contract: null,
		isProviderLoaded: false

	});

	const [balance, setBalance] = useState(null)
	const [account, setAccount] = useState(null)
	const [shouldReload, reload] = useState(false)

	const canConnectToContract = account && web3Api.contract
	const reloadEffect = useCallback(() => reload(!shouldReload), [shouldReload])

	const setAccountListener = provider => {

		// provider.on("accountsChanged", accounts => setAccount(accounts[0]))
		// replacing above line
		provider.on("accountsChanged", _ => window.location.reload())
		provider.on("chainChanged", _ => window.location.reload())

		// alternative method - this will not work perfectly
		// provider._jsonRpcConnection.events.on("notification", payload => {
		// 	const {method} = payload

		// 	if(method === "metamask_unlockStateChanged") {
		// 		setAccount(null)
		// 	}
		// })
	}

	useEffect(() => {

		const loadProvider = async () => {

			// connecting to ethereum/web3 using detect-provider
			const provider = await detectEthereumProvider();
			
			if(provider) {
				
				const contract = await loadContract("Faucet", provider)
				
				setAccountListener(provider)
				
				setWeb3Api({
					web3: new Web3(provider),
					provider,
					contract,
					isProviderLoaded: true
				});

			} else {

				// setWeb3Api({...web3Api, isProviderLoaded: true})
				// replacing above line with below line of code
				setWeb3Api(api => ({...api, isProviderLoaded: true})

				)

				console.error("Please install Metamask.")
			}

			// Old way of detecting provider
			// if (window.ethereum) {
			// 	provider = window.ethereum;
			// 	try {
			// 		// await provider.enable();
			// 		await provider.request({ method: "eth_requestAccounts" });
			// 	} catch {
			// 		console.error("User denied accounts access!");
			// 	}
			// } else if (window.web3) {
			// 	provider = window.web3.currentProvider;
			// } else if (!process.env.production) {
			// 	provider = new Web3.providers.HttpProvider("http://localhost:7545");
			// }
		};
	
		loadProvider();
	
	}, []);

	useEffect(() => {

		const loadBalance = async () => {

			const {contract, web3} = web3Api
			const balance = await web3.eth.getBalance(contract.address)
			setBalance(web3.utils.fromWei(balance, 'ether'))

		}

		web3Api.contract && loadBalance()

	}, [web3Api, shouldReload])

	useEffect(() => {

		const getAccounts = async () => {
			const accounts = await web3Api.web3.eth.getAccounts();
			setAccount(accounts[0]);
		};

		web3Api.web3 && getAccounts();

	}, [web3Api.web3])


	const addFunds = useCallback(async () => {

		const {contract, web3} = web3Api
		await contract.addFunds({
			from: account,
			value: web3.utils.toWei("1", "ether")
		})

		// automatically reload browser window
		// window.location.reload()

		// instead of above line we can also use
		reloadEffect()

	}, [web3Api, account, reloadEffect])


	const withdraw = async () => {

		const {contract, web3} = web3Api
		const withdrawAmount = web3.utils.toWei("0.1", "ether")

		await contract.withdraw(withdrawAmount, {
			from: account
		})

		reloadEffect()

	}


	return (
		<>
			<div className="faucet-wrapper">
				
				<div className="faucet">
					
				{ web3Api.isProviderLoaded ?
					<div className="is-flex is-align-items-center">

						<span>
							<strong className="mr-2">Account: </strong>
						</span>
						
							{account ? 
							<div>{account}</div> :					
							!web3Api.provider ?
							<>
								<div className="notification is-warning is-size-6 is-rounded">
									Wallet is not detected!{`  `}
									<a 
										rel='noreferrer'
										target="_blank" 
										href="https://docs.metamask.io">
										Install Metamask
									</a>
								</div>
							</> :
							
							<button 
								className="button is-dark is-rounded"
								onClick = {() => {
									web3Api.provider.request({method: "eth_requestAccounts"})
								}}	
							>
								Connect Wallet
							</button>
							}
					
					</div> :
					<span>Looking for web3 ... </span>
				}
					<div className="balance-view is-size-2 my-4">
						Current Balance: <strong>{balance}</strong> ETH
					</div>

					{

						!canConnectToContract && 
						<i className="is-block">
							Please connect to Ganache!
						</i>

					}
					
					<button
						disabled = {!canConnectToContract}
						onClick={addFunds} 
						className="button is-link mr-2">
						Donate 1 Ether
					</button>
					
					<button
						disabled = {!canConnectToContract}
						onClick={withdraw} 
						className="button is-primary">
						Withdraw .1 Ether
					</button>
				
				</div>
			
			</div>
		</>
	);
}

export default App;
