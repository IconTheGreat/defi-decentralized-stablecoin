//SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract DecentralizedStablecoin is ERC20Burnable, Ownable {
    error DecentralizedStablecoin__CantMintToZeroAddress();
    error DecentralizedStablecoin__AmountCantBeZero();
    error DecentralizedStablecoin__BalanceMustExceedBurnAmount();

    constructor(address initialOwner) Ownable(initialOwner) ERC20("DecentralizedStablecoin", "DSC") {}

    function mint(address _to, uint256 _amount) external onlyOwner returns (bool) {
        if (_to == address(0)) {
            revert DecentralizedStablecoin__CantMintToZeroAddress();
        }

        if (_amount == 0) {
            revert DecentralizedStablecoin__AmountCantBeZero();
        }
        _mint(_to, _amount);
        return true;
    }

    function burn(uint256 _amount) public override onlyOwner {
        if (_amount == 0) {
            revert DecentralizedStablecoin__AmountCantBeZero();
        }

        if (balanceOf(msg.sender) < _amount) {
            revert DecentralizedStablecoin__BalanceMustExceedBurnAmount();
        }
        super.burn(_amount);
    }
}
