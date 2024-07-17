// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract AcademicCertificate is ERC721URIStorage, AccessControl {
    using Counters for Counters.Counter;
    Counters.Counter private _certificateIdCounter;

    // Define role for the registrar
    bytes32 public constant REGISTRAR_ROLE = keccak256("REGISTRAR_ROLE");
    // Mapping
    mapping(uint256 => string) private _certificateData;
    mapping(uint256 => bytes) private _signatures;
    mapping(address => bool) private _issuers;

    constructor() ERC721("AcademicCertificate", "ACERT") {
        // Grant the contract deployer the default admin role
        grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        // Grant the contract deployer the registrar role
        grantRole(REGISTRAR_ROLE, msg.sender);
    }

    // Function to add a new issuer
    function addIssuer(address issuer) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _issuers[issuer] = true;
        grantRole(REGISTRAR_ROLE, issuer);
    }

    // Function to delete an issuer
    function deleteIssuer(address issuer) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _issuers[issuer] = false;
        revokeRole(REGISTRAR_ROLE, issuer);
    }

    // Function to mint a new academic certificate
    function issueCertificate(
        address to,
        string memory tokenURI,
        string memory certificateData,
        bytes memory signature
    ) public {
        require(
            _issuers[msg.sender],
            "Only allowed issuers can issue certificates"
        );
        uint256 certificateId = _certificateIdCounter.current();
        _certificateIdCounter.increment();
        _safeMint(to, certificateId);
        _setTokenURI(certificateId, tokenURI);
        _certificateData[certificateId] = certificateData;
        _signatures[certificateId] = signature;
    }

    // Function to get the certificate data of a specific token
    function getCertificateData(
        uint256 tokenId
    ) public view returns (string memory) {
        // This will revert if the token does not exist
        ownerOf(tokenId);
        return _certificateData[tokenId];
    }

    // Function to verify a certificate
    function verifyCertificate(
        uint256 tokenId,
        bytes32 hash,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public view returns (bool) {
        // This will revert if the token does not exist
        ownerOf(tokenId);
        address signer = ecrecover(hash, v, r, s);
        return hasRole(REGISTRAR_ROLE, signer);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721URIStorage, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
