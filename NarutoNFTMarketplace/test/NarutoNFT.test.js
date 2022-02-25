const { assert } = require("chai");
const { FormControlStatic } = require("react-bootstrap");
const narutoNFT = artifacts.require("./NarutoNFT");

require("chai")
	.use(require("chai-as-promised"))
	.should();

contract("NarutoNFT", (accounts) => {
	let contract;

	// this will be executed before each test
	beforeEach(async () => {
		contract = await narutoNFT.deployed();
	});

	// testing containers

	describe("deployment", async () => {
		it("deploys successfully", async () => {
			const address = await contract.address;

			assert.notEqual(address, "", "address cannot be empty");
			assert.notEqual(address, null, "address cannot be null");
			assert.notEqual(address, undefined, "address cannot be undefined");
			assert.notEqual(address, 0x0, "invalid address");
		});

		it("verifies NFT name", async () => {
			const name = await contract.name();

			assert.equal(name, "NarutoNFT", "NFT name does not match");
		});

		it("verifies NFT symbol", async () => {
			const symbol = await contract.symbol();

			assert.equal(symbol, "NARUTO", "NFT symbol does not match");
		});
	});

	describe("minting", async () => {
		it("creates a new token", async () => {
			const result = await contract.mint("https...1");
			const totalSupply = await contract.totalSupply();

			// Success
			assert.equal(totalSupply, 1);

			const event = result.logs[0].args;
			assert.equal(
				event._from,
				"0x0000000000000000000000000000000000000000",
				"from is msg.sender"
			);
			assert.equal(event._to, accounts[0], "to is msg.sender");

			// Failure
			await contract.mint("https...1").should.be.rejected;
		});
	});

	describe("indexing", async () => {
		it("lists Naruto NFTs", async () => {
			// minting 3 new tokens
			await contract.mint("https...2");
			await contract.mint("https...3");
			await contract.mint("https...4");

			const totalSupply = await contract.totalSupply();

			// looping through list and extracting NarutoNFTs
			let result = [];
			let NarutoNFT;

			for (i = 1; i <= totalSupply; i++) {
				NarutoNFT = await contract.narutoNFT(i - 1);
				result.push(NarutoNFT);
			}

			// assert that the actual and expected outcome are the same
			let expected = ["https...1", "https...2", "https...3", "https...4"];

			assert.equal(result.join(","), expected.join(","));
		});
	});
});
