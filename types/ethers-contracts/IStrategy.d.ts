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

interface IStrategyInterface extends ethers.utils.Interface {
  functions: {
    "balanceOf()": FunctionFragment;
    "deposit()": FunctionFragment;
    "skim()": FunctionFragment;
    "want()": FunctionFragment;
    "withdraw(uint256)": FunctionFragment;
    "withdrawAll()": FunctionFragment;
    "withdrawalFee()": FunctionFragment;
  };

  encodeFunctionData(functionFragment: "balanceOf", values?: undefined): string;
  encodeFunctionData(functionFragment: "deposit", values?: undefined): string;
  encodeFunctionData(functionFragment: "skim", values?: undefined): string;
  encodeFunctionData(functionFragment: "want", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "withdraw",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "withdrawAll",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "withdrawalFee",
    values?: undefined
  ): string;

  decodeFunctionResult(functionFragment: "balanceOf", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "deposit", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "skim", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "want", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "withdraw", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "withdrawAll",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "withdrawalFee",
    data: BytesLike
  ): Result;

  events: {};
}

export class IStrategy extends Contract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  on(event: EventFilter | string, listener: Listener): this;
  once(event: EventFilter | string, listener: Listener): this;
  addListener(eventName: EventFilter | string, listener: Listener): this;
  removeAllListeners(eventName: EventFilter | string): this;
  removeListener(eventName: any, listener: Listener): this;

  interface: IStrategyInterface;

  functions: {
    balanceOf(overrides?: CallOverrides): Promise<[BigNumber]>;

    "balanceOf()"(overrides?: CallOverrides): Promise<[BigNumber]>;

    deposit(overrides?: Overrides): Promise<ContractTransaction>;

    "deposit()"(overrides?: Overrides): Promise<ContractTransaction>;

    skim(overrides?: Overrides): Promise<ContractTransaction>;

    "skim()"(overrides?: Overrides): Promise<ContractTransaction>;

    want(overrides?: CallOverrides): Promise<[string]>;

    "want()"(overrides?: CallOverrides): Promise<[string]>;

    withdraw(
      arg0: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    "withdraw(uint256)"(
      arg0: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    withdrawAll(overrides?: Overrides): Promise<ContractTransaction>;

    "withdrawAll()"(overrides?: Overrides): Promise<ContractTransaction>;

    withdrawalFee(overrides?: CallOverrides): Promise<[BigNumber]>;

    "withdrawalFee()"(overrides?: CallOverrides): Promise<[BigNumber]>;
  };

  balanceOf(overrides?: CallOverrides): Promise<BigNumber>;

  "balanceOf()"(overrides?: CallOverrides): Promise<BigNumber>;

  deposit(overrides?: Overrides): Promise<ContractTransaction>;

  "deposit()"(overrides?: Overrides): Promise<ContractTransaction>;

  skim(overrides?: Overrides): Promise<ContractTransaction>;

  "skim()"(overrides?: Overrides): Promise<ContractTransaction>;

  want(overrides?: CallOverrides): Promise<string>;

  "want()"(overrides?: CallOverrides): Promise<string>;

  withdraw(
    arg0: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  "withdraw(uint256)"(
    arg0: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  withdrawAll(overrides?: Overrides): Promise<ContractTransaction>;

  "withdrawAll()"(overrides?: Overrides): Promise<ContractTransaction>;

  withdrawalFee(overrides?: CallOverrides): Promise<BigNumber>;

  "withdrawalFee()"(overrides?: CallOverrides): Promise<BigNumber>;

  callStatic: {
    balanceOf(overrides?: CallOverrides): Promise<BigNumber>;

    "balanceOf()"(overrides?: CallOverrides): Promise<BigNumber>;

    deposit(overrides?: CallOverrides): Promise<void>;

    "deposit()"(overrides?: CallOverrides): Promise<void>;

    skim(overrides?: CallOverrides): Promise<void>;

    "skim()"(overrides?: CallOverrides): Promise<void>;

    want(overrides?: CallOverrides): Promise<string>;

    "want()"(overrides?: CallOverrides): Promise<string>;

    withdraw(arg0: BigNumberish, overrides?: CallOverrides): Promise<void>;

    "withdraw(uint256)"(
      arg0: BigNumberish,
      overrides?: CallOverrides
    ): Promise<void>;

    withdrawAll(overrides?: CallOverrides): Promise<BigNumber>;

    "withdrawAll()"(overrides?: CallOverrides): Promise<BigNumber>;

    withdrawalFee(overrides?: CallOverrides): Promise<BigNumber>;

    "withdrawalFee()"(overrides?: CallOverrides): Promise<BigNumber>;
  };

  filters: {};

  estimateGas: {
    balanceOf(overrides?: CallOverrides): Promise<BigNumber>;

    "balanceOf()"(overrides?: CallOverrides): Promise<BigNumber>;

    deposit(overrides?: Overrides): Promise<BigNumber>;

    "deposit()"(overrides?: Overrides): Promise<BigNumber>;

    skim(overrides?: Overrides): Promise<BigNumber>;

    "skim()"(overrides?: Overrides): Promise<BigNumber>;

    want(overrides?: CallOverrides): Promise<BigNumber>;

    "want()"(overrides?: CallOverrides): Promise<BigNumber>;

    withdraw(arg0: BigNumberish, overrides?: Overrides): Promise<BigNumber>;

    "withdraw(uint256)"(
      arg0: BigNumberish,
      overrides?: Overrides
    ): Promise<BigNumber>;

    withdrawAll(overrides?: Overrides): Promise<BigNumber>;

    "withdrawAll()"(overrides?: Overrides): Promise<BigNumber>;

    withdrawalFee(overrides?: CallOverrides): Promise<BigNumber>;

    "withdrawalFee()"(overrides?: CallOverrides): Promise<BigNumber>;
  };

  populateTransaction: {
    balanceOf(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    "balanceOf()"(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    deposit(overrides?: Overrides): Promise<PopulatedTransaction>;

    "deposit()"(overrides?: Overrides): Promise<PopulatedTransaction>;

    skim(overrides?: Overrides): Promise<PopulatedTransaction>;

    "skim()"(overrides?: Overrides): Promise<PopulatedTransaction>;

    want(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    "want()"(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    withdraw(
      arg0: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    "withdraw(uint256)"(
      arg0: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    withdrawAll(overrides?: Overrides): Promise<PopulatedTransaction>;

    "withdrawAll()"(overrides?: Overrides): Promise<PopulatedTransaction>;

    withdrawalFee(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    "withdrawalFee()"(overrides?: CallOverrides): Promise<PopulatedTransaction>;
  };
}
