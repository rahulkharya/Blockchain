// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Connector.sol';

contract NarutoNFT is ERC721Connector {

    // array to store nfts
    string[] public narutoNFT;

    mapping(string => bool) _narutoNFTExists;

    function mint(string memory _narutoNFT) public {

        require(!_narutoNFTExists[_narutoNFT], "Error: narutoNFT already exists");

        narutoNFT.push(_narutoNFT);
        uint _id = narutoNFT.length - 1;

        _mint(msg.sender, _id);

        _narutoNFTExists[_narutoNFT] = true;

    }
    
    constructor() ERC721Connector("NarutoNFT", "NARUTO") {

    }

}