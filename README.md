# ETH+AVAX Intermediate Course Solution

## Demonstrating `require()`, `assert()`, and `revert()` functions of Solidity
[Video Demonstration here](https://www.loom.com/share/edbb07af1fb344b89a40e7ebed9fd668?sid=29f5b3ef-3fe6-4960-b7d8-b75893c5767f)

This Solidity program defines a crowdfunding contract that demonstrates the use of `require()`, `assert()`, and `revert()` functions. The contract allows users to contribute to a crowdfunding project and enables the project creator to end the event and withdraw the funds.

## Description

The `CrowdFunding` contract includes the following functionalities:

1. Public variables to store the project details (creator, project name, funding limit, amount raised, funding limit reached, and event ended).
2. A mapping to keep track of each address's contribution.
3. A `contributeToFund` function to allow users to contribute to the crowdfunding project, with checks to ensure the event has not ended, the funding limit is not reached, and the minimum contribution amount is met.
4. An `endEvent` function to allow the creator to end the crowdfunding event.
5. A `withDrawFunds` function to allow the creator to withdraw the raised funds once the event has ended.

## Getting Started

### Executing Program

To run this program, you can use Remix, an online Solidity IDE. Follow these steps:

1. Go to the Remix website at [Remix](https://remix.ethereum.org/).
2. Create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a `.sol` extension (e.g., `CrowdFunding.sol`).
3. Copy and paste the following code into the file:

    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity 0.8.18;

    contract CrowdFunding{
        address public creator;
        string public projectName;
        uint public fundingLimit;
        uint public amountRaised;
        bool public fundingLimitReached;
        bool public eventEnded;
        mapping(address => uint) public contributionsToTheFund;

        modifier onlyCreator(){
            require(msg.sender == creator, "You are not the creator of this crowdfund");
            _;
        }
        constructor(string memory _projectName, uint _fundingLimit){
            creator = msg.sender; //setting the creator as the creator of this smart contract
            projectName = _projectName;
            fundingLimit = _fundingLimit;
        }

        function contributeToFund(uint _amount) public payable {
            require(!eventEnded, "The event has been ended");
            require(!fundingLimitReached, "The funding limit is reached");

            if(_amount < 10){
                revert("Minimum funding amount is 10 WEI");
            }

            contributionsToTheFund[msg.sender] += _amount;
            amountRaised += _amount;

            if(amountRaised >= fundingLimit){
                fundingLimitReached = true;
                eventEnded = true;
            }
        }

        function endEvent() public onlyCreator{
            require(!eventEnded, "The event has ended already");

            eventEnded = true;
        }

        function withDrawFunds() public onlyCreator {
            require(eventEnded, "The event is still going on");

            assert(amountRaised > 0);

            amountRaised = 0;
        }
    }
    ```

4. To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the "Compile CrowdFunding.sol" button.
5. Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the `CrowdFunding` contract from the dropdown menu, and then click on the "Deploy" button.
6. Once the contract is deployed, you can interact with it by calling the `contributeToFund`, `endEvent`, and `withDrawFunds` functions. Use the interface provided by Remix to input the necessary parameters and execute the functions.

## Help

If you encounter any issues, ensure the following:

1. The Solidity compiler version is set correctly.
2. The address used in function calls is valid.
3. The minimum contribution amount is met.

For additional help, use the Remix documentation or community forums.

## Authors

MetaCrafter Om Satapathy  
[@OmSatapathy04](https://twitter.com/OmSatapathy04)

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
