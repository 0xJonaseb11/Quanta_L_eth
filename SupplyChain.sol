// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SupplyChain {

    // state variables
    uint256 public chainId;
    uint256 public partners;
    string public  partnerID;


    // struct for partner info
    struct Partner {
        uint256 partnerId;
        string name;
        string permission;
        uint256 p_capacity;
        string transport;
        string income;
        string role;
        string description;

        SupplyChain _partnerId;
        
    }


    // add partners
    function addPartners(uint256 _partnerID) public view returns (string memory) {
        
        

        return Partner[_partnerID];

    }

}