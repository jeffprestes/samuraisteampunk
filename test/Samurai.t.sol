// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {Samurai} from "../src/Samurai.sol";

contract SamuraiTest is Test {
    Samurai public samurai;

    function setUp() public {
        samurai = new Samurai();
    }

    function test_uri() public {
        samurai.safeMint(msg.sender, 1);
        assertEq(samurai.tokenURI(1), "https://github.io/jeffprestes/samuraisteampunk/json/1.json");
    }

    function testFail_unauthorizedMint() public {
        vm.prank(address(0));
        samurai.safeMint(address(0x3E3DD5092D8ff8e50370D0783DBf077bb4eda3e5), 2);
    }

    function test_transfer() public {
        address bob = vm.addr(1);
        address alice = vm.addr(2);
        samurai.safeMint(bob, 3);
        vm.startPrank(bob);
        samurai.safeTransferFrom(bob, alice, 3);
        assertEq(true, samurai.isApprovedOrOwner(alice, 3));
        vm.stopPrank();
    }

    function testFail_transfer() public {
        address bob = vm.addr(1);
        address alice = vm.addr(2);
        samurai.safeMint(bob, 3);
        samurai.safeTransferFrom(bob, alice, 3);
        assertEq(true, samurai.isApprovedOrOwner(alice, 3));
    }
    
}