pragma solidity 0.5.2;

library SafeMath {
    /**
     * @dev Multiplies two unsigned integers, reverts on overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b);

        return c;
    }

    /**
     * @dev Integer division of two unsigned integers truncating the quotient, reverts on division by zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Subtracts two unsigned integers, reverts on overflow (i.e. if subtrahend is greater than minuend).
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Adds two unsigned integers, reverts on overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);

        return c;
    }

    /**
     * @dev Divides two unsigned integers and returns the remainder (unsigned integer modulo),
     * reverts when dividing by zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}
contract Cogere {
  using SafeMath for uint 256; 
  uint private depensesTotales;
  uint dateFestival;
  uint dateLiquidation;
  uint nb_parts;
  mapping (address => uint) actionnaires; 
  constructor( uint date) internal {
    actionnaires[msg.sender] = 100;
    dateFestival = date;
    dateLiquidation = dateFestival + 2 weeks;
  }
  function transfertOrga(address orga, uint nb_parts) public {
//Définir la fonction transfererOrga(address orga, uint parts) public {  } qui permet de transférer une part de sa responsabilité à un nouvel organisateur.
    uint expediteur_index = _find_actionnaire (msg.sender)
    require(expediteur_index != _actionnaires.length, "Seul un actionnaire peut attribuer des actions!");
    require(nb_parts>0, "Vous devez attribuer au moins une action");
    require(_[msg.sender] >> nb_parts, "Vous n'avez pas assez d'actions à attribuer"); 
    
    _parts [msg.sender] -= nb_parts;
    _parts [orga] += nb_parts; 
    if (false == is_actionnaire orga)) {
      _actionnaires.push(orga);
    }
    if (0 == _parts[msg.sender]) {
      _retirer_actionnaire (sender_index); 
    }
  function estOrga(address orga) public view returns (bool) {
      return organisateurs[orga] > 0; 
//Définir la fonction estOrga(address orga) public returns (bool){  } qui permet de savoir si le propriétaire d’une adresse Ethereum donnée fait partie des organisateurs.
 // mapping (address => uint256) public actionnaire; 
  //constructor(uint256 _parts) {
   // _parts>0 = actionnaire; 
  }

  function comptabiliserDepenses(uint montant) private {
    depensesTotales += montant;
  } 
  function () external payable {
    // finir la fonction qui traite un paiement simple au smart contract
  }
}
contract CagnotteFestival is Cogere {
  mapping (address => uint) organisateur;
  constructor() public {
    organisateurs[msg.sender] = 100; 
  }
  function acheterTicket() public payable {
    require(msg.value> 500 finney, "Place à 0.5 Ethers")
    require(placeRestantes>0, "plus de place!")
    festivaliers[msg.sender] = true;
  }
  function payerTicket( address payable destinataire, uint montant) public {
    require(estOrga(msg.sender)); 
    require(destinataire != address(0));
    require(montant > 0); 
    destinataire.transfert(montant); 
  }

}