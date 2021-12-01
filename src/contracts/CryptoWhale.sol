// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Connector.sol';

contract CryptoWhale is ERC721Connector {

    // Array to store our NFTs
    string[] public cryptoWhales;

    mapping(string => bool) _cryptoWhalesExists;

    function mint(string memory _cryptoWhale) public {

        require(!_cryptoWhalesExists[_cryptoWhale]);

        // DEPRECATED: uint _id = CryptoWhales.push(_cryptoWhale);
        cryptoWhales.push(_cryptoWhale);
        uint _id = cryptoWhales.length - 1;

        _mint(msg.sender, _id);

        _cryptoWhalesExists[_cryptoWhale] = true;
    }

    constructor() ERC721Connector('CryptoWhale', 'CWHALE'){
        {}
    }
}