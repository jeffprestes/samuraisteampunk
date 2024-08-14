// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "forge-std/Script.sol";
import "../src/Personagem.sol";


/*
forge script script/DeployPersonagem.s.sol:DeployPersonagem --rpc-url $RPC_POLYGON_MAINNET --broadcast --verify --chain polygon --etherscan-api-key $POLYGONSCAN_API_KEY -vvvv
forge script script/DeployPersonagem.s.sol:DeployPersonagem --rpc-url $RPC_POLYGON_TEST --broadcast --verify --chain polygon --etherscan-api-key $POLYGONSCAN_API_KEY -vvvv
forge script script/DeployPersonagem.s.sol:DeployPersonagem --rpc-url %RPC_POLYGON_TEST% --broadcast --verify --chain polygon --etherscan-api-key %POLYGONSCAN_API_KEY% -vvvv
*/
contract DeployPersonagem is Script {
    function run() external {
        uint256 deployerPrivatekey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivatekey);
        new Personagem(msg.sender);
        vm.stopBroadcast();
    }
}