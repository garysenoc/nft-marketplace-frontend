# Fix: Insufficient Balance When Buying NFT

## The Problem

When trying to buy an NFT, you're getting:
```
Dry run failed, could not automatically determine a budget: InsufficientCoinBalance
```

This means you don't have enough SUI tokens to:
1. Pay for the NFT price
2. Cover the gas fees (~0.1 SUI)

## Solution: Get Testnet Tokens

### Option 1: Use the Faucet Link (Easiest)

1. **Get your wallet address** from the wallet button in the app
2. **Visit the faucet**: https://faucet.sui.io/
3. **Enter your address** and click "Request SUI Tokens"
4. **Wait 10-30 seconds** for tokens to arrive

### Option 2: Direct Link

If your wallet address is `YOUR_ADDRESS`, visit:
```
https://faucet.sui.io/?address=YOUR_ADDRESS
```

### Option 3: Using CLI

```bash
# Make sure you're on testnet
cd simple_nft_marketplace
sui client active-env  # Should show "testnet"

# Get your address
sui client active-address

# Request tokens (if CLI supports it)
# Or use the web faucet above
```

## What Changed in the Code

The marketplace component now:
1. ✅ **Checks your balance** before attempting purchase
2. ✅ **Shows clear error messages** with exact amounts needed
3. ✅ **Provides a link** to get testnet tokens (in error toast)
4. ✅ **Sets explicit gas budget** to avoid estimation issues

## How Much Do You Need?

- **NFT Price**: Varies (e.g., 1 SUI = 1,000,000,000 MIST)
- **Gas Fee**: ~0.1 SUI (100,000,000 MIST)
- **Total Needed**: NFT Price + 0.1 SUI

Example: If NFT costs 1 SUI, you need **1.1 SUI total**.

## After Getting Tokens

1. **Refresh the page** to update your balance display
2. **Try buying again** - the balance check will verify you have enough
3. The transaction should succeed!

## Current Status

- ✅ Balance checking added
- ✅ Better error messages
- ✅ Gas budget set explicitly
- ✅ Pre-purchase validation

The error should now show you exactly how much you need and provide a quick way to get tokens!

