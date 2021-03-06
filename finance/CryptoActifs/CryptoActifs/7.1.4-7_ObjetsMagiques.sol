pragma solidity ^0.5.3;
pragma experimental ABIEncoderV2;

import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Ownable.sol";

/// @title ERC-721 Non-Fungible Token Standard
/// @dev See https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md
///  Note: the ERC-165 identifier for this interface is 0x80ac58cd
interface ERC721 /* is ERC165 */ {
	/// @dev This emits when ownership of any NFT changes by any mechanism.
	///  This event emits when NFTs are created (`from` == 0) and destroyed
	///  (`to` == 0). Exception: during contract creation, any number of NFTs
	///  may be created and assigned without emitting Transfer. At the time of
	///  any transfer, the approved address for that NFT (if any) is reset to none.
	event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

	/// @dev This emits when the approved address for an NFT is changed or
	///  reaffirmed. The zero address indicates there is no approved address.
	///  When a Transfer event emits, this also indicates that the approved
	///  address for that NFT (if any) is reset to none.
	event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

	/// @dev This emits when an operator is enabled or disabled for an owner.
	///  The operator can manage all NFTs of the owner.
	event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

	/// @notice Count all NFTs assigned to an owner
	/// @dev NFTs assigned to the zero address are considered invalid, and this
	///  function throws for queries about the zero address.
	/// @param _owner An address for whom to query the balance
	/// @return The number of NFTs owned by `_owner`, possibly zero
	function balanceOf(address _owner) external view returns (uint256);

	/// @notice Find the owner of an NFT
	/// @dev NFTs assigned to zero address are considered invalid, and queries
	///  about them do throw.
	/// @param _tokenId The identifier for an NFT
	/// @return The address of the owner of the NFT
	function ownerOf(uint256 _tokenId) external view returns (address); 

	/// @notice Transfers the ownership of an NFT from one address to another address
	/// @dev Throws unless `msg.sender` is the current owner, an authorized
	///  operator, or the approved address for this NFT. Throws if `_from` is
	///  not the current owner. Throws if `_to` is the zero address. Throws if
	///  `_tokenId` is not a valid NFT. When transfer is complete, this function
	///  checks if `_to` is a smart contract (code size > 0). If so, it calls
	///  `onERC721Received` on `_to` and throws if the return value is not
	///  `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`.
	/// @param _from The current owner of the NFT
	/// @param _to The new owner
	/// @param _tokenId The NFT to transfer
	/// @param data Additional data with no specified format, sent in call to `_to`
	function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata data) external payable;

	/// @notice Transfers the ownership of an NFT from one address to another address
	/// @dev This works identically to the other function with an extra data parameter,
	///  except this function just sets data to ""
	/// @param _from The current owner of the NFT
	/// @param _to The new owner
	/// @param _tokenId The NFT to transfer
	function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;

	/// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
	///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
	///  THEY MAY BE PERMANENTLY LOST
	/// @dev Throws unless `msg.sender` is the current owner, an authorized
	///  operator, or the approved address for this NFT. Throws if `_from` is
	///  not the current owner. Throws if `_to` is the zero address. Throws if
	///  `_tokenId` is not a valid NFT.
	/// @param _from The current owner of the NFT
	/// @param _to The new owner
	/// @param _tokenId The NFT to transfer
	function transferFrom(address _from, address _to, uint256 _tokenId) external payable;

	/// @notice Set or reaffirm the approved address for an NFT
	/// @dev The zero address indicates there is no approved address.
	/// @dev Throws unless `msg.sender` is the current NFT owner, or an authorized
	///  operator of the current owner.
	/// @param _approved The new approved NFT controller
	/// @param _tokenId The NFT to approve
	function approve(address _approved, uint256 _tokenId) external payable;

	/// @notice Enable or disable approval for a third party ("operator") to manage
	///  all of `msg.sender`'s assets.
	/// @dev Emits the ApprovalForAll event. The contract MUST allow
	///  multiple operators per owner.
	/// @param _operator Address to add to the set of authorized operators.
	/// @param _approved True if the operator is approved, false to revoke approval
	function setApprovalForAll(address _operator, bool _approved) external;

	/// @notice Get the approved address for a single NFT
	/// @dev Throws if `_tokenId` is not a valid NFT
	/// @param _tokenId The NFT to find the approved address for
	/// @return The approved address for this NFT, or the zero address if there is none
	function getApproved(uint256 _tokenId) external view returns (address);

	/// @notice Query if an address is an authorized operator for another address
	/// @param _owner The address that owns the NFTs
	/// @param _operator The address that acts on behalf of the owner
	/// @return True if `_operator` is an approved operator for `_owner`, false otherwise
	function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}

interface ERC721TokenReceiver {
	/// @notice Handle the receipt of an NFT
	/// @dev The ERC721 smart contract calls this function on the
	/// recipient after a `transfer`. This function MAY throw to revert and reject the transfer. Return
	/// of other than the magic value MUST result in the transaction being reverted.
	/// @notice The contract address is always the message sender.
	/// @param _operator The address which called `safeTransferFrom` function
	/// @param _from The address which previously owned the token
	/// @param _tokenId The NFT identifier which is being transferred
	/// @param _data Additional data with no specified format
	/// @return `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
	/// unless throwing
	function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes calldata _data) external returns(bytes4);
}

contract objetsMagiques is Ownable //, ERC721
{
    using SafeMath for uint256;
    
    mapping (uint256 => address) private _tokenOwner;
    mapping (uint256 => address) private _tokenApprovals;
    mapping (address => uint256) private _ownedTokensCount;
    mapping (uint256 => magicToken) public _tokenShape;
    mapping (uint256 => string) private _mapRarete;
    mapping (uint256 => string) private _mapObjet;
    mapping (uint256 => string) private _mapModel;
    mapping(address => uint256[]) private _ownedTokens;
    // Mapping from token ID to index of the owner tokens list
    mapping(uint256 => uint256) private _ownedTokensIndex;
    // Array with all token ids, used for enumeration
    uint256[] private _allTokens;
    // Mapping from token id to position in the allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;
    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;
    
    string private _name;
    string private _symbol;
    struct magicToken {
    string rarete;
    string objet;
    string model;
    uint numero;
 }

constructor(string memory name, string memory symbol) public {
 _name = name;
 _symbol = symbol;
 _mapRarete[1]="courant";
 _mapRarete[2]="rare";
 _mapRarete[3]="divin";
 _mapObjet[0]="epee";
 _mapObjet[1]="sabrelazer";
 _mapObjet[2]="pistolet";
 _mapModel[0]="petit";
 _mapModel[1]="gros";
 _mapModel[2]="baleze";
 }

event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);

function createToken(uint256 _rarete, uint256 _objet, uint256 _model) public returns (uint){
 uint IDToken = _model+(10*_objet)+(100*_rarete);
 require(_exists(IDToken) == false);
  _tokenShape[IDToken].rarete=_mapRarete[_rarete];
  _tokenShape[IDToken].objet=_mapObjet[_objet];
  _tokenShape[IDToken].model=_mapModel[_model];
  _addTokenTo(msg.sender,IDToken);
  return IDToken;
}

function creuser() public payable returns (uint256) {
require(msg.value==0.1 ether);
return createToken(uint(blockhash(block.number-1)) % 3 + 1, uint(blockhash(block.number-2)) % 3, uint(blockhash(block.number-3)) % 3);
}

function utiliser(uint256 tokenId) public {
require(_exists(tokenId) == true);
require(ownerOf(tokenId) == msg.sender);
uint action = uint(blockhash(block.number-1)) % 11;
if (action == 0)
{
  _removeTokenFrom(msg.sender,tokenId);
  }
}

 function balanceOf(address owner) public view returns (uint256) {
   require(owner != address(0));
   return _ownedTokensCount[owner];
 }

 function ownerOf(uint256 tokenId) public view returns (address) {
   address owner = _tokenOwner[tokenId];
   require(owner != address(0));
   return owner;
 }

 function _exists(uint256 tokenId) internal view returns (bool) {
   address owner = _tokenOwner[tokenId];
   return owner != address(0);
 }
 //function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
 function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
   require(_from==ownerOf(_tokenId));
   require(_to != address(0));
   _clearApproval(_from, _tokenId);
   _removeTokenFrom(_from, _tokenId);
   _addTokenTo(_to, _tokenId);
   emit Transfer(_from, _to, _tokenId);
 }

 function _clearApproval(address owner, uint256 tokenId) internal {
   require(ownerOf(tokenId) == owner);
   if (_tokenApprovals[tokenId] != address(0)) {
     _tokenApprovals[tokenId] = address(0);
   }
 }

 function _removeTokenFrom(address from, uint256 tokenId) internal {
   require(ownerOf(tokenId) == from);
   _ownedTokensCount[from] = _ownedTokensCount[from] - 1;
   _tokenOwner[tokenId] = address(0);
 }

 function _addTokenTo(address to, uint256 tokenId) internal {
   require(_tokenOwner[tokenId] == address(0));
   _tokenOwner[tokenId] = to;
   _ownedTokensCount[to] = _ownedTokensCount[to] + 1;
 }

 /**
  * @dev Internal function to mint a new token
  * Reverts if the given token ID already exists
  * @param to The address that will own the minted token
  * @param tokenId uint256 ID of the token to be minted by the msg.sender
  */
 function _mint(address to, uint256 tokenId) internal {
   require(to != address(0));
   _addTokenTo(to, tokenId);
   emit Transfer(address(0), to, tokenId);
 }

 /**
  * @dev Internal function to burn a specific token
  * Reverts if the token does not exist
  * @param tokenId uint256 ID of the token being burned by the msg.sender
  */
 function _burn(address owner, uint256 tokenId) internal {
   _clearApproval(owner, tokenId);
   _removeTokenFrom(owner, tokenId);
   emit Transfer(owner, address(0), tokenId);
 }

 function tokenOfOwnerByIndex(address owner,uint256 index) public view returns (uint256){
   require(index < balanceOf(owner));
   return _ownedTokens[owner][index];
 }

 /**
  * @dev Gets the total amount of tokens stored by the contract
  * @return uint256 representing the total amount of tokens
  */
 function totalSupply() public view returns (uint256) {
   return _allTokens.length;
 }

 /**
  * @dev Gets the token ID at a given index of all the tokens in this contract
  * Reverts if the index is greater or equal to the total number of tokens
  * @param index uint256 representing the index to be accessed of the tokens list
  * @return uint256 token ID at the given index of the tokens list
  */
 function tokenByIndex(uint256 index) public view returns (uint256) {
   require(index < totalSupply());
   return _allTokens[index];
 }

 /**
  * @dev Gets the token name
  * @return string representing the token name
  */
 function name() external view returns (string memory) {
   return _name;
 }

 /**
  * @dev Gets the token symbol
  * @return string representing the token symbol
  */
 function symbol() external view returns (string memory) {
   return _symbol;
 }

 /**
  * @dev Returns an URI for a given token ID
  * Throws if the token ID does not exist. May return an empty string.
  * @param tokenId uint256 ID of the token to query
  */
 function tokenURI(uint256 tokenId) public view returns (string memory) {
   require(_exists(tokenId));
   return _tokenURIs[tokenId];
 }

 /**
  * @dev Internal function to set the token URI for a given token
  * Reverts if the token ID does not exist
  * @param tokenId uint256 ID of the token to set its URI
  * @param uri string URI to assign
  */
 function _setTokenURI(uint256 tokenId, string memory uri) internal {
   require(_exists(tokenId));
   _tokenURIs[tokenId] = uri;
 }

}
