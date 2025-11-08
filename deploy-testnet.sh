#!/bin/bash

# Script to deploy NFT Marketplace contract to testnet
# Make sure you have testnet SUI tokens first!

set -e

echo "🚀 Deploying NFT Marketplace to Testnet..."
echo ""

# Check if we're on testnet
CURRENT_ENV=$(sui client active-env 2>/dev/null | grep -v "warning" | xargs)
if [ "$CURRENT_ENV" != "testnet" ]; then
    echo "❌ Error: Not on testnet. Current environment: $CURRENT_ENV"
    echo "Switching to testnet..."
    sui client switch --env testnet
fi

# Check balance
echo "💰 Checking balance..."
BALANCE_OUTPUT=$(sui client balance 2>/dev/null || echo "No coins")
if echo "$BALANCE_OUTPUT" | grep -q "No coins\|0.00 SUI"; then
    echo "❌ No testnet SUI tokens found!"
    echo ""
    echo "Please get testnet tokens from:"
    ADDRESS=$(sui client active-address 2>/dev/null | grep -v "warning" | xargs)
    echo "https://faucet.sui.io/?address=$ADDRESS"
    echo ""
    echo "Then run this script again:"
    echo "  ./deploy-testnet.sh"
    exit 1
fi

echo "$BALANCE_OUTPUT"
echo ""

# Build the contract
echo "📦 Building contract..."
cd simple_nft_marketplace
sui move build

# Publish to testnet
echo ""
echo "📤 Publishing to testnet..."
PUBLISH_OUTPUT=$(sui client publish --gas-budget 100000000 --json)

# Save output for debugging
echo "$PUBLISH_OUTPUT" > ../publish-output.json

# Extract package ID using jq if available, or grep
if command -v jq &> /dev/null; then
    PACKAGE_ID=$(echo "$PUBLISH_OUTPUT" | jq -r '.objectChanges[] | select(.type == "published") | .packageId' | head -1)
    MARKETPLACE_ID=$(echo "$PUBLISH_OUTPUT" | jq -r '.objectChanges[] | select(.objectType | contains("Marketplace")) | .objectId' | head -1)
else
    # Fallback to grep
    PACKAGE_ID=$(echo "$PUBLISH_OUTPUT" | grep -o '"packageId":"[^"]*"' | head -1 | cut -d'"' -f4)
    MARKETPLACE_ID=$(echo "$PUBLISH_OUTPUT" | grep -o '"objectId":"[^"]*"' | grep -v "$PACKAGE_ID" | head -1 | cut -d'"' -f4)
fi

if [ -z "$PACKAGE_ID" ]; then
    echo "❌ Failed to extract package ID from publish output"
    echo "Full output saved to: publish-output.json"
    exit 1
fi

echo ""
echo "✅ Deployment successful!"
echo ""
echo "Package ID: $PACKAGE_ID"
if [ ! -z "$MARKETPLACE_ID" ]; then
    echo "Marketplace Object ID: $MARKETPLACE_ID"
fi
echo ""

# Update .env.local
cd ../nft-marketplace-frontend
if [ -f .env.local ]; then
    echo "📝 Updating .env.local..."
    
    # Update package ID
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        sed -i '' "s|NEXT_PUBLIC_PACKAGE_ID=.*|NEXT_PUBLIC_PACKAGE_ID=$PACKAGE_ID|" .env.local
        sed -i '' "s|NEXT_PUBLIC_NFT_TYPE=.*|NEXT_PUBLIC_NFT_TYPE=${PACKAGE_ID}::nft_marketplace::DevNetNFT|" .env.local
        sed -i '' "s|NEXT_PUBLIC_LISTING_TYPE=.*|NEXT_PUBLIC_LISTING_TYPE=${PACKAGE_ID}::nft_marketplace::Listing|" .env.local
        if [ ! -z "$MARKETPLACE_ID" ]; then
            sed -i '' "s|NEXT_PUBLIC_MARKETPLACE_TYPE=.*|NEXT_PUBLIC_MARKETPLACE_TYPE=$MARKETPLACE_ID|" .env.local
        fi
        sed -i '' "s|NEXT_PUBLIC_SUI_NETWORK=.*|NEXT_PUBLIC_SUI_NETWORK=testnet|" .env.local
    else
        # Linux
        sed -i "s|NEXT_PUBLIC_PACKAGE_ID=.*|NEXT_PUBLIC_PACKAGE_ID=$PACKAGE_ID|" .env.local
        sed -i "s|NEXT_PUBLIC_NFT_TYPE=.*|NEXT_PUBLIC_NFT_TYPE=${PACKAGE_ID}::nft_marketplace::DevNetNFT|" .env.local
        sed -i "s|NEXT_PUBLIC_LISTING_TYPE=.*|NEXT_PUBLIC_LISTING_TYPE=${PACKAGE_ID}::nft_marketplace::Listing|" .env.local
        if [ ! -z "$MARKETPLACE_ID" ]; then
            sed -i "s|NEXT_PUBLIC_MARKETPLACE_TYPE=.*|NEXT_PUBLIC_MARKETPLACE_TYPE=$MARKETPLACE_ID|" .env.local
        fi
        sed -i "s|NEXT_PUBLIC_SUI_NETWORK=.*|NEXT_PUBLIC_SUI_NETWORK=testnet|" .env.local
    fi
    
    echo "✅ .env.local updated!"
    echo ""
    echo "Updated values:"
    echo "  Package ID: $PACKAGE_ID"
    echo "  NFT Type: ${PACKAGE_ID}::nft_marketplace::DevNetNFT"
    echo "  Listing Type: ${PACKAGE_ID}::nft_marketplace::Listing"
    if [ ! -z "$MARKETPLACE_ID" ]; then
        echo "  Marketplace: $MARKETPLACE_ID"
    fi
else
    echo "⚠️  .env.local not found. Please update manually:"
    echo ""
    echo "NEXT_PUBLIC_SUI_NETWORK=testnet"
    echo "NEXT_PUBLIC_PACKAGE_ID=$PACKAGE_ID"
    echo "NEXT_PUBLIC_NFT_TYPE=${PACKAGE_ID}::nft_marketplace::DevNetNFT"
    echo "NEXT_PUBLIC_LISTING_TYPE=${PACKAGE_ID}::nft_marketplace::Listing"
    if [ ! -z "$MARKETPLACE_ID" ]; then
        echo "NEXT_PUBLIC_MARKETPLACE_TYPE=$MARKETPLACE_ID"
    fi
fi

echo ""
echo "🎉 Setup complete! Your frontend is now configured for testnet."
