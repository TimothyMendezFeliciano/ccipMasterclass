import {ethers, network, run} from "hardhat";

async function main() {

    if (network.name !== `sepolia`) {
        console.error('Using Sepolia for the tutorial')
        return 1;
    }

    const sepoliaRouterAddress = `0xD0daae2231E9CB96b94C8512223533293C3693Bf`

    await run("compile");

    const ccipReceiverFactory = await ethers.getContractFactory("CCIPUNSAFE_RECEIVER");
    const ccipReceiver = await ccipReceiverFactory.deploy(sepoliaRouterAddress);

    await ccipReceiver.deployed();

    console.log(`CCIPReceiverUnsafe ${ccipReceiver.address}`)
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1
})