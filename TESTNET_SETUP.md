# Testnet Setup Instructions

## Step 1: Get Testnet SUI Tokens

1. Visit the Sui testnet faucet: https://faucet.sui.io/
2. Enter your wallet address: `0xaa37802ef769cea5cb80e09712a861750aa6402cd2d2caf02c8780717689b724`
3. Request testnet SUI tokens
4. Wait a few seconds for the tokens to arrive

Or use the direct link:
https://faucet.sui.io/?address=0xaa37802ef769cea5cb80e09712a861750aa6402cd2d2caf02c8780717689b724

## Step 2: Verify You Have Tokens

```bash
cd simple_nft_marketplace
sui client balance
```

You should see at least 1-2 SUI for deployment.

## Step 3: Deploy Contract to Testnet

```bash
cd simple_nft_marketplace
sui client publish --gas-budget 100000000 --json
```

This will output a JSON with:
- `packageId` - The package ID (update `NEXT_PUBLIC_PACKAGE_ID` in `.env.local`)
- `created` objects - Look for the Marketplace object ID (update `NEXT_PUBLIC_MARKETPLACE_TYPE`)

## Step 4: Update .env.local File

After deployment, update `/nft-marketplace-frontend/.env.local` with:

1. **Package ID**: From the publish transaction output
2. **NFT Type**: `PACKAGE_ID::nft_marketplace::DevNetNFT`
3. **Listing Type**: `PACKAGE_ID::nft_marketplace::Listing`
4. **Marketplace Type**: The Marketplace object ID from the `created` array in publish output

## Step 5: Verify Deployment

```bash
# Check the package exists
sui client object <PACKAGE_ID>

# Check the marketplace exists
sui client object <MARKETPLACE_OBJECT_ID>
```

## Current Configuration

- **Network**: testnet
- **Active Address**: `0xaa37802ef769cea5cb80e09712a861750aa6402cd2d2caf02c8780717689b724`
- **Admin Address**: `0xd521a7c075dc422222bca144bcf21291b1f80fdff404603f02564dfccd880e69`

## Notes

- The contract is already built and ready to deploy
- Make sure you have testnet SUI tokens before publishing
- The package ID will be different from devnet - you'll need to update all references

