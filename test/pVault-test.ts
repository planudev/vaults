import { expect, use } from 'chai';
import { solidity } from 'ethereum-waffle';

import * as hre from 'hardhat';
import { ERC20 } from '../types/ethers-contracts/ERC20';
import { ERC20__factory } from '../types/ethers-contracts/factories/ERC20__factory';
import { PVault } from '../types/ethers-contracts/PVault';
import { PVault__factory } from '../types/ethers-contracts/factories/PVault__factory';
import { Signer } from 'ethers';

const { ethers } = hre;

use(solidity);

const MOCK_CONTROLLER_ADDRESS = '0x0000000000000000000000000000000000000001';

describe('pVault', () => {
    let deployer: Signer;
    let erc20Factory: ERC20__factory;
    let erc20BUSD: ERC20;
    let pVaultFactory: PVault__factory;
    let pBUSD: PVault;

    beforeEach(async () => {
        [ deployer ] = await ethers.getSigners();
        erc20Factory = new ERC20__factory(deployer);
        pVaultFactory = new PVault__factory(deployer);

        erc20BUSD = await erc20Factory.deploy("Binance USD", "BUSD");
        pBUSD = await pVaultFactory.deploy(erc20BUSD.address, MOCK_CONTROLLER_ADDRESS);
    });

    it('Should have name prefix with planu', async () => {
        const prefixWithPlanu = /^(planu)/g;
        const planuTokenName = await pBUSD.name();
        expect(planuTokenName.match(prefixWithPlanu)[0]).to.equal('planu');
    });

    it('Should have symbol prefix with p', async () => {
        const prefixWithP = /^(p)/g;
        const planuTokenSymbol = await pBUSD.symbol();
        expect(planuTokenSymbol.match(prefixWithP)[0]).to.equal('p');
    });
});