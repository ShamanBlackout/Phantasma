import { ITxs } from "./ITxs";

export interface IAddressVertex {
  [address: string]: {
    txs?: [ITxs];
    connections?: {
      [conn_address: string]: {
        sent?: number;
        received?: number;
      };
    };
  };
}
