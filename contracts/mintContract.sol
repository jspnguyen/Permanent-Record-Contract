// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract mintContract is ERC721URIStorage {
    uint256 private _currentTokenId = 0;
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor(string memory name, string memory symbol, address initialOwner) ERC721(name, symbol) {
        if (initialOwner == address(0)) {
            revert("Ownable: new owner is the zero address");
        }
        _owner = initialOwner;
        emit OwnershipTransferred(address(0), initialOwner);
    }

    modifier onlyOwner() {
        require(_owner == msg.sender, "Error: caller is not the owner");
        _;
    }

    function mintNFT(address recipient, string memory metadataURI) public onlyOwner {
        uint256 newTokenId = _currentTokenId++;
        _mint(recipient, newTokenId);
        _setTokenURI(newTokenId, metadataURI);
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }

    function owner() public view returns (address) {
        return _owner;
    }

    function highestTokenId() public view returns (uint256) {
        return _currentTokenId > 0 ? _currentTokenId - 1 : 0;
    }
}