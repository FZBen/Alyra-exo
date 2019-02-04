pragma solidity ^0.4.25;

import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol"; 

contract JetonMinimal {
  using SafeMath for uint256;
  event Transfert(uint256 montant, address payeur, address destinataire); 

  uint256 nombreInitial;
  address public destinataire; 
  address public emetteur; 
  uint256 dateEmission = 0; 

  mapping (address => uint256) public comptes; 
  constructor(uint256 nombreInitial) {//Write your own contracts here. Currently compiles using solc v0.4.15+commit.bbb8e64f.

    comptes[msg.sender] = nombreInitial; 
    emetteur=msg.sender; 
  }
  function transfert(address destinataire, uint256 valeur) {
    require(comptes[msg.sender] >= valeur, "votre compte est insuffisant"); 
    comptes[msg.sender] -= valeur; // ou en prenant en compte la fonction safeMAth: comptes[msg.sender] = comptes[msg.sender].sub(valeur); 
    comptes[destinataire] += valeur; // ou ...:  comptes[destinataire] = comptes[destinataire].add(valeur); 
    emit Transfert(valeur, msg.sender, destinataire); 
  }
  function emettre(uint256 date, address receveur, uint256 montant) {
    require(emetteur == msg.sender, "Vous ne pouvez pas créer des jeton"); 
    require (dateEmission + 1 weeks<= now); 
    require (montant < 10000000, "Vous ne pouvez pas emettre plus de 10000000!"); 
    comptes[receveur] += montant; 
    dateEmission = now; 
  }

  
}