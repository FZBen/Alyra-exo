pragma solidity ^0.5.3;

pragma experimental ABIEncoderV2;

import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract placeDeMarche {
	using SafeMath for uint256;
	address[] administrateur; 
	enum Etat {OUVERTE, ENCOURS, FERMEE}; 
	
	function estAdmin (address _admin) public view returns (bool){
       for(uint i=0; i<administateurs.length; i++){
       if (administateurs[i] == _admin){return true;}
       }
       return false;
       }

	// Définir une structure de données pour chaque demande qui comprend:
	

    struct Illustrateurs {
        mapping(address => string) illustrateurs;
        mapping(address => uint256) reputation;
        address[] bannies;
    }
    
    struct Entreprises {
        string raisonSociale; 
        uint256 reputation; 
    }

    struct Demande {
        address[] demandeur;
        uint256 private remuneration;
        uint256 private delai;
        string public taches;
        Etat etatDeDemande; 
        address[] candidats;
        uint256 reputationMin();
        uint256 montant = msg.value;
    }
    Demande[] demandes;
    mapping(address => Demande) entreprises;
    
    function ajouterDemande(address _demandeur, uint _reputationMin) payable public {
       Demande memory demande;
       require (msg.value = remuneration.mul(1.02), "Votre montant doit couvrir la rémunération plus les 2% de frais de gestion"); 
       require (address demandeur)
       
       //montant = montant.div(100);
       //montant = msg.value.sub(montant);
       //demande.demandeur = _demandeur;
       //demande.remuneration = montant;
       //demande.etatDemande = Etat.ENCOURS;
       //demande.reputationMin = _reputationMin;
       //demandes.push(demande);

    uint numCampaigns;
    mapping (uint => Campaign) campaigns;

    function newCampaign(address beneficiary, uint goal) public returns (uint campaignID) {
        campaignID = numCampaigns++; // campaignID is return variable
        // Creates new struct and saves in storage. We leave out the mapping type.
        campaigns[campaignID] = Campaign(beneficiary, goal, 0, 0);
	
}
