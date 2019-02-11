pragma solidity ^0.5.3;

pragma experimental ABIEncoderV2;

import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract placeDeMarche {
	using SafeMath for uint256;
	address[] administrateurs; 
	address[] illustrateurs; 
	address[] entreprises; 
	address[] bannis; 
	modifier ownerOnly() {
        if (msg.sender != _admin) throw;
	    _;
	}
    
	constructor () public {_admin = msg.sender;}
	function () payable external { _admin.transfer(msg.value); }
	
	
	function aBannir(address utilisateur) public ownerOnly() {
    //if(msg.sender != _admin) throw; cette condition est remplacée par la fonction ownerOnly.  
        reputation[utilisateur] = 0;
        bannis.push(utilisateur);   
   }

   function estBanni(address utilisateur) public  view returns (bool){
       for(uint i=0;i<bannies.length;i++){
       if (bannis[i] == participant){return true;}
       }
       return false;
   }
   struct Utilisateur
	{
		address _address;
		string _name;
		uint _reputation;
	}
	
	Utilisateur[] public utilisateurs; 
	
   function inscription(address utilisateur, string memory nom) public {
       require( estBanni(msg.sender) == false," Address Bannie");
       utilisateurs[utilisateur] = nom;
       reputation[utilisateur] = 1;
   }
   modifier pasBanni() {
		require(false == estBanni(msg.sender), "You are blacklisted");
		_;
	}

	modifier listeIllustrateurs()
	{
		require(_illustrateurs[msg.sender]._reputation > 0, "Vous n'êtes pas illustrateur client.");
		_;
	}

	modifier listeEntreprises()	{
		require(entreprises[msg.sender]._reputation > 0, "Vous n'êtes pas entreprise cliente.");
		_;
	}

	function listeIllustrateurs(string memory name) public pasBanni	{
		_register(_illustrateur[msg.sender], name);
	}

	function listeEntreprises(string memory name) public pasBanni {
		_register(_entreprise[msg.sender], name);
	}
   
    mapping (address => utilisateur) public _illustrateurs;
	mapping (address => utilisateur) public _entreprises;
	address[] private _bannis;
    
    enum Etat {OUVERTE, ENCOURS, CLOTUREE}
    
    struct Demande {
        
        address _demandeur;
		string _titre;
		string _description;
		uint _remuneration;
		uint _reputationMin;
		bytes32 _demandeHash;
		address[] _candidats;
		//address _taker;
		uint _delaiAcceptation_seconds;
		uint _delaiAttente;
		uint _tempsDeReponse;
		bytes32 _reponseUrlHash;
		Etat etatDemande;
	}

	mapping (address => utilisateur) public illustrateurs;
	mapping (address => utilisateur) public entreprises;
	address[] private _bannis;

	Demande[] public _demandes;

	uint constant private MAX_UINT256 = ~uint256(0);
	uint constant private reputationNulle = 0;
	uint constant public remunerationMin = 100 wei;
	uint constant public delaiAcceptation_seconds = 604800; 
	
	event DemandeAjoutee(string _titre, address _demandeur, bytes32 _demandeHash);
	event OffreDeposee(string nom, address candidat, bytes32 _demandeHash);
	event OffreAcceptee(address hire, bytes32 _demandeHash);
	event OffreRejetee(bytes32 _demandeHash);
	event DemandeCloturee(string reponseUrlHash, bytes32 _demandeHash);

	function demande_index(bytes32 _demandeHash) internal view returns(uint index_or_not) {
	    
		for (uint i = 0; i < _demandes.length; ++i) {
			if (_demandes[i]._demandeHash == _demandeHash) {
				return i; }
		}

		return MAX_UINT256;
	}
	
	function ajouterDemande(
	string memory _titre, 
	string memory _description, 
	uint _reputationMin, 
	uint _delaiAcceptation_seconds) 
	payable entreprise {
	    
	    require (_reputation == reputationMin, 'Votre reputation doit être au minimum de 1 pour effectuer cette demande.'); 
		require(msg.sender == demandeur, 'Vous devez être inscrit sur la plateforme pour pouvoir effectuer cette action.'); 
		require (msg.value == remuneration.mul(1.02), 'Vous devez prevoir la somme de la rémunération et les fraix de gestion (2%).'); 
		require(msg.value >= remunerationMin, "La remunération minimale est de 100 wei.");
		
		uint frais = (msg.value.mul(2)).div(100);
		
		demande memory demande;
		demande._demandeur = msg.sender;
		demande._titre = titre;
		demande._description = description;
		demande._remuneration = msg.value - frais;
		reputationMin = 1;
		demande._demandeHash = keccak256(abi.encodePacked(demande._demandeur, demande._titre, demande._description, demande._remuneration, demande._reputationMin)); 
		demande._postulant = address(0);
		demande._delaisAttente = 0;
		demande._delaiAcceptation_seconds = delaiAcceptation_seconds;
		demande._tempsDeReponse = 0;
		demande._etatDemande = Etat.ENCOURS;

		_demandes.push(demande);
		_administrateur.transfer(frais);
		emit DemandeAjoutee(demande._titre, demande._demandeur, demande._demandeHash);
	}
	
	function supprimerDemmande(bytes32 demandeHash) public listeEntreprises {
	    
		uint index = _demande_index(demandeHash);
		require(index != MAX_UINT256, "demande introuvable.");
		demande memory demande = _demande[index];
		require(demande._etatDemande == Etat.OUVERTE, "Seule une demande à l'état OUVERTE peut-être supprimée.");
		require(demande._demandeur == msg.sender, "Vous n'êtes pas le propriétaire de cette demande.");
		_remove_demande_at_index(index);
		msg.sender.transfer(demande._remuneration);
		msg.sender.transfer(demande._frais); 
	}
	
	function demandeOuverte() public view returns (bool){
		return uint(Etat)==uint(Etat.OUVERTE);}
	function selectionEnCours() public view returns (bool){
		return uint(Etat)==uint(Etat.ENCOURS);}
	function demandeCloturee() public view returns (bool){
	    return uint(Etat)==uint(Etat.CLOTUREE);}
	    
	function trouverDemande(bytes32 demandeHash) internal view returns(demande storage) {
	    uint index = _demande_index(demandeHash);
		require(index != MAX_UINT256, "Demande introuvable.");
		return _demandes[index];
	}
    
    function postuler(bytes32 demandeHash) public listeIllustrateurs {
		utilisateur memory illustrateur = _illustrateur[msg.sender];
		demande storage demande = _trouverDemande(demandeHash);
		require(demande._etatDemande == Etat.OUVERTE, "Vous ne pouvez pas postuler à cette offre.");
		require(illustrateur._reputation >= demande._reputationMin, "Votre réputation est insuffisante pour cette offre.");
		demande._candidats.push(msg.sender);
		emit candidature(illustrateur._nom, msg.sender, demandeHash);
	}
	function estCandidat(bytes32 _demandeHash, uint index) public view returns(utilisateur memory candidat) {
	
		utilisateur memory candidat;
		candidat._address = trouverDemande(demandeHash)._candidats[index];
		utilisateur memory illustrateur = illustrateurs[candidat._address];
		candidat._nom = illustrateur._nom;
		candidat._reputation = illustrateur._reputation;
		return candidat;
	}
	
	function deposerUneOffre(bytes32 demandeHash, string memory reponseUrl) public listeIllustrateur {
		demande storage demande = trouverDemande(demandeHash);
		require(demande._etatDemande == Etat.ENCOURS, "Vous ne pouvez pas deposer votre offre.");
		require(demande._postulant == msg.sender, "Un autre candidat est en cours de selection pour cette demande.");
		demande._reponseUrlHash = keccak256(abi.encodePacked(reponseUrl));
		demande._tempsDeReponse = now;
		emit OffreDeposee(reponseUrlHash)
	
	function selectionnerUneOffre(bytes32 demandeHash, string memory reponseUrl) public listeIllustrateur {
	  	demande._etatDemande = Etat.CLOTUREE;
		delete demande._candidats;
		_postulant.transfer(demande._remuneration);
		utilisateur storage illustrateur = _illustrateurs[msg.sender];
		_postulant._reputation += 1; 
		emit OffreAcceptee(reponseUrlHash); 
	}
		
}