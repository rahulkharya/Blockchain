const HDWalletProvider = require("@truffle/hdwallet-provider");
const Web3 = require("web3");

const compiledFactory = require("./build/CampaignFactory.json");

const provider = new HDWalletProvider(

    'stable popular trend manual balcony digital robust express kite foster together innocent',
    'https://rinkeby.infura.io/v3/3bf4d6cb38dc471b945401338973569c'

);

const web3 = new Web3(provider);


const deploy = async () => {

    const accounts = await web3.eth.getAccounts();

    console.log("Attempting to deploy from account ", accounts[0]);

    const result = await new web3.eth.Contract(

        JSON.parse(compiledFactory.interface)

    )

    .deploy({ data : compiledFactory.bytecode })
    .send({ gas : '1000000', from : accounts[0] })

    console.log('Contract deployed to ', result.options.address);

};


deploy();