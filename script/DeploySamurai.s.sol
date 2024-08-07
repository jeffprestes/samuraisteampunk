// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "forge-std/Script.sol";
import "../src/Samurai.sol";


/*
forge script script/DeploySamurai.s.sol:DeploySamurai --rpc-url $RPC_POLYGON_MAINNET --broadcast --verify --chain polygon --etherscan-api-key $POLYGONSCAN_API_KEY -vvvv
forge script script/DeploySamurai.s.sol:DeploySamurai --rpc-url $RPC_POLYGON_TEST --broadcast --verify --chain polygon --etherscan-api-key $POLYGONSCAN_API_KEY -vvvv
*/
contract DeploySamurai is Script {
    function run() external {
        uint256 deployerPrivatekey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivatekey);
        Samurai samurai = new Samurai();
        vm.stopBroadcast();
    }
}