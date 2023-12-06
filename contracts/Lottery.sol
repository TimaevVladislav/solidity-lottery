pragma solidity ^0.8.9;

contract Lottery {
    address public manager;

    function Lottery() public {
       manager = msg.sender;
    }
}
