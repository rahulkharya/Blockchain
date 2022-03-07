const Tether = artifacts.require("Tether");
const RWD = artifacts.require("RWD");
const DecentralBank = artifacts.require("DecentralBank");

module.exports = async (deployer, network, accounts) => {
	// deploying tether
	await deployer.deploy(Tether);
	const tether = await Tether.deployed();

	// deploying reward tokens
	await deployer.deploy(RWD);
	const rwd = await RWD.deployed();

	// deploying decentral bank
	await deployer.deploy(DecentralBank, rwd.address, tether.address);
	const decentralBank = await DecentralBank.deployed();

	// transferring reward tokens to decentral bank
	await rwd.transfer(decentralBank.address, "1000000000000000000000000");

	// transferring tether to investor's account
	await tether.transfer(accounts[1], "10000000000000000");
};
