let dapp = {}; 
const monAddress = "0x5a14036D4796b698dC33001356CF4FA14dA7d9cE"; 
const nameAddress = "0x451875bdd0e524882550ec1ce52bcc4d0ff90eae"; 
const abi = [
  {
    "constant": false,
    "inputs": [
      {
        "name": "dev",
        "type": "bytes32"
      }
    ],
    "name": "remettre",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "",
        "type": "address"
      }
    ],
    "name": "cred",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "dd",
        "type": "string"
      }
    ],
    "name": "produireHash",
    "outputs": [
      {
        "name": "",
        "type": "bytes32"
      }
    ],
    "payable": false,
    "stateMutability": "pure",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "destinataire",
        "type": "address"
      },
      {
        "name": "valeur",
        "type": "uint256"
      }
    ],
    "name": "transfer",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  }
]; 
async function createMetaMaskDapp() {
	try {
	const addresses = await ethereum.enable(); 
	const address = addresses[0]; 

	const provider = new ethers.providers.Web3Provider(ethereum);
	const signer = provider.getSigner(); 
	dapp = { address, provider, signer }; 
	//console.log(dapp); 

	let contratCredibilite = new ethers.Contract( nameAddress, abi, dapp.provider);
	//console.log(dapp.address)
	// "nomAddress" = address dapp cours; abi = abi dapp cours
	let maCredibilite = await contratCredibilite.cred(dapp.address);
	// "monAddress" = mon adresse MetaMask qui a servi à l'envoi du devoir. 

	console.log("Crédibilité: "+maCredibilite.toString());

	const blockNumber = await provider.getBlockNumber(); 
	console.log("Numéro du bloc: "+blockNumber);
	document.getElementById('blockNumber').innerHTML = blockNumber;

	const balance  = await provider.getBalance(dapp.address); 
	console.log("Balance: "+(balance).toString());
	document.getElementById('balance').innerHTML = balance.toString();

	const gasPrice = await provider.getGasPrice(); 
	console.log("Gas Price: "+(gasPrice).toString()); 
	document.getElementById('gasPrice').innerHTML = gasPrice.toString(); 

	} catch(err) {
		console.error(err); 
	}
	/*methode longue pour la fonction getBalance : async function balance() {
		dapp.provider.getbalance(dapp.address).then((balance) => {
			let etherString = ethers.utils.formatEther(balance); 
			console.log("Balance: " + etherString); 
		}); 
	}*/
}
