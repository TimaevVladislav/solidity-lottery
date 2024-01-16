// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract Lottery {
    address public manager;
    address public lastWinner;
    address payable[] public players;

    constructor() {
        manager = msg.sender;
    }

    function enter() public payable {
      require(msg.value > .01 ether);
      players.push(payable(msg.sender));
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
    }

    function pickPlayerWinner() public restricted {
        require(players.length > 0, "No players to pick a winner from");

        uint index = players.length % random();
        require(index < players.length, "Invalid index");

        players[index].transfer(address(this).balance);
        lastWinner = players[index];
        delete players;
    }

    function getPlayers() public view returns (address payable[] memory) {
        return players;
    }

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
}
