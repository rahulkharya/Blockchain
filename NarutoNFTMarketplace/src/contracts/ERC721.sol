// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721 {

    event Transfer(
        address indexed from, 
        address indexed to,
        uint256 indexed tokenId
        );

    // mapping token id to the owner
    mapping(uint => address) private _tokenOwner;

    // mapping owner to the number of owned tokens
    mapping(address => uint) private _ownedTokensCount;

    
    // checking balance of owner
    function balanceOf(address _owner) public view returns(uint256) {

        require(_owner != address(0), "address does not exist");
        return _ownedTokensCount[_owner];

    }


    // finding owner of a token id
    function ownerOf(uint256 _tokenId) public view returns(address) {

        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), "owner address does not exist");
        return owner;

    }

    
    function _exists(uint256 tokenId) internal view returns(bool) {

        // assigning the address of the token owner to further check
        // the availibility of new token
        address owner = _tokenOwner[tokenId];

        // return truthiness that address is not zero
        return owner != address(0);

    }
    
    function _mint(address to, uint256 tokenId) internal virtual {

        // requires that the address isn't zero
        require(to != address(0), "ERC721: cannot be minted to address zero");

        // requires that the token does not already exists
        require(!_exists(tokenId) , "ERC721: token already minted");
        
        // we are adding new address with a token id for minting
        _tokenOwner[tokenId] = to;

        // increasing owned tokens count of the address added in the above line
        _ownedTokensCount[to]++;

        emit Transfer(address(0), to, tokenId);

    }



}