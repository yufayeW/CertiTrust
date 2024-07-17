# CertiTrust.sol

CertiTrust.sol is a Solidity smart contract that implements an academic certificate issuance system. It is compatible with OpenZeppelin Contracts ^5.0.0.

## Contract Overview

The `AcademicCertificate` contract inherits from `ERC721URIStorage` and `AccessControl` contracts. It allows the creation, management, and verification of academic certificates on the Ethereum blockchain.

### Roles

The contract defines two roles:

- `DEFAULT_ADMIN_ROLE`: The default admin role, granted to the contract deployer.
- `REGISTRAR_ROLE`: The role for issuers of academic certificates.

### Storage

The contract uses the following mappings to store certificate data:

- `_certificateData`: Maps certificate IDs to their corresponding certificate data.
- `_signatures`: Maps certificate IDs to their corresponding signatures.
- `_issuers`: Maps issuer addresses to their permission status.

### Functions

The contract provides the following functions:

- `addIssuer`: Adds a new issuer by granting them the `REGISTRAR_ROLE`.
- `deleteIssuer`: Deletes an issuer by revoking their `REGISTRAR_ROLE`.
- `issueCertificate`: Mints a new academic certificate and assigns it to the specified address.
- `getCertificateData`: Retrieves the certificate data for a given token ID.
- `verifyCertificate`: Verifies the authenticity of a certificate by checking the signature against the registrar's role.

## Usage

1. Deploy the `AcademicCertificate` contract on the Ethereum network.
2. Grant the contract deployer the `DEFAULT_ADMIN_ROLE` and `REGISTRAR_ROLE`.
3. Add issuers using the `addIssuer` function, specifying their Ethereum addresses.
4. Issue certificates using the `issueCertificate` function, providing the recipient's address, token URI, certificate data, and signature.
5. Retrieve certificate data using the `getCertificateData` function, passing the token ID.
6. Verify certificates using the `verifyCertificate` function, providing the token ID, hash, v, r, and s values.

## Dependencies

The contract relies on the following dependencies from the OpenZeppelin library:

- `ERC721URIStorage`: Provides the implementation for ERC721 token with URI storage.
- `AccessControl`: Implements access control roles for the contract.
- `Counters`: Provides a counter data structure for generating unique certificate IDs.

## License

This contract is licensed under the MIT License. You can find the SPDX-License-Identifier at the top of the contract file.
