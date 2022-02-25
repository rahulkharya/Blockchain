// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC165.sol';
import './interfaces/IERC721.sol';
import './libraries/Counters.sol';

contract ERC721 is ERC165, IERC721 {

/*
    // ERC721 event : Transfer
    event Transfer(
        address indexed from, 
        address indexed to,
        uint256 indexed tokenId
        );
    
    // ERC721 event : Approval
    event Approval(
        address indexed owner,
        address indexed approved,
        uint256 indexed tokenId
    );
*/

    // using libraries
    using SafeMath for uint256;
    using Counters for Counters.Counter;

    // mapping token id to the owner
    mapping(uint => address) private _tokenOwner;

    // mapping owner to the number of owned tokens
    mapping(address => Counters.Counter) private _ownedTokensCount;

    // mapping from token ids to approved addresses
    mapping(uint256 => address) private _tokenApprovals;

    // mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;


    constructor() {

        _registerInterface(bytes4(keccak256('balanceOf(bytes4)')^
                                  keccak256('ownerOf(bytes4)')^
                                  keccak256('transferFrom(bytes4)')));

    }

    
    // function : checking balance of owner
    function balanceOf(address _owner) public view returns(uint256) {

        require(_owner != address(0), "address does not exist");
        return _ownedTokensCount[_owner].current();

    }


    // function : finding owner of a token id
    function ownerOf(uint256 _tokenId) public view returns(address) {

        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), "owner address does not exist");
        return owner;

    }

    
    //  function : checking that the owner exists
    function _exists(uint256 tokenId) internal view returns(bool) {

        // assigning the address of the token owner to further check
        // the availibility of new token
        address owner = _tokenOwner[tokenId];

        // return truthiness that address is not zero
        return owner != address(0);

    }
    
    
    // function : minting the transactions
    function _mint(address to, uint256 tokenId) internal virtual {

        // requires that the address isn't zero
        require(to != address(0), "ERC721: cannot be minted to address zero");

        // requires that the token does not already exists
        require(!_exists(tokenId) , "ERC721: token already minted");
        
        // we are adding new address with a token id for minting
        _tokenOwner[tokenId] = to;

        // increasing owned tokens count of the address added in the above line
        _ownedTokensCount[to].increment();

        emit Transfer(address(0), to, tokenId);

    }


    // function : transfer transaction
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {

        require( _to != address(0), "Error-ERC721: Transfer to the zero address");
        require( ownerOf(_tokenId) == _from, "Error-ERC721: Only owner can do the transaction");

        _ownedTokensCount[_from].decrement();
        _ownedTokensCount[_to].increment();

        _tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);

    }


    function transferFrom(address _from, address _to, uint256 _tokenId) public {

        require(isApprovedOrOwner(msg.sender, _tokenId), "Error-ERC721: Only owner can perform the transfer");

        _transferFrom(_from, _to, _tokenId);

    }


    // function : approving the transaction
    function approve(address _to, uint256 _tokenId) public {

        address owner = ownerOf(_tokenId);

        // checking that owner is not transferring to itself
        require( _to != owner , "Error-ERC721: Owner cannot transfer to itself");
        
        // checking that only the owner will approve the transfer
        require( msg.sender == owner, "Error-ERC721: Only owner can approve the transaction");

        // updating the map of the approved addresses
        _tokenApprovals[_tokenId] = _to;

        // emmiting Approval event
        emit Approval(owner, _to, _tokenId);

    }


    // function : approving token Id
    function getApproved(uint256 tokenId) public view returns (address) {

        // checking that tokenId exists
        require( _exists(tokenId), "Error-ERC721: Token id does not exist");

        return _tokenApprovals[tokenId];  

    }


    // function : 
    function isApprovedForAll(address owner, address operator) public view returns (bool) {

        return _operatorApprovals[owner][operator];

    }
    
    
    // function : returns whether spender is allowed to manage tokenId
    function isApprovedOrOwner(address spender, uint256 tokenId) internal view virtual returns (bool) {

        // checking that tokenId exists
        require( _exists(tokenId), "Error-ERC721: Token id does not exist");

        address owner = ownerOf(tokenId);

        return( spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender) );

    }

}