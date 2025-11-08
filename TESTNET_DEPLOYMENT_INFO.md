# Testnet Deployment Information

## ✅ Deployment Successful!

**Transaction Digest**: `ExBspCDteYAXmVpUUFqRRHJdMX6JG5cYzRVrJuLAVw93`  
**Network**: `testnet`  
**Deployed Date**: 2025-01-07

## Contract Information

### Package ID
```
0x3a6583266374fe5612c57c7b66309e6b7b90aa63ae2e1f0de9efecce4ace34fb
```

### Module Name
```
nft_marketplace
```

### Marketplace Object ID
```
0xe7a5b3a5408c058e3ffad6ab0d60a3e4bc02425e007a0cff8c6ced5f8200db87
```

### Admin Address
```
0xd521a7c075dc422222bca144bcf21291b1f80fdff404603f02564dfccd880e69
```

## Type Strings

### NFT Type
```
0x3a6583266374fe5612c57c7b66309e6b7b90aa63ae2e1f0de9efecce4ace34fb::nft_marketplace::DevNetNFT
```

### Listing Type
```
0x3a6583266374fe5612c57c7b66309e6b7b90aa63ae2e1f0de9efecce4ace34fb::nft_marketplace::Listing
```

### Marketplace Type
```
0x3a6583266374fe5612c57c7b66309e6b7b90aa63ae2e1f0de9efecce4ace34fb::nft_marketplace::Marketplace
```

## Explorer Links

- **Transaction**: https://suiscan.xyz/testnet/tx/ExBspCDteYAXmVpUUFqRRHJdMX6JG5cYzRVrJuLAVw93
- **Package**: https://suiscan.xyz/testnet/object/0x3a6583266374fe5612c57c7b66309e6b7b90aa63ae2e1f0de9efecce4ace34fb
- **Marketplace**: https://suiscan.xyz/testnet/object/0xe7a5b3a5408c058e3ffad6ab0d60a3e4bc02425e007a0cff8c6ced5f8200db87

## Example Usage Commands

### Mint an NFT
```bash
sui client call \
  --package 0x3a6583266374fe5612c57c7b66309e6b7b90aa63ae2e1f0de9efecce4ace34fb \
  --module nft_marketplace \
  --function mint_to_sender \
  --args "My NFT" "Description" "https://example.com/image.png" \
  --gas-budget 100000000
```

### List NFT for Sale
```bash
sui client call \
  --package 0x3a6583266374fe5612c57c7b66309e6b7b90aa63ae2e1f0de9efecce4ace34fb \
  --module nft_marketplace \
  --function list_nft_for_sale \
  --args <NFT_ID> 1000000000 \
  --gas-budget 100000000
```

### Buy NFT
```bash
sui client call \
  --package 0x3a6583266374fe5612c57c7b66309e6b7b90aa63ae2e1f0de9efecce4ace34fb \
  --module nft_marketplace \
  --function buy_nft \
  --args <LISTING_ID> <PAYMENT_COIN_ID> 0xe7a5b3a5408c058e3ffad6ab0d60a3e4bc02425e007a0cff8c6ced5f8200db87 \
  --gas-budget 100000000
```

## Status

✅ Contract deployed to testnet  
✅ .env.local updated with testnet values  
✅ Frontend configured for testnet  
✅ Ready to use!

