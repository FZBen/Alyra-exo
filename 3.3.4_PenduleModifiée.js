pragma solidity ^0.5.3;
contract Pulsation {

  uint public _battement; 
  string private _message; 

  constructor(string memory message) public {
    _message = "dong";
  }  

  function ajouterBattement() public returns (string memory message) {
      _battement++; 
      return _message;  
  }
  
  contract Pendule is Pulsation("Tic") {
    string [] public TacTic;
    Pulsation internal _tac; 
    Pulsation internal _tic;
    uint8 internal timeForTic; 
      

    function ajouterTac(Pulsation t)public{
      _tac = t;
    }

    function provoquerDesPulsations() public {
      if(timeForTic == 1) {
        TacTic[timeForTic] = ajouterBattement(); 
        timeForTic = 0;
      }
      else {
        TacTic[timeForTic] = _tac.ajouterBattement();
        timeForTic = 1
      }
    }
    constructor () public {
      tic = new Pulsation("Tic"); 
      tac = new Pulsation ("tac");
    }
    function mouvementsBalancier(uint k) public {
      while (k > 0){
        if (k % 2 == 0) {
          TacTic.push(_tic.ajouterBattement() );
        }
        else {
          TacTic.push(_tac.ajouterBattement() );
        }
        --k; 
      }
    }
  }
    
}