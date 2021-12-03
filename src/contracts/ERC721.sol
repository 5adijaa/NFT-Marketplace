// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './interfaces/IERC165.sol';
import './ERC165.sol';
import './interfaces/IERC721.sol';

    /*
        Building out the minting function:
            a. we want an NFT to point to an address
            b. we want to keep track of the token Ids
            c. we want to keep track of the token owner addresses to token Ids
            d. we want to keep track of how many tokens an owner address has
            e. create an event that emits a transfer log - contract address, where it is being minted to, & the Id

    */
contract ERC721 is ERC165, IERC721 {

    mapping(uint => address) private _tokenOwner;

    mapping(address => uint) private _OwnedTokensCount;

    mapping(uint => address) private _tokenApprovals;

    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address _owner) public override view returns (uint){
        require(_owner != address(0), 'Owner query for non-existant token');
        return _OwnedTokensCount[_owner];
    }
    
    // @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint _tokenId) public override view returns (address){
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), 'Owner query for non-existant token');
        return owner;
    }

    function _exists(uint tokenId) internal view returns(bool){
        address owner = _tokenOwner[tokenId];
        return owner !=address(0);
    }

    function _mint(address to, uint tokenId) internal virtual {
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

    
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
        require(_to != address(0), 'Error - ERC721 Transfer to the zero address');
        require(ownerOf(_tokenId) == _from, 'Trying to transfer a token the address does not own!');

        // _OwnedTokensCount[_from].decrement();
        // _OwnedTokensCount[_to].increment();

        _tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) override public{
        // require(isApprovedOrOwner(msg.sender, _tokenId));
        _transferFrom(_from, _to, _tokenId);
    }
    
    /*
    function Approve(address _to, uint tokenId) public {
        address owner = ownerOf(tokenId);
        require(_to != owner, 'Error - Approval to current owner');
        require(msg.sender == owner, 'Current caller is not the owner of the token');
        _tokenApprovals[tokenId] = _to;

        emit Approval(owner, _to, tokenId);
    }

    function isApprovedOrOwner(address spender, uint256 tokenId) internal view returns(bool) {
        require(_exists(tokenId), 'token does not exist');
        address owner = ownerOf(tokenId);
        return(spender == owner);
    }
    */

}