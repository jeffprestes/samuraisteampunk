// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {ERC721} from "solady/tokens/ERC721.sol";
import {Ownable} from "solady/auth/Ownable.sol";
import {LibString} from "solady/utils/LibString.sol";

contract Samurai is ERC721, Ownable {

    constructor() {
        _initializeOwner(msg.sender);
    }
    
    function name() public view virtual override returns (string memory) {
        return "Real Samurai Steampunk NFT";
    }

    function symbol() public view virtual override returns (string memory) {
        return "RSSNFT";
    }

    function tokenURI(uint256 id) public view virtual override returns (string memory) {
        if (!_exists(id)) revert TokenDoesNotExist();
        return string(abi.encodePacked("https://github.io/jeffprestes/samuraisteampunk/json/", LibString.toString(id), ".json"));
    }

    function exists(uint256 id) public view virtual returns (bool) {
        return _exists(id);
    }

    function mintWithExtraDataUnchecked(address to, uint256 id, uint96 value) public virtual onlyOwner {
        _mintAndSetExtraDataUnchecked(to, id, value);
    }

    function burn(uint256 id) public virtual {
        _burn(msg.sender, id);
    }

    function uncheckedBurn(uint256 id) public virtual onlyOwner {
        _burn(id);
    }

    function safeMint(address to, uint256 id) public virtual onlyOwner {
        _safeMint(to, id);
    }

    function safeMint(address to, uint256 id, bytes calldata data) public virtual onlyOwner {
        _safeMint(to, id, data);
    }

    function getExtraData(uint256 id) public view virtual returns (uint96) {
        return _getExtraData(id);
    }

    function setExtraData(uint256 id, uint96 value) public virtual onlyOwner {
        _setExtraData(id, value);
    }

    function getAux(address owner) public view virtual returns (uint224) {
        return _getAux(owner);
    }

    function setAux(address owner, uint224 value) public virtual onlyOwner {
        _setAux(owner, value);
    }

    function approve(address account, uint256 id) public payable virtual override {
        super.approve(account, id);
    }

    function directApprove(address account, uint256 id) public virtual {
        if (!_isApprovedOrOwner(msg.sender, id)) revert NotOwnerNorApproved();
        _approve(account, id);
    }


    function transferFrom(address from, address to, uint256 id) public payable virtual override {
        super.transferFrom(from, to, id);
    }


    function directTransferFrom(address from, address to, uint256 id) public virtual {
        _transfer(msg.sender, from, to, id);
    }

    function safeTransferFrom(address from, address to, uint256 id)
        public
        payable
        virtual
        override
    {
        super.safeTransferFrom(from, to, id);
    }

    function directSafeTransferFrom(address from, address to, uint256 id) public virtual {
        _safeTransfer(msg.sender, from, to, id);
    }

    function safeTransferFrom(address from, address to, uint256 id, bytes calldata data)
        public
        payable
        virtual
        override
    {
        super.safeTransferFrom(from, to, id, data);
    }

    function directSafeTransferFrom(address from, address to, uint256 id, bytes calldata data)
        public
        virtual
    {
        _safeTransfer(msg.sender, from, to, id, data);
    }

    function isApprovedOrOwner(address account, uint256 id) public view virtual returns (bool) {
        return _isApprovedOrOwner(account, id);
    }

    function directOwnerOf(uint256 id) public view virtual returns (address) {
        if (!_exists(id)) revert TokenDoesNotExist();
        return _ownerOf(id);
    }

    function directGetApproved(uint256 id) public view virtual returns (address) {
        if (!_exists(id)) revert TokenDoesNotExist();
        return _getApproved(id);
    }
}