pragma solidity ^0.5.3;

import "github.com/FZBen/Alyra-exo/blob/master/finance/CryptoActifs/FinanceDecentralisee/7.2.1_Bazar.sol"; 

contract bazar2 is bazar {

	mapping (address => uint256) public remboursement; 

	function offre(uint _objet) public payable {
		require(objectContract.exists(_objet));
		require(block.number<=encheres[_objet].finEnchere);
		require(msg.value>encheres[_objet].meilleureOffre);
		rembourssement[encheres[_objet].meilleurAcheteur]=encheres[_objet].meilleureOffre;
		encheres[_objet].meilleureOffre=msg.value;
		encheres[_objet].meilleurAcheteur=msg.sender;
	}

	function remboursement() public {
		require(remboursement[msg.sender]>0);
		address(msg.sender).transfer(remboursement[msg.sender]);
		remboursement[msg.sender]=0;
	}

	function récupererObjet(uint _objet) public {
		require(objectContract.exists(_objet));
		require(block.number > encheres[_objet].finEnchere);
		
		address _to = (encheres[_objet].meilleurAcheteur ==address(0))?encheres[_objet].vendeur:encheres[_objet].meilleurAcheteur;
		objectContract.transferFrom(address(this),_to,_objet);
	}
}
