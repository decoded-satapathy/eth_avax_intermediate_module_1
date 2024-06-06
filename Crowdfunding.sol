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
