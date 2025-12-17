#!/bin/bash

# ⚠️  CRITICAL MAINNET DEPLOYMENT SCRIPT ⚠️
# DO NOT RUN THIS WITHOUT COMPLETING THE PRE-DEPLOYMENT CHECKLIST

echo "════════════════════════════════════════════════════════════"
echo "   ⚠️  EVENTFLOW MAINNET DEPLOYMENT - PRODUCTION ⚠️"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "🛑 STOP! Read this carefully before proceeding:"
echo ""
echo "This script will deploy contracts to MAINNET using REAL STX."
echo "Once deployed, contracts CANNOT be modified or upgraded."
echo ""
echo "════════════════════════════════════════════════════════════"
echo ""

# Pre-deployment checklist
echo "📋 PRE-DEPLOYMENT CHECKLIST:"
echo ""
echo "Have you completed ALL of the following?"
echo ""
echo "  [ ] 1. Security audit completed by professional auditors"
echo "  [ ] 2. All contracts tested thoroughly on testnet"
echo "  [ ] 3. Integration tests passed with frontend/backend"
echo "  [ ] 4. Generated NEW secure wallet (NOT testnet keys)"
echo "  [ ] 5. Backed up wallet mnemonic securely"
echo "  [ ] 6. Funded mainnet wallet with sufficient STX (>1000 STX)"
echo "  [ ] 7. Updated Mainnet.toml with new wallet mnemonic"
echo "  [ ] 8. Tested deployment process on testnet first"
echo "  [ ] 9. Team review and approval obtained"
echo "  [ ] 10. Monitoring and incident response plan ready"
echo ""
echo "════════════════════════════════════════════════════════════"
echo ""

read -p "⚠️  Have you completed ALL items above? (type 'YES' to continue): " CONFIRM

if [ "$CONFIRM" != "YES" ]; then
    echo ""
    echo "❌ Deployment cancelled. Please complete the checklist first."
    echo ""
    echo "📚 See MAINNET_DEPLOYMENT_GUIDE.md for detailed instructions."
    exit 1
fi

echo ""
echo "════════════════════════════════════════════════════════════"
echo ""

# Security check - ensure wallet is configured
echo "🔐 Verifying wallet configuration..."
MAINNET_MNEMONIC=$(grep -A1 '\[accounts.deployer\]' settings/Mainnet.toml | grep 'mnemonic' | cut -d'"' -f2)

if [ -z "$MAINNET_MNEMONIC" ]; then
    echo ""
    echo "🛑 ERROR: No mnemonic found in Mainnet.toml"
    echo ""
    echo "Please add your wallet mnemonic to settings/Mainnet.toml"
    echo ""
    exit 1
fi

echo "✅ Wallet configuration verified"
echo ""

# Generate mainnet deployment plan
echo "📝 Generating mainnet deployment plan..."
clarinet deployments generate --mainnet --low-cost

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ Failed to generate deployment plan"
    exit 1
fi

echo "✅ Deployment plan generated"
echo ""

# Check deployment plan
echo "🔍 Validating deployment plan..."
clarinet deployments check

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ Deployment plan validation failed"
    exit 1
fi

echo "✅ Deployment plan validated"
echo ""

# Get deployer address (this is a placeholder - actual address will be from new wallet)
echo "📍 Retrieving deployer address..."
# You'll need to extract this from the deployment plan or calculate from mnemonic
echo ""
echo "⚠️  Manual step required:"
echo "Please verify your deployer address from the deployment plan"
echo ""

read -p "Enter your MAINNET deployer address: " DEPLOYER_ADDRESS

if [ -z "$DEPLOYER_ADDRESS" ]; then
    echo "❌ Deployer address required"
    exit 1
fi

echo ""
echo "📍 Deployer Address: $DEPLOYER_ADDRESS"
echo ""

# Check mainnet balance
echo "💰 Checking mainnet STX balance..."
BALANCE=$(curl -s "https://api.hiro.so/extended/v1/address/$DEPLOYER_ADDRESS/stx" | grep -o '"balance":"[^"]*"' | cut -d'"' -f4)

if [ -z "$BALANCE" ]; then
    echo "❌ Could not fetch balance. Check your internet connection or address."
    exit 1
fi

STX_BALANCE=$(echo "scale=6; $BALANCE / 1000000" | bc)
echo "✅ Current Balance: $STX_BALANCE STX ($BALANCE microSTX)"
echo ""

# Estimate deployment cost
ESTIMATED_COST=500000  # ~0.5 STX estimated
ESTIMATED_STX=$(echo "scale=2; $ESTIMATED_COST / 1000000" | bc)

echo "📊 Estimated Deployment Cost: ~$ESTIMATED_STX STX"
echo ""

if [ "$BALANCE" -lt "$ESTIMATED_COST" ]; then
    echo "⚠️  WARNING: Insufficient balance for deployment!"
    echo ""
    echo "Required: ~$ESTIMATED_STX STX"
    echo "Current: $STX_BALANCE STX"
    echo ""
    echo "Please fund your mainnet wallet before proceeding."
    exit 1
fi

# Show deployment summary
echo "════════════════════════════════════════════════════════════"
echo "📋 DEPLOYMENT SUMMARY"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "Network:              Stacks Mainnet"
echo "API:                  https://api.hiro.so"
echo "Deployer:             $DEPLOYER_ADDRESS"
echo "Balance:              $STX_BALANCE STX"
echo "Estimated Cost:       ~$ESTIMATED_STX STX"
echo ""
echo "Contracts to Deploy:"
echo "  1. workflow-registry.clar"
echo "  2. event-processor.clar"
echo "  3. subscription-manager.clar"
echo ""
echo "════════════════════════════════════════════════════════════"
echo ""
echo "⚠️  FINAL WARNING:"
echo ""
echo "Once deployed, these contracts CANNOT be modified."
echo "All functions will be immutable and permanent."
echo "Ensure you have tested everything thoroughly."
echo ""
echo "════════════════════════════════════════════════════════════"
echo ""

read -p "🚀 Type 'DEPLOY NOW' to proceed with mainnet deployment: " FINAL_CONFIRM

if [ "$FINAL_CONFIRM" != "DEPLOY NOW" ]; then
    echo ""
    echo "❌ Deployment cancelled."
    exit 0
fi

echo ""
echo "════════════════════════════════════════════════════════════"
echo "🚀 DEPLOYING TO MAINNET..."
echo "════════════════════════════════════════════════════════════"
echo ""

# Apply deployment
clarinet deployments apply -p deployments/default.mainnet-plan.yaml

if [ $? -eq 0 ]; then
    echo ""
    echo "════════════════════════════════════════════════════════════"
    echo "🎉 MAINNET DEPLOYMENT SUCCESSFUL!"
    echo "════════════════════════════════════════════════════════════"
    echo ""
    echo "📍 Your contracts are now LIVE on MAINNET!"
    echo ""
    echo "🔍 View on explorer:"
    echo "   https://explorer.hiro.so/address/$DEPLOYER_ADDRESS?chain=mainnet"
    echo ""
    echo "📝 Contract Addresses:"
    echo "   workflow-registry:      $DEPLOYER_ADDRESS.workflow-registry"
    echo "   event-processor:        $DEPLOYER_ADDRESS.event-processor"
    echo "   subscription-manager:   $DEPLOYER_ADDRESS.subscription-manager"
    echo ""
    echo "════════════════════════════════════════════════════════════"
    echo ""
    echo "📋 IMMEDIATE POST-DEPLOYMENT TASKS:"
    echo ""
    echo "  1. Verify all contracts on explorer"
    echo "  2. Test read-only functions"
    echo "  3. Update frontend with mainnet addresses"
    echo "  4. Configure monitoring and alerts"
    echo "  5. Announce launch to community"
    echo "  6. Document deployment details"
    echo ""
    echo "════════════════════════════════════════════════════════════"
    echo ""
    
    # Save deployment info
    echo "💾 Saving deployment information..."
    cat > MAINNET_DEPLOYMENT_INFO.txt << EOF
EventFlow Mainnet Deployment
============================

Deployment Date: $(date)
Deployer Address: $DEPLOYER_ADDRESS

Contract Addresses:
- workflow-registry: $DEPLOYER_ADDRESS.workflow-registry
- event-processor: $DEPLOYER_ADDRESS.event-processor
- subscription-manager: $DEPLOYER_ADDRESS.subscription-manager

Explorer: https://explorer.hiro.so/address/$DEPLOYER_ADDRESS?chain=mainnet

Cost: ~$ESTIMATED_STX STX
Remaining Balance: Check explorer

Status: DEPLOYED ✅
EOF
    
    echo "✅ Deployment info saved to MAINNET_DEPLOYMENT_INFO.txt"
    echo ""
    
else
    echo ""
    echo "════════════════════════════════════════════════════════════"
    echo "❌ MAINNET DEPLOYMENT FAILED"
    echo "════════════════════════════════════════════════════════════"
    echo ""
    echo "Please check the error messages above."
    echo "Do NOT proceed with mainnet operations until issues are resolved."
    echo ""
    echo "For support:"
    echo "  - Review deployment logs"
    echo "  - Check deployer balance"
    echo "  - Verify network connectivity"
    echo "  - Consult Clarinet documentation"
    echo ""
fi
