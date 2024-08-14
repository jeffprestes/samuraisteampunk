// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Ownable} from "solady/auth/Ownable.sol";
import {LibString} from "solady/utils/LibString.sol";
import {Samurai} from "./Samurai.sol";

contract Personagem is Ownable {

    Samurai public samurai;
    uint256 public samuraiId;

    constructor(address realOwner_) {
        super._initializeOwner(realOwner_);
    }

    function setSamurai(address samuraiAddress_, uint256 samuraiId_) external onlyOwner {
        samurai = Samurai(samuraiAddress_);
        samuraiId = samuraiId_;
        require(souUmSamurai(), "Voce nao pode atribuir a si mesmo um Samurai que nao eh seu");
    }

    function transfer(address to_) external onlyOwner {
        samurai.safeTransferFrom(address(this), to_, samuraiId);
    }

    function souUmSamurai() public view returns (bool) {
        return samurai.ownerOf(samuraiId) == address(this);
    }

    function onERC721Received(address, address, uint256, bytes memory) public virtual returns (bytes4) {
        return this.onERC721Received.selector;
    }

}