# CommunityTokens
Token Tips for Goodwill

The above code is a smart contract written in Solidity, a programming language used for developing decentralized applications (dApps) on the Ethereum blockchain. It defines a contract named CommunityToken which inherits from three other contracts, ERC20, ERC20Burnable, and AccessControl, which are imported from the OpenZeppelin library.

The CommunityToken contract defines a new ERC20 token with the symbol CMT. The contract also defines two roles, DEFAULT_ADMIN_ROLE and MINTER_ROLE, which can be granted to specific addresses that have certain privileges, such as the ability to mint new tokens.

                               bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");//
This code declares a bytes32 constant variable named MINTER_ROLE and assigns it the value of the keccak256 hash of the string "MINTER_ROLE". This value can then be used throughout the contract to verify that a specific address has been granted the Minter Role.

Using keccak256 for the Minter Role provides several benefits, including:

* Security: The keccak256 function is a widely-used and well-vetted hashing algorithm that is considered to be secure and resistant to cryptographic attacks.
* Unique identifiers: Because the keccak256 function generates a unique hash value for each input, it ensures that each Minter Role has a unique identifier that can be used to verify its authenticity.
* Efficiency: The keccak256 function is a fast and efficient hashing algorithm that can be used in smart contracts without significantly impacting gas costs or contract performance.


The mint function is used to mint new tokens and can only be called by an address that has been granted the MINTER_ROLE role. The transfer function overrides the transfer function inherited from the ERC20 contract to enable the transfer of tokens between addresses.

The Tip function is used to transfer tokens from one address to another, with an additional allowance check to ensure the transaction is allowed. The function also emits a Tipsent event.

The RegisterBusiness function allows a business to register itself by providing a name and an address. Once registered, the business can use the TransactTokens function to burn tokens and transfer value to itself.

The TransactTokens function is used to burn a specified amount of tokens from the business address that called it and transfer an equal amount of ETH to that same address. The function also checks whether the business has been registered and whether the tokens are ready to be used (i.e., whether numPay is equal to or greater than three).

Overall, the CommunityToken contract is a basic ERC20 token with additional functionality to allow businesses to register themselves and use tokens to transact on the platform.
