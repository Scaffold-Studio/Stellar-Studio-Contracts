#!/bin/bash
# Quick testnet factory initialization using known WASM hashes
# Run this after WASMs are already uploaded to testnet

set -e

echo "======================================"
echo "Stellar Studio Testnet Factory Init"
echo "======================================"
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
NETWORK="testnet"
ADMIN_IDENTITY="me"  # Use stellar CLI identity
ADMIN_ADDRESS=$(stellar keys address "$ADMIN_IDENTITY")

# Factory addresses
TOKEN_FACTORY="CAHLJEQUCNTV7JPAPCMLCBIHOX7FFB57DUARJ6XGTW27FPCVKKY7JM2A"
NFT_FACTORY="CDJQAGTVOK37NPBWMADBJDGFYM6BEAFV4T45S23D4LQLGSTMRRZ5RQ6X"
GOVERNANCE_FACTORY="CC3SLHSCJHP7YJ462ZIACJ54VOHL5ZFUODZKBTITIZSO74D4YOPR5WCE"

# Known WASM hashes (from deterministic builds)
ALLOWLIST_HASH="bf3f86bc86e664d3feec828d5b893b2ee3098f54168fbb32ffe50def661a31fd"
BLOCKLIST_HASH="86b2c6b032655a60ebf090fe538f1b88c53d26a05c9e816590876c1af888b14b"
CAPPED_HASH="532b882a32197098b16712042fbd9839a1222ad69f3b82cb1a89129b206f7024"
PAUSABLE_HASH="28091881e8fcbecc6bbd3b86167236231a4c4c2f533c76d7f81c61e58497962e"
VAULT_HASH="6ac9c404f901937ba21a8832819ed62355920a0bae54d00391e39b52baeb004d"

ENUMERABLE_HASH="48b00c72210ef86ee355e474399f73c1bb031b18cc601e9025e49571208aa3e7"
ROYALTIES_HASH="9dea1eb23f5316ffa3c103b4d7c7a86c9042f1f836b9c318f888319cb92fde89"
ACCESS_CONTROL_HASH="d4c6b957b9a3ac2b197f3d28bc367d0cdf8a53ea45945271cf7b0f6e14332b83"

MERKLE_VOTING_HASH="8d68abf048659611cd88f23f1050f78507a9a29275b6782faebf837c587aedd8"

echo -e "${BLUE}Initializing Token Factory...${NC}"

stellar contract invoke \
    --id "$TOKEN_FACTORY" \
    --source "$ADMIN_IDENTITY" \
    --network "$NETWORK" \
    -- set_allowlist_wasm \
    --admin "$ADMIN_ADDRESS" \
    --wasm_hash "$ALLOWLIST_HASH"

stellar contract invoke \
    --id "$TOKEN_FACTORY" \
    --source "$ADMIN_IDENTITY" \
    --network "$NETWORK" \
    -- set_blocklist_wasm \
    --admin "$ADMIN_ADDRESS" \
    --wasm_hash "$BLOCKLIST_HASH"

stellar contract invoke \
    --id "$TOKEN_FACTORY" \
    --source "$ADMIN_IDENTITY" \
    --network "$NETWORK" \
    -- set_capped_wasm \
    --admin "$ADMIN_ADDRESS" \
    --wasm_hash "$CAPPED_HASH"

stellar contract invoke \
    --id "$TOKEN_FACTORY" \
    --source "$ADMIN_IDENTITY" \
    --network "$NETWORK" \
    -- set_pausable_wasm \
    --admin "$ADMIN_ADDRESS" \
    --wasm_hash "$PAUSABLE_HASH"

stellar contract invoke \
    --id "$TOKEN_FACTORY" \
    --source "$ADMIN_IDENTITY" \
    --network "$NETWORK" \
    -- set_vault_wasm \
    --admin "$ADMIN_ADDRESS" \
    --wasm_hash "$VAULT_HASH"

echo -e "${GREEN}✅ Token Factory initialized${NC}"
echo ""

echo -e "${BLUE}Initializing NFT Factory...${NC}"

stellar contract invoke \
    --id "$NFT_FACTORY" \
    --source "$ADMIN_IDENTITY" \
    --network "$NETWORK" \
    -- set_enumerable_wasm \
    --admin "$ADMIN_ADDRESS" \
    --wasm_hash "$ENUMERABLE_HASH"

stellar contract invoke \
    --id "$NFT_FACTORY" \
    --source "$ADMIN_IDENTITY" \
    --network "$NETWORK" \
    -- set_royalties_wasm \
    --admin "$ADMIN_ADDRESS" \
    --wasm_hash "$ROYALTIES_HASH"

stellar contract invoke \
    --id "$NFT_FACTORY" \
    --source "$ADMIN_IDENTITY" \
    --network "$NETWORK" \
    -- set_access_control_wasm \
    --admin "$ADMIN_ADDRESS" \
    --wasm_hash "$ACCESS_CONTROL_HASH"

echo -e "${GREEN}✅ NFT Factory initialized${NC}"
echo ""

echo -e "${BLUE}Initializing Governance Factory...${NC}"

stellar contract invoke \
    --id "$GOVERNANCE_FACTORY" \
    --source "$ADMIN_IDENTITY" \
    --network "$NETWORK" \
    -- set_merkle_voting_wasm \
    --admin "$ADMIN_ADDRESS" \
    --wasm_hash "$MERKLE_VOTING_HASH"

echo -e "${GREEN}✅ Governance Factory initialized${NC}"
echo ""

echo -e "${GREEN}======================================"
echo "Testnet Factories Initialized!"
echo "======================================${NC}"
echo ""
echo "All factories are now ready to deploy contracts on testnet!"
