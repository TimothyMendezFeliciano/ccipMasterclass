// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import {IRouterClient} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";
import {LinkTokenInterface} from "@chainlink/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";

contract CCIPUNSAFE_SENDER {

    address link;
    address router;

    constructor(address _link) {
        link = _link;
        LinkTokenInterface(link).approve(router, type(uint256).max);
    }

    function send(address receiver,
        uint64 destinationChainSelector,
        string memory someText) external {
        Client.EVM2AnyMessage memory message = Client.EVM2AnyMessage(
            {
                receiver: abi.encode(receiver),
                data: abi.encode(someText),
                tokenAmounts: new Client.EVMTokenAmount[](0),
                extraArgs: "",
                feeToken: link
            }
        );

        IRouterClient(router).ccipSend(destinationChainSelector, message);
    }

}