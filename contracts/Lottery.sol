pragma solidity ^0.4.17;

contract Lottery{
    address public manager;
    address[] public players;
    function Lottery() public {
        manager = msg.sender; //someone who starts the lottery
    }
    function enter() public payable {
        require(msg.value > .01 ether); //minimum amount to enter lottery
        players.push(msg.sender); //adding a new player to the lottery
    }
    function random() private view returns (uint){
        //adding randomness for selection of a winner
        //cryptographic hash algorithm
        return uint(keccak256(block.difficulty, now, players));
    }
    function pickWinner() public {
        uint index = random() % players.length;
        players[index].transfer(this.balance);
    }
}
