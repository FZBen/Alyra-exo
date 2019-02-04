//Write your own contracts here. Currently compiles using solc v0.4.15+commit.bbb8e64f.
pragma solidity ^0.4.25;
contract Assemblee {
  address Administrateur; 
  address[] participants; 
  string[] ListePropositions; 
  uint[] VotesPour; 
  uint[] VotesContre;
  string nomAssemble; 
  uint dateLimite; 
  mapping (address => bool) aVote; 
  mapping(string => VoteCompte) propositions;

  constructor(string memory nom) public {
    nomAssemble = nom; 
  }

  struct VoteCompte 
  {
    address [] VotresPour;
    address [] VotesContre; 
    bool initialiser;
    bool fermer; 
  }
  function rejoindre() public {
    participants.push(msg.sender);
  }
  function supprimer(address participantASupprimer) public {
    for (uint i=0; i<participants.length; i++)
    if (participants[i]==participantASupprimer) {
      delete 
    }
  }

  function estParticipant(address par) public constant returns (bool) {
    for (uint i=0; i<participants.length; i++) {
      if (participants[i]==par) {
        return true;
      }
    }
    return false;
  }
  function proposerUnvote(string proposition) public {
    require(estParticipant(msg.sender), "Il faut etre participant");
    ListePropositions.push(proposition);
    VotesPour.push(0);
    VotesContre.push(0); 
  }
  function Voter(uint i, bool pour_ou_contre) public returns(uint) {
    if (pour_ou_contre) {
       VotesPour[i]+= 1;
       return VotesPour[i];
    } else {
       VotesContre[i]+= 1;
        return VotesContre[i]; 
    }
  }
  function conterVotesPour(uint i) public view returns(uint) {
    return VotesPour[i];
  }
  function conterVotesContre(uint i) public view returns(uint) {
    return VotesContre[i];
  }
  function resultatVotes(uint i) public view returns (int){
    int resultat = (int(VotesPour[i]) - int(VotesContre[i]));
    return resultat;
  }
  require(votes[v].aVote[msg.sender]==false);
  vote[v].aVote[msg.sender]=true; 

  function supprimerReferundum

  modifier seulementAdmin {
    require(administrateur== msg.sender);
    _;
  }
  function supprimerReferindum
} 