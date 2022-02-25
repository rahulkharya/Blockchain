// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

import './interfaces/IERC721Enumerable.sol';

contract ERC721Enumerable is IERC721Enumerable, ERC721 {

    uint256[] private _allTokens;

    // mapping from tokenId to position in _allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;

    // mapping of owner to owned token ids
    mapping(address => uint256[]) private _ownedTokens;

    // mapping from tokenId index of the owned token list
    mapping(uint256 => uint256) private _ownedTokensIndex;


    constructor() {

        _registerInterface(bytes4(keccak256('totalSupply(bytes4)')^
                                  keccak256('tokenByIndex(bytes4)')^
                                  keccak256('tokenOfOwnerByIndex(bytes4)')));

    }


    // returns token by index
    function tokenByIndex(uint256 _index) external view override returns (uint256) {

        // checking that the index is not out of range
        require( _index < totalSupply(), "global index is out of bound");
        
        return _allTokens[_index];

    }


    // returns token of owner by index
    function tokenOfOwnerByIndex(address _owner, uint256 _index) external view override returns (uint256) {

        // checking that the owner index is not out of range
        require( _index < balanceOf(_owner), "owner index is out of range");
        
        return _ownedTokens[_owner][_index];

    }


    // add tokens to the _allTokens array and set the position of the index
    function _addTokensToAllTotalEnumeration(uint256 tokenId) private {

        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);

    }


    // return the total supply of the _allTokens array
    function totalSupply() public view override returns (uint256) {

        return _allTokens.length;

    }


    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {

        // add address and token id to the _ownedTokens
        _ownedTokens[to].push(tokenId);
        
        // ownedTokensIndex, tokenId set to address of ownedTokens position
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;

        // execute this function with minting

    }


    function _mint(address to, uint256 tokenId) internal override(ERC721) {

        super._mint(to, tokenId);

        // add tokens to _allTokens
        _addTokensToAllTotalEnumeration(tokenId);

        // add tokens to the owner
        _addTokensToOwnerEnumeration(to, tokenId);

    }

}