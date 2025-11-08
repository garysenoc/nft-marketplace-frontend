# How to Find Listings

## Method 1: Using the Frontend (Easiest)

1. **Open your marketplace page** in the browser
2. **Check the "Available Listings" section**
3. **Open browser console** (F12 → Console tab) to see:
   - "Querying listings with type: ..."
   - "Found listings: X"

## Method 2: Using Sui CLI

### Query Listings by Type

```bash
# Query all listings of the Listing type
sui client objects \
  --type 0x3a6583266374fe5612c57c7b66309e6b7b90aa63ae2e1f0de9efecce4ace34fb::nft_marketplace::Listing
```

### Query Using RPC (Direct)

```bash
curl -X POST https://fullnode.testnet.sui.io:443 \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 1,
    "method": "suix_queryObjects",
    "params": [{
      "filter": {
        "StructType": "0x3a6583266374fe5612c57c7b66309e6b7b90aa63ae2e1f0de9efecce4ace34fb::nft_marketplace::Listing"
      },
      "options": {
        "showContent": true,
        "showType": true,
        "showOwner": true
      },
      "limit": 100
    }]
  }'
```

## Method 3: Using Sui Explorer

1. **Visit**: https://suiscan.xyz/testnet
2. **Search for your package**: `0x3a6583266374fe5612c57c7b66309e6b7b90aa63ae2e1f0de9efecce4ace34fb`
3. **Look for transactions** that created Listing objects
4. **Check the marketplace object**: `0xe7a5b3a5408c058e3ffad6ab0d60a3e4bc02425e007a0cff8c6ced5f8200db87`

## Method 4: Check Your Own NFTs First

Before listings appear, you need to:
1. **Mint an NFT** (using the frontend or CLI)
2. **List that NFT** for sale

### Using CLI to Mint and List:

```bash
# 1. Mint an NFT
sui client call \
  --package 0x3a6583266374fe5612c57c7b66309e6b7b90aa63ae2e1f0de9efecce4ace34fb \
  --module nft_marketplace \
  --function mint_to_sender \
  --args "My First NFT" "Description" "https://example.com/image.png" \
  --gas-budget 100000000

# 2. Get the NFT ID from the transaction output
# Look for "created" objects with type containing "DevNetNFT"

# 3. List the NFT for sale (replace <NFT_ID> with actual ID)
sui client call \
  --package 0x3a6583266374fe5612c57c7b66309e6b7b90aa63ae2e1f0de9efecce4ace34fb \
  --module nft_marketplace \
  --function list_nft_for_sale \
  --args <NFT_ID> 1000000000 \
  --gas-budget 100000000

# 4. Get the Listing ID from the transaction output
# Look for "created" objects with type containing "Listing"
```

## Method 5: Query Events

Listings are created when `list_nft_for_sale` is called. You can query events:

```bash
# Query events for ListNFTEvent
sui client query-events \
  --package 0x3a6583266374fe5612c57c7b66309e6b7b90aa63ae2e1f0de9efecce4ace34fb
```

## Quick Test Script

Run this to check if any listings exist:

```bash
#!/bin/bash
PACKAGE_ID="0x3a6583266374fe5612c57c7b66309e6b7b90aa63ae2e1f0de9efecce4ace34fb"
LISTING_TYPE="${PACKAGE_ID}::nft_marketplace::Listing"

echo "Querying listings of type: $LISTING_TYPE"
echo ""

curl -s -X POST https://fullnode.testnet.sui.io:443 \
  -H "Content-Type: application/json" \
  -d "{
    \"jsonrpc\": \"2.0\",
    \"id\": 1,
    \"method\": \"suix_queryObjects\",
    \"params\": [{
      \"filter\": {
        \"StructType\": \"$LISTING_TYPE\"
      },
      \"options\": {
        \"showContent\": true,
        \"showType\": true,
        \"showOwner\": true
      },
      \"limit\": 100
    }]
  }" | jq '.result.data | length'

echo " listings found"
```

## Troubleshooting

### "No listings available"
- **Cause**: No listings have been created yet
- **Solution**: Mint an NFT and list it for sale first

### "Error loading listings"
- **Check**: Browser console for specific error
- **Verify**: Listing type is correct in `.env.local`
- **Test**: RPC endpoint is accessible

### Listings Not Showing After Creation
- **Wait**: Listings refresh every 10 seconds
- **Refresh**: Manually refresh the page
- **Check**: Transaction was successful (check explorer)

## Current Configuration

- **Network**: testnet
- **Package ID**: `0x3a6583266374fe5612c57c7b66309e6b7b90aa63ae2e1f0de9efecce4ace34fb`
- **Listing Type**: `0x3a6583266374fe5612c57c7b66309e6b7b90aa63ae2e1f0de9efecce4ace34fb::nft_marketplace::Listing`
- **Marketplace**: `0xe7a5b3a5408c058e3ffad6ab0d60a3e4bc02425e007a0cff8c6ced5f8200db87`

