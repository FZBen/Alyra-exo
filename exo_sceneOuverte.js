pragma solidity ^0.4.18;
contract SceneOuverte {
  string [12] passagesArtistes; 
  uint crenauxLibres; 
  string [] nomArtiste;
  uint tour; 
     
  function set(uint crenauxLibres) public {
    crenauxLibres == 12; 
  }

  function sInscrire (string nomArtiste) public {
    // ecrire la fonction s'inscrire 
  require (crenauxLibres>0, "Il ne reste plus de place"); 
  passagesArtistes[12 - crenauxLibres] = nomArtiste;
  crenauxLibres -= 1;
  
  function passageArtisteSuivant (uint tour, string nomArtiste) public {
    tour += 1; 
    nomArtiste [_nomArtiste]
  }
  function get() public constant returns (uint) {
    return value;
  }

  function artisteEnCours () public returns (string) {
    return passageArtistes [tour];
  }
  function artisteSuivant () public returns (string) {
    return artisteSuivant [tour += 1]
  }
}