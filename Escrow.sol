// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;

contract Escrow {
    address payable public seller;
    address payable public buyer;
    
    constructor() {
        seller = payable(msg.sender);
    }

    modifier onlyOwner {
        require(
            msg.sender == seller,
            "You are not authorized."
        );
        _;
    }

    function getBalance() onlyOwner public view returns (uint256) {
        return address(this).balance;
    }

    // fund the escrow to secure fund
    function fund(address _buyer) payable public {
        buyer = payable(_buyer);
    }

    // release fund to the buyer after payement confirmed
    function release() onlyOwner payable public {
        buyer.transfer(address(this).balance);
    }

    // retrieve funds for unsuccessful payment
    function withdraw() onlyOwner payable public {
        seller.transfer(address(this).balance);
    }
}
