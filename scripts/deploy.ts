import * as hre from 'hardhat';
import { Controller } from '../types/ethers-contracts/Controller';
import { Controller__factory } from '../types/ethers-contracts/factories/Controller__factory';
import { PVault } from '../types/ethers-contracts/PVault';
import { PVault__factory } from '../types/ethers-contracts/factories/PVault__factory';
import { StrategyVenusBusd } from '../types/ethers-contracts/StrategyVenusBusd';
import { StrategyVenusBusd__factory } from '../types/ethers-contracts/factories/StrategyVenusBusd__factory';
import { ERC20 } from '../types/ethers-contracts/ERC20';
import { ERC20__factory } from '../types/ethers-contracts/factories/ERC20__factory';

const { ethers } = hre;

async function deploy() {
    const [deployer] = await ethers.getSigners();
    
    console.log(
        "Deploying contracts with the account:",
        deployer.address
    );

    const beforeBalance = await deployer.getBalance();
    console.log("Account balance:", (await deployer.getBalance()).toString());

    const controllerFactory: Controller__factory = new Controller__factory(deployer);
    const controller: Controller = await controllerFactory.deploy();

    console.log("Controller address:", controller.address);

    const busdAddress = '0x8301f2213c0eed49a7e28ae4c3e91722919b8b47';
    const busdFactory = new ERC20__factory(deployer);
    const busd = busdFactory.attach(busdAddress).connect(deployer);

    // const busdFactory = new ERC20__factory(deployer);
    // const busd = await busdFactory.deploy("Binance USD", "BUSD");
    // busd.mint(deployer.address, ethers.BigNumber.from('1000000000000000000'));

    const pVaultFactory: PVault__factory = new PVault__factory(deployer);
    const pBUSD: PVault = await pVaultFactory.deploy(busd.address, controller.address);
    
    console.log("pBUSD address:", pBUSD.address);

    const strategyVenusFactory: StrategyVenusBusd__factory = new StrategyVenusBusd__factory(deployer);
    const strategyVenus: StrategyVenusBusd = await strategyVenusFactory.deploy(controller.address);

    console.log("StrategyVenus address:", strategyVenus.address);

    // initialize
    await controller.setVault(busd.address, pBUSD.address);
    await controller.setStrategy(busd.address, strategyVenus.address);

    // await busd.approve(pBUSD.address, ethers.BigNumber.from('1000000000000000000'));

    // console.log("------ BEFORE DEPOSIT ------");
    // console.log("BUSD: ", (await busd.balanceOf(deployer.address)).toString());
    // console.log("pUSD: ", (await pBUSD.balanceOf(deployer.address)).toString());

    // await pBUSD.deposit(
    //     ethers.BigNumber.from('1000000000000000000'),
    //     {
    //         gasLimit: 9500000
    //     }
    // );

    // console.log("------ BEFORE WITHDRAW ------")
    // console.log("BUSD: ", (await busd.balanceOf(deployer.address)).toString());
    // console.log("pUSD: ", (await pBUSD.balanceOf(deployer.address)).toString());

    // await pBUSD.withdrawAll(
    //     {
    //         gasLimit: 9500000
    //     }
    // );

    // console.log("------ AFTER WITHDRAW ------")
    // console.log("BUSD: ", (await busd.balanceOf(deployer.address)).toString());
    // console.log("pUSD: ", (await pBUSD.balanceOf(deployer.address)).toString());

    const afterBalance = await deployer.getBalance();
    console.log(
        "Deployed cost:",
         (beforeBalance.sub(afterBalance)).toString()
    );
}

deploy()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })