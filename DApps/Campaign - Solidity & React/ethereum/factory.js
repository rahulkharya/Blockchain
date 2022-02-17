import web3 from "./web3";
import CampaignFactory from "./build/CampaignFactory.json";

const instance = new web3.eth.Contract(

    JSON.parse(CampaignFactory.interface),
    '0x99a52d32714B58cf425aC512E91d35385A99434B'

);

export default instance;