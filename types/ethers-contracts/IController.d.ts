/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import {
  ethers,
  EventFilter,
  Signer,
  BigNumber,
  BigNumberish,
  PopulatedTransaction,
} from "ethers";
import {
  Contract,
  ContractTransaction,
  Overrides,
  CallOverrides,
} from "@ethersproject/contracts";
import { BytesLike } from "@ethersproject/bytes";
import { Listener, Provider } from "@ethersproject/providers";
import { FunctionFragment, EventFragment, Result } from "@ethersproject/abi";

interface IControllerInterface extends ethers.utils.Interface {
  functions: {
    "balanceOf(address)": FunctionFragment;
    "earn(address,uint256)": FunctionFragment;
    "rewards()": FunctionFragment;
    "strategies(address)": FunctionFragment;
    "vaults(address)": FunctionFragment;
    "withdraw(address,uint256)": FunctionFragment;
  };

  encodeFunctionData(functionFragment: "balanceOf", values: [string]): string;
  encodeFunctionData(
    functionFragment: "earn",
    values: [string, BigNumberish]
  ): string;
  encodeFunctionData(functionFragment: "rewards", values?: undefined): string;
  encodeFunctionData(functionFragment: "strategies", values: [string]): string;
  encodeFunctionData(functionFragment: "vaults", values: [string]): string;
  encodeFunctionData(
    functionFragment: "withdraw",
    values: [string, BigNumberish]
  ): string;

  decodeFunctionResult(functionFragment: "balanceOf", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "earn", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "rewards", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "strategies", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "vaults", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "withdraw", data: BytesLike): Result;

  events: {};
}

export class IController extends Contract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  on(event: EventFilter | string, listener: Listener): this;
  once(event: EventFilter | string, listener: Listener): this;
  addListener(eventName: EventFilter | string, listener: Listener): this;
  removeAllListeners(eventName: EventFilter | string): this;
  removeListener(eventName: any, listener: Listener): this;

  interface: IControllerInterface;

  functions: {
    balanceOf(arg0: string, overrides?: CallOverrides): Promise<[BigNumber]>;

    "balanceOf(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<[BigNumber]>;

    earn(
      arg0: string,
      arg1: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    "earn(address,uint256)"(
      arg0: string,
      arg1: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    rewards(overrides?: CallOverrides): Promise<[string]>;

    "rewards()"(overrides?: CallOverrides): Promise<[string]>;

    strategies(arg0: string, overrides?: CallOverrides): Promise<[string]>;

    "strategies(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<[string]>;

    vaults(arg0: string, overrides?: CallOverrides): Promise<[string]>;

    "vaults(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<[string]>;

    withdraw(
      arg0: string,
      arg1: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    "withdraw(address,uint256)"(
      arg0: string,
      arg1: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;
  };

  balanceOf(arg0: string, overrides?: CallOverrides): Promise<BigNumber>;

  "balanceOf(address)"(
    arg0: string,
    overrides?: CallOverrides
  ): Promise<BigNumber>;

  earn(
    arg0: string,
    arg1: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  "earn(address,uint256)"(
    arg0: string,
    arg1: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  rewards(overrides?: CallOverrides): Promise<string>;

  "rewards()"(overrides?: CallOverrides): Promise<string>;

  strategies(arg0: string, overrides?: CallOverrides): Promise<string>;

  "strategies(address)"(
    arg0: string,
    overrides?: CallOverrides
  ): Promise<string>;

  vaults(arg0: string, overrides?: CallOverrides): Promise<string>;

  "vaults(address)"(arg0: string, overrides?: CallOverrides): Promise<string>;

  withdraw(
    arg0: string,
    arg1: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  "withdraw(address,uint256)"(
    arg0: string,
    arg1: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  callStatic: {
    balanceOf(arg0: string, overrides?: CallOverrides): Promise<BigNumber>;

    "balanceOf(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    earn(
      arg0: string,
      arg1: BigNumberish,
      overrides?: CallOverrides
    ): Promise<void>;

    "earn(address,uint256)"(
      arg0: string,
      arg1: BigNumberish,
      overrides?: CallOverrides
    ): Promise<void>;

    rewards(overrides?: CallOverrides): Promise<string>;

    "rewards()"(overrides?: CallOverrides): Promise<string>;

    strategies(arg0: string, overrides?: CallOverrides): Promise<string>;

    "strategies(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<string>;

    vaults(arg0: string, overrides?: CallOverrides): Promise<string>;

    "vaults(address)"(arg0: string, overrides?: CallOverrides): Promise<string>;

    withdraw(
      arg0: string,
      arg1: BigNumberish,
      overrides?: CallOverrides
    ): Promise<void>;

    "withdraw(address,uint256)"(
      arg0: string,
      arg1: BigNumberish,
      overrides?: CallOverrides
    ): Promise<void>;
  };

  filters: {};

  estimateGas: {
    balanceOf(arg0: string, overrides?: CallOverrides): Promise<BigNumber>;

    "balanceOf(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    earn(
      arg0: string,
      arg1: BigNumberish,
      overrides?: Overrides
    ): Promise<BigNumber>;

    "earn(address,uint256)"(
      arg0: string,
      arg1: BigNumberish,
      overrides?: Overrides
    ): Promise<BigNumber>;

    rewards(overrides?: CallOverrides): Promise<BigNumber>;

    "rewards()"(overrides?: CallOverrides): Promise<BigNumber>;

    strategies(arg0: string, overrides?: CallOverrides): Promise<BigNumber>;

    "strategies(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    vaults(arg0: string, overrides?: CallOverrides): Promise<BigNumber>;

    "vaults(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    withdraw(
      arg0: string,
      arg1: BigNumberish,
      overrides?: Overrides
    ): Promise<BigNumber>;

    "withdraw(address,uint256)"(
      arg0: string,
      arg1: BigNumberish,
      overrides?: Overrides
    ): Promise<BigNumber>;
  };

  populateTransaction: {
    balanceOf(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    "balanceOf(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    earn(
      arg0: string,
      arg1: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    "earn(address,uint256)"(
      arg0: string,
      arg1: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    rewards(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    "rewards()"(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    strategies(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    "strategies(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    vaults(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    "vaults(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    withdraw(
      arg0: string,
      arg1: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    "withdraw(address,uint256)"(
      arg0: string,
      arg1: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;
  };
}