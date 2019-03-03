pragma solidity ^0.5.3;
pragma experimental ABIEncoderV2;

import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Ownable.sol";

interface ObjetsMagiquesInterface {
event Transfer(address indexed _from, address indexed _to, uint256 tokenID);

function balanceOf(address owner) public view returns (uint256 balance);
function ownerOf(uint256 tokenID) public view returns (address owner);
function exists(uint256 tokenID) public view returns (bool exists);

function transferFrom(address from, address to, uint256 tokenID) public;
function creuser() public;
function utiliser(uint256 tokenID) public returns (uint256 tirage);
}
contract bazar is objetsMagiques, Ownable
{
    using SafeMath for uint256;
    address private objetsMagiquesAddresse;
	ObjetsMagiques internal objetsMagiques;
	ObjetsMagiquesInterface public objectContract;

	mapping (uint256 => Enchere) public encheres;

     struct Enchere {
     address meilleurAcheteur;
     uint256 meilleureOffre;
     uint256 finEnchere
     uint256 objet;
     address vendeur;
 	}
	
	constructor(ObjetsMagiquesInterface _objectContract) public {
		objectContract = _objectContract;
    }

    function proposerALaVente(uint256 _objet) public {
    	require(objectContract.exists(_objet));
    	objectContract.transferFrom(msg.sender,address(this),_objet);
    	encheres[_objet]=Enchere(address(0),0,(block.number+1000),_objet,msg.sender);
    }
}

