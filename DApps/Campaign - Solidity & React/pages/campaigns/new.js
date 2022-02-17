import React, { Component, createFactory } from "react";
import Layout from "../../components/Layout";
import { Button, Form, Input, Label, Message } from "semantic-ui-react";
import 'semantic-ui-css/semantic.min.css';
import web3 from "../../ethereum/web3";
import factory from "../../ethereum/factory";
import { Link, Router } from '../../routes';


class CampaignNew extends Component {

    state = {

        minimumContribution : '',
        errorMessage : '',
        loading : false

    };


    onSubmit = async event => {

        event.preventDefault();

        this.setState ({ loading : true, errorMessage : '' });

        try {

        const accounts = await web3.eth.getAccounts();

        await factory.methods
            .createCampaign(this.state.minimumContribution)
            .send({
                from : accounts[0]
            });

        Router.pushRoute("/");

        } catch(err) {

            this.setState ({ errorMessage : err.message });

        }

        this.setState ({ loading : false });

    };


    render() {

        return (

            <Layout>

                <h3>Create a Campaign</h3>

                
                <Form onSubmit = { this.onSubmit }  error = { !!this.state.errorMessage }>

                    <Form.Field>

                        <Label labelPosition = "left">Minimum Contribution</Label>

                        <Input 
                            label = "wei"  
                            labelPosition = "right"
                            value = { this.state.minimumContribution }
                            onChange = {
                                event => this.setState({
                                    minimumContribution : event.target.value
                                })
                            }    
                        
                        />

                    </Form.Field>

                    <Message error header = "OOPS!"  content = { this.state.errorMessage } />

                    <Button  loading = { this.state.loading }  primary>Create</Button>

                </Form>

            </Layout>

        );

    }

}


export default CampaignNew;