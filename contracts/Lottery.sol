// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract Lottery {address public manager;
     address payable[] public players;
       address payable winner;
     constructor(){
         manager=msg.sender;
     }
     receive() external payable{
         require(msg.value==1 ether,"plz pay only 1");
         players.push(payable(msg.sender));
     }
     function getBalance() public view returns(uint){
     require(msg.sender==manager);
         return address(this).balance;
     }
     function random() public view returns(uint){
      return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));
     }
     function pickWinner() public{
     require(msg.sender==manager);
     require(players.length>=3);
     uint r =random();
     uint index= r%players.length;
     winner=players[index];
     winner.transfer(getBalance());
     players=new address payable[](0);
 }
   function allPlayers() public view returns(address payable[] memory){
       return players;
   }}
