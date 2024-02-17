// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ImageNFT is ERC721URIStorage, ReentrancyGuard, Ownable {
    uint256 private _tokenIdCounter;

    constructor() ERC721("ImageNFT", "IMG") {}

    // NFT Mint
    function mintNFT(string memory tokenURI) public nonReentrant {
        uint256 tokenId = _tokenIdCounter;
        _tokenIdCounter += 1;
        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);
    }
}