import React from "react";
import { ConnectButton } from "@rainbow-me/rainbowkit";
function Header() {
  return (
    <div className="flex items-center p-2 justify-between w-full">
      <h1 className="text-xl lg:text-3xl font-mono font-bold">SWAP Token</h1>
      <div>
        <ConnectButton
          label="Sign in"
          chainStatus="none"
          accountStatus={{
            smallScreen: "address",
            largeScreen: "full",
          }}
          showBalance={{
            smallScreen: false,
            largeScreen: true,
          }}
        />
      </div>
    </div>
  );
}

export default Header;
