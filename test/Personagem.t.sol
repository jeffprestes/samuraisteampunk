// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {Personagem} from "../src/Personagem.sol";
import {Samurai} from "../src/Samurai.sol";
import "forge-std/console.sol";


contract PersonagemTest is Test {

    Personagem public personagem;
    Samurai public samurai;
    address public bob;
    address public alice;

    function setUp() public {
        bob = vm.addr(1);
        alice = vm.addr(2);
        personagem = new Personagem(bob);
        samurai = new Samurai();
    }

    function testFail_transferNonExistingSamurai() public {
        vm.prank(bob);
        personagem.transfer(alice);
    }

    function testFail_souUmSamurai() public view {
        require(personagem.souUmSamurai());
    }

    function test_souUmSamurai() public {
        samurai.safeMint(address(personagem), 1);
        vm.prank(bob);
        personagem.setSamurai(address(samurai), 1);
        require(personagem.souUmSamurai(), "Nao sou um samurai ainda");
    }

    function test_transferSamurai() public {
        samurai.safeMint(address(personagem), 2);
        vm.startPrank(bob);
        personagem.setSamurai(address(samurai), 2);
        personagem.transfer(alice);
        require(samurai.isApprovedOrOwner(alice, 2));
        vm.stopPrank();
    }

    function test_transferPersonagem() public {
        samurai.safeMint(address(personagem), 3);
        vm.startPrank(bob);
        personagem.setSamurai(address(samurai), 3);
        personagem.transferOwnership(alice);
        vm.stopPrank();
        require(samurai.isApprovedOrOwner(address(personagem), 3));
        assertEq(alice, personagem.owner);
    }
}