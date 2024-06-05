import "@/styles/globals.css";
import "@rainbow-me/rainbowkit/styles.css";

import {
  darkTheme,
  getDefaultConfig,
  RainbowKitProvider,
} from "@rainbow-me/rainbowkit";
import { WagmiProvider } from "wagmi";
import {
  mainnet,
  optimism,
  arbitrum,
  base,
  sepolia,
  bsc,
  bscTestnet,
} from "wagmi/chains";
import { QueryClientProvider, QueryClient } from "@tanstack/react-query";

const config = getDefaultConfig({
  appName: "Swap Token",
  projectId: "40aa4bb5c84d23d661573cdb054f894c",
  chains: [mainnet, optimism, arbitrum, base, sepolia, bsc, bscTestnet],
  ssr: true, // If your dApp uses server side rendering (SSR)
});

const queryClient = new QueryClient();

export default function App({ Component, pageProps }) {
  return (
    <WagmiProvider config={config}>
      <QueryClientProvider client={queryClient}>
        <RainbowKitProvider theme={darkTheme()} modalSize="wide">
          <Component {...pageProps} />
        </RainbowKitProvider>
      </QueryClientProvider>
    </WagmiProvider>
  );
}

// #SwapToken - 0x7D3425480D5a72605fcC5639b86744A592BE3462
