import React, { Component } from 'react';
import { Card, Button } from "semantic-ui-react";
import 'semantic-ui-css/semantic.min.css';
import factory from "../ethereum/factory";
import Layout from "../components/Layout";
import { Link } from '../routes';


class CampaignIndex extends Component {

     static async getInitialProps() {

        const campaigns = await factory.methods.getDeployedCampaigns().call();
        
        return { campaigns };

    }

    renderCampaigns() {

        const items = this.props.campaigns.map(address => {

            return {

                header : address,
                description : (

                    <Link route = {`/campaigns/${address}`}>
                        <a>View Campaign</a>
                    </Link>

                ),
                fluid : true

            };

        });

        return < Card.Group items = { items } />;

    }


    render() {

         return (

             <Layout>
             
             <div>
                 
                 <Link route = '/campaigns/new'>
                    <a>
                        <Button 

                            style = {{ marginTop : '30px' }}
                            floated = 'right'
                            content = "Create Campaign"
                            icon = "add circle"
                            primary
                        
                        />
                    </a>
                 </Link>

                 { this.renderCampaigns() }

             </div>

             </Layout>
         );

    }

}

export default CampaignIndex;