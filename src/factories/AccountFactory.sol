// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;


import {GnosisSafeProxyFactory} from "safe-contracts/proxies/GnosisSafeProxyFactory.sol";
import {EIP4337Manager} from "account-abstraction/gnosis/EIP4337Manager.sol";
import {GnosisSafe} from "safe-contracts/GnosisSafe.sol";

contract AccountFactory {
  GnosisSafeProxyFactory public immutable proxyFactory;
  address public immutable singleton;
  EIP4337Manager public immutable eip4337Manager;

  constructor(
    GnosisSafeProxyFactory _proxyFactory,
    address _singleton,
    EIP4337Manager _eip4337Manager
  ) {
    proxyFactory = _proxyFactory;
    singleton = _singleton;
    eip4337Manager = _eip4337Manager;
  }

  function createAccount(address owner, uint salt) public returns (address) {
    // Check if deployment has occured
    address account = getAddress(owner, salt);
    if (account.code.length > 0) {
      return account;
    }
    return address(proxyFactory.createProxyWithNonce(singleton, getInitializer(owner), salt));
  }

  // Note: Figure out if you want to pass in owners
  function getInitializer(address owner) internal view returns (bytes memory) {
    address[] memory owners = new address[](1);
    owners[0] = owner;
    uint threshold = 1;
    address eip4337Fallback = eip4337Manager.eip4337Fallback();

    bytes memory setup4337Modules = abi.encodeCall(
      EIP4337Manager.setup4337Modules, (eip4337Manager)
    );

    return abi.encodeCall(GnosisSafe.setup, (
      owners,
      threshold,
      address(eip4337Manager),
      setup4337Modules,
      eip4337Fallback,
      address(0),
      0,
      payable(0)
    ));
  }

  function getAddress(address owner, uint salt) public view returns (address) {
    bytes memory initializer = getInitializer(owner);
    bytes32 hash = keccak256(
      abi.encodePacked(
        bytes1(0xff),
        address(this),
        salt,
        keccak256(initializer)
      )
    );
    return address(uint160(uint(hash)));
  }
}