pragma solidity ^0.5.3;


import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract epinglage is Ownable{    
    using SafeMath for uint256;
    bytes32[] public pin; 
    
    mapping (bytes32 => address) addressPin;

    event Epingler(bytes32 pin);
    
    function payerStockage(bytes32 pinUrl) public payable {
        require(msg.value  >= 100 finney,"Minimum de 0.1 ether est requis");
        pin.push(pinUrl);
        addressPin [pinUrl] = msg.sender;

        emit Epingler(pinUrl);
    }
    
}