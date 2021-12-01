// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

    /*
        Building out the minting function:
            a. we want an NFT to point to an address
            b. we want to keep track of the token Ids
            c. we want to keep track of the token owner addresses to token Ids
            d. we want to keep track of how many tokens an owner address has
            e. create an event that emits a transfer log - contract address, where it is being minted to, & the Id

    */
contract ERC721 {

    event Transfer(address indexed from, address indexed to, uint indexed tokenId);

    mapping(uint => address) private _tokenOwner;

    mapping(address => uint) private _OwnedTokensCount;

    function _exists(uint tokenId) internal view returns(bool){
        address owner = _tokenOwner[tokenId];
        return owner !=address(0);
    }

    function _mint(address to, uint tokenId) internal {
        // requires that the address isn't zero
        require(to != address(0), 'ERC721: minting to the 0 address');
        
        // requires that the token does not already exist
        require(!_exists(tokenId), 'ERC721: Token already minted');

        // Adding new address with a tokenId for minting
        _tokenOwner[tokenId] = to;

        // keeping track of each address that is minting and adding one to the count
        _OwnedTokensCount[to] += 1; 

        emit Transfer(address(0), to, tokenId);
    }

}