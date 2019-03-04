pragma solidity ^0.5.3;
pragma experimental ABIEncoderV2;
import "https://github.com/FZBen/Alyra-exo/blob/master/finance/CryptoActifs/FinanceDecentralisee/7.2.2_Bazar_MecanismesEnchere.sol";
import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract bazar3 is bazar2{
	using SafeMath for uint256;
	enum choixEnchere { CLASSIC, DUTCH}
	struct MultiEncheres{
	     uint256 objet;
	     choixEnchere typeEnchere;
	     uint256 value;
	     uint256 dutchamountPerBlock;
	}
	mapping (uint256 => MultiEncheres) public Encheres;
	
	function proposerALaVenteDutch(uint256 _objet,uint256 value, uint256 _dutchamountPerBlock) public {
    	require(value>0);
		super.proposerALaVente(_objet);
		Encheres[_objet]=MultiEncheres(_objet,choixEnchere.DUTCH,value,_dutchamountPerBlock);
    }
	function proposerALaVente(uint256 _objet) public{
		super.proposerALaVente(_objet);
		Encheres[_objet]=MultiEncheres(_objet,choixEnchere.CLASSIC,0,0);
	}
	function offre(uint256 _objet) public payable{
		require(Encheres[_objet].objet==_objet);
		if(Encheres[_objet].typeEnchere==choixEnchere.CLASSIC){
			super.offre(_objet);
		}else{
			uint256 nbBlocks	= SafeMath.sub(1000, SafeMath.sub(encheres[_objet].finEnchere,block.number));
			uint256 baissePrix 	= SafeMath.div(Encheres[_objet].value * nbBlocks * Encheres[_objet].dutchamountPerBlock ,1000); 
			uint256 minPrix	= SafeMath.sub(Encheres[_objet].value,baissePrix);
			require(msg.value>=minPrix);
			super.offre(_objet);
		}
	}
}