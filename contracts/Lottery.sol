pragma solidity ^0.8.9;

contract Lottery {
    address public manager;
    address[] public players;

    function Lottery() public {
       manager = msg.sender;
    }
}
