# Get Testnet Tokens - Quick Guide

## The Issue

The publish command is waiting because there are no testnet SUI tokens in your wallet.

## Solution

### Option 1: Use Web Faucet (Recommended)

1. **Visit the Sui Testnet Faucet:**
   - Direct link: https://faucet.sui.io/?address=0xaa37802ef769cea5cb80e09712a861750aa6402cd2d2caf02c8780717689b724
   - Or go to https://faucet.sui.io/ and enter: `0xaa37802ef769cea5cb80e09712a861750aa6402cd2d2caf02c8780717689b724`

2. **Request Tokens:**
   - Click "Request SUI Tokens"
   - Wait 10-30 seconds for tokens to arrive

3. **Verify You Have Tokens:**
   ```bash
   cd simple_nft_marketplace
   sui client balance
   ```

4. **Deploy:**
   ```bash
   cd /Users/garylloydsenoc/Desktop/nft
   ./deploy-testnet.sh
   ```

### Option 2: Use Your Wallet Address

If you want to use your admin address instead:

1. Visit: https://faucet.sui.io/?address=0xd521a7c075dc422222bca144bcf21291b1f80fdff404603f02564dfccd880e69
2. Request tokens
3. Switch to that address: `sui client switch --address 0xd521a7c075dc422222bca144bcf21291b1f80fdff404603f02564dfccd880e69`
4. Then deploy

## After Getting Tokens

Once you have testnet tokens, the deployment script will:
- ✅ Build the contract
- ✅ Publish to testnet
- ✅ Extract package ID and marketplace object ID
- ✅ Automatically update `.env.local` with testnet values

## Current Status

- **Network**: testnet
- **Balance**: No tokens (need to get from faucet)
- **Active Address**: `0xaa37802ef769cea5cb80e09712a861750aa6402cd2d2caf02c8780717689b724`
- **Contract**: Built and ready to deploy

## Quick Command

After getting tokens, just run:
```bash
./deploy-testnet.sh
```

The script will handle everything automatically!

