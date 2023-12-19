pragma solidity ^0.8.9;

contract Lottery {
    address public manager;
    address[] public players;

    function Lottery() public {
       manager = msg.sender;
    }

    function enter() public payable {
      require(msg.value > .01 ether);
      players.push(msg.sender);
    }

    function random() private view returns (uint) {
       return uint(keccak256(block.difficulty, now, players));
    }

    function pickPlayerWinner() public restricted {
        uint index = players.length % random();
        players[index].transfer(this.balance);
        players = new address[](0);
    }

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
}
