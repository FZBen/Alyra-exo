
const ethers = require('ethers');
const Ipfs= require('ipfs');
const provider = new ethers.providers.JsonRpcProvider("http://localhost:8545");
const node = new Ipfs();
const express = require('express');
const app = express();

// ABI/address contract
const address =  "0x5a14036D4796b698dC33001356CF4FA14dA7d9cE";
const abi = [
	{
		"constant": false,
		"inputs": [
			{
				"name": "pinUrl",
				"type": "bytes32"
			},
			{
				"name": "duree",
				"type": "uint256"
			}
		],
		"name": "payerStockage",
		"outputs": [],
		"payable": true,
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [],
		"name": "renounceOwnership",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "transferOwnership",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "pin",
				"type": "bytes32"
			},
			{
				"indexed": false,
				"name": "duree",
				"type": "uint256"
			}
		],
		"name": "Epingler",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"name": "previousOwner",
				"type": "address"
			},
			{
				"indexed": true,
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "OwnershipTransferred",
		"type": "event"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"name": "dureePin",
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
		"inputs": [],
		"name": "isOwner",
		"outputs": [
			{
				"name": "",
				"type": "bool"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "owner",
		"outputs": [
			{
				"name": "",
				"type": "address"
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
				"name": "",
				"type": "uint256"
			}
		],
		"name": "pin",
		"outputs": [
			{
				"name": "",
				"type": "bytes32"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	}
];

node.on('ready', () => {
	 console.log("IPFS prêt");

	 provider.getNetwork().then(
	   r =>  console.log("Ethereum connecté sur ", r)
	 )
	const contract = new ethers.Contract(address, abi, provider.getSigner());
	 //event
	contract.on("Epingler", (pin, event) => {

	    console.log(pinUrl,"ecoute evenement");

		node.add(new node.types.Buffer(pinS), (err,filesAdded) => {
			if (err) {
				return console.error('Error',err,res);
			}
			filesAdded.forEach(file => {
				console.log('Add success', file.hash);
				let hash = file.hash;

				node.pin.add(hash, function (err, result) {
		    		if (err) {
		    			console.log('Error pin', err);
		    		}
					console.log(result[0].hash +' was pinned');
	    		})
			});
		})

	});
});