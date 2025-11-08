#!/bin/bash
PACKAGE_ID="0x3a6583266374fe5612c57c7b66309e6b7b90aa63ae2e1f0de9efecce4ace34fb"
LISTING_TYPE="${PACKAGE_ID}::nft_marketplace::Listing"

echo "🔍 Querying listings..."
echo "Type: $LISTING_TYPE"
echo ""

RESULT=$(curl -s -X POST https://fullnode.testnet.sui.io:443 \
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
  }")

COUNT=$(echo "$RESULT" | jq -r '.result.data | length // 0')

if [ "$COUNT" = "0" ]; then
  echo "❌ No listings found"
  echo ""
  echo "💡 To create a listing:"
  echo "   1. Mint an NFT using the frontend or CLI"
  echo "   2. List that NFT for sale"
else
  echo "✅ Found $COUNT listing(s):"
  echo ""
  echo "$RESULT" | jq -r '.result.data[] | "  • Object ID: \(.data.objectId)\n    Price: \(.data.content.fields.price // 0) MIST\n    Seller: \(.data.content.fields.seller)\n"'
fi

