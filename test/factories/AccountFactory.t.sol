// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {EntryPoint} from "account-abstraction/core/EntryPoint.sol";
import {GnosisSafeProxyFactory} from "safe-contracts/proxies/GnosisSafeProxyFactory.sol";
import {EIP4337Manager} from "account-abstraction/gnosis/EIP4337Manager.sol";

import {AccountFactory} from "../../src/factories/AccountFactory.sol";

interface CheatCodes {
    function addr(uint256) external returns (address);
}

contract AccountFactoryTestContract is Test {
    CheatCodes cheats = CheatCodes(HEVM_ADDRESS);
    address public owner;
    address public addr1;
    EntryPoint e;
    EIP4337Manager aaModule;
    address public immutable singletonAddress = 0xd9Db270c1B5E3Bd161E8c8503c55cEABeE709552;
    address public immutable proxyFactoryAddress = 0xa6B71E26C5e0845f74c812102Ca7114b6a896AB2;
    AccountFactory f;
    
    function setUp() public {
      owner = address(this);
      addr1 = cheats.addr(1);
      GnosisSafeProxyFactory pf = GnosisSafeProxyFactory(proxyFactoryAddress);
      e = new EntryPoint();
      aaModule = new EIP4337Manager(address(e));
      f = new AccountFactory(pf, singletonAddress, aaModule);
    }

    function testGetAddress(uint256 salt) public view {
      f.getAddress(owner, salt);
      assert(true);
    }

    function testCreateAccount(uint256 salt) public {
      address create2Address = f.getAddress(owner, salt);
      address accountAddress = f.createAccount(owner, salt);
      assertEq(create2Address, accountAddress);
    }
}

