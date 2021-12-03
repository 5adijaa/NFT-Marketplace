// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';
import './interfaces/IERC721Enumerable.sol';

contract ERC721Enumerable is ERC721, IERC721Enumerable{

    uint[] private _allTokens;

    // mapping from tokenId to position in _allTokens array
    mapping(uint => uint) private _allTokensIndex;

    // mapping of owner to list of all owner token ids
    mapping(address => uint[]) private _ownedTokens;

    // mapping from token ID to index of the owner tokens list 
    mapping(uint => uint) private _ownedTokensIndex;

    // @notice Count NFTs tracked by this contract
    // @return A count of valid NFTs tracked by this contract, where each one of
    ///  them has an assigned and queryable owner not equal to the zero address
    // function totalSupply() external view returns (uint){
    //     return _allTokens.length;
    //     // Return the total Supply of _allTokens array
    // }

    // @notice Enumerate valid NFTs
    // @dev Throws if `_index` >= `totalSupply()`.
    // @param _index A counter less than `totalSupply()`
    // @return The token identifier for the `_index`th NFT,
    //  (sort order not specified)
    //function tokenByIndex(uint _index) external view returns (uint);

    // @notice Enumerate NFTs assigned to an owner
    // @dev Throws if `_index` >= `balanceOf(_owner)` or if
    //  `_owner` is the zero address, representing invalid NFTs.
    // @param _owner An address where we are interested in NFTs owned by them
    // @param _index A counter less than `balanceOf(_owner)`
    // @return The token identifier for the `_index`th NFT assigned to `_owner`,
    //   (sort order not specified)
    //function tokenOfOwnerByIndex(address _owner, uint _index) external view returns (uint256);

    function _mint(address to, uint tokenId) internal override(ERC721) {
        super._mint(to, tokenId);
        // 2 things we need:
        // A. add tokens to the owner
        // B. all tokens to our totalsuppy - to allTokens
        //_addTokensToTotalSupply(tokenId);
        _addTokensToAllTokenEnumeration(tokenId); 
        _addTokensToOwnerEnumeration(to, tokenId);
    }

    function _addTokensToAllTokenEnumeration(uint tokenId) private{
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push();
    }

    function _addTokensToOwnerEnumeration(address to, uint tokenId) private {
        // 1. add address and token id to the _ownedTokens
        // 2. ownedTokensIndex tokenId set to address of ownedTokens position
        // 3. we want to execute the function with minting
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);

    }

    // A helper function that returns tokenByIndex
    function tokenByIndex(uint index) public override view returns(uint){
        require(index < totalSupply(), 'global index is out of bounds');
        return _allTokens[index];
    }

    // A function that returns tokenOfOwnerByIndex
    function tokenOfOwnerByIndex(address owner, uint index) public override view returns(uint){
        require(index < this.balanceOf(owner), 'owner index is out of bound');
        return _ownedTokens[owner][index];
    }

    // Replace this function "_addTokensToTotalSupply" with _addTokensToAllTokenEnumeration
    // function _addTokensToTotalSupply(uint tokenId) private {
    //     _allTokens.push(tokenId);
    // }

    function totalSupply() public override view returns(uint){
        return _allTokens.length;
        // Return the total Supply of _allTokens array
    }
}