// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract AIGeneratedArtNFT is ERC721 {
    uint256 public tokenIdCounter;
    mapping(uint256 => string) private _tokenMetadata;

    // Constructor is not used as requested.
    constructor() ERC721("AI Generated Art", "AIART") {}

    // Mint a new NFT
    function mint(address to) external {
        uint256 tokenId = tokenIdCounter;
        _safeMint(to, tokenId);
        tokenIdCounter++;
        
        // Assign metadata dynamically for the minted token
        _setTokenMetadata(tokenId, generateMetadata(tokenId));
    }

    // Internal function to set token metadata
    function _setTokenMetadata(uint256 tokenId, string memory metadata) internal {
        _tokenMetadata[tokenId] = metadata;
    }

    // Generate dynamic metadata for each token
    function generateMetadata(uint256 tokenId) internal pure returns (string memory) {
        return string(abi.encodePacked("AI Generated Art #", uint2str(tokenId)));
    }

    // Override the tokenURI function to return the dynamic metadata URL or content
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory metadata = _tokenMetadata[tokenId];
        return string(abi.encodePacked("https://example.com/api/metadata/", metadata));
    }

    // Utility function to convert uint256 to string
    function uint2str(uint256 _i) internal pure returns (string memory str) {
        if (_i == 0) {
            return "0";
        }
        uint256 temp = _i;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory bstr = new bytes(digits);
        uint256 index = digits - 1;
        while (_i != 0) {
            bstr[index--] = bytes1(uint8(48 + _i % 10));
            _i /= 10;
        }
        str = string(bstr);
    }
}
