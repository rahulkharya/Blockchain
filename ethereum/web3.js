import Web3 from "web3";

let web3;

if ( typeof window !== "undefined" && typeof window.ethereum !== "undefined") {

    // we are in the browser and metamask is running
    window.ethereum.request({ method : "eth_requestAccounts" });
    web3 = new Web3(window.ethereum);

} else {

    // we are on the server or the user is not running metamask
    const provider = new Web3.providers.HttpProvider(

        'https://rinkeby.infura.io/v3/3bf4d6cb38dc471b945401338973569c'

    );

    web3 = new Web3(provider);

}


// const web3 = new Web3(window.web3.currentProvider);

export default web3;