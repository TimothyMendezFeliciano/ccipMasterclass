pragma solidity 0.8.19;

import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import {IRouterClient} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";
import {LinkTokenInterface} from "@chainlink/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";
import {CCIPReceiver} from "@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol";

contract CCIPUNSAFE_RECEIVER is CCIPReceiver {

    string public latestMessageText;
    address public latestMessageSender;

    constructor(address router) CCIPReceiver(router) {

    }

    function _ccipReceive(Client.Any2EVMMessage memory message) internal override {
        latestMessageText = abi.decode(message.data, (string));
        latestMessageSender = abi.decode(message.sender, (address));
    }
}