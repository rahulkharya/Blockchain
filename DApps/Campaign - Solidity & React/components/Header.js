import React from "react";
import { Menu } from "semantic-ui-react";
import { Link } from "../routes";

const headerLayout = () => {

    return (

        <Menu style = {{ marginTop : '50px' }}>

            <Link route = "/">

                <a className = "item">IdyllicCoin</a>

            </Link>


            <Menu.Menu position = "right">

                <Link route = "/">

                <a className = "item">Campaigns</a>

                </Link>


                <Link route = "/campaigns/new">

                <a className = "item">+</a>

                </Link>


            </Menu.Menu>

        </Menu>

    );

};

export default headerLayout;