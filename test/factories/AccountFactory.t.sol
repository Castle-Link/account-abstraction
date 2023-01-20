// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {EntryPoint} from "account-abstraction/core/EntryPoint.sol";
import {GnosisSafeProxyFactory} from "safe-contracts/proxies/GnosisSafeProxyFactory.sol";
import {GnosisSafeAccountFactory} from "account-abstraction/gnosis/GnosisAccountFactory.sol";
import {EIP4337Manager} from "account-abstraction/gnosis/EIP4337Manager.sol";

contract AccountFactoryTestContract is Test {
    EntryPoint e;
    EIP4337Manager aaModule;
    address public immutable singletonAddress = 0xd9Db270c1B5E3Bd161E8c8503c55cEABeE709552;
    address public immutable proxyFactoryAddress = 0xa6B71E26C5e0845f74c812102Ca7114b6a896AB2;
    GnosisSafeAccountFactory f;
    function setUp() public {
      GnosisSafeProxyFactory pf = GnosisSafeProxyFactory(proxyFactoryAddress);
      e = new EntryPoint();
      aaModule = new EIP4337Manager(address(e));
      f = new GnosisSafeAccountFactory(pf, singletonAddress, aaModule);
    }

}
