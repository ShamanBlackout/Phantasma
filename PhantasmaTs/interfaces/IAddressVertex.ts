import { ITxs } from "./ITxs";

export interface IAddressVertex {
  [address: string]: {
    txs: string[];
    connections: {
      [conn_address: string]: {
        sent: number;
        received: number;
      };
    };
  };
}
