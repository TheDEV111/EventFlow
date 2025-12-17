#!/bin/bash

# EventFlow Testnet Deployment Script

echo "🚀 EventFlow Smart Contracts - Testnet Deployment"
echo "=================================================="
echo ""

# Get deployer address from Testnet.toml
DEPLOYER_ADDRESS="STVQ61FEWR6M4HVAT3BNE07D4BNW6A1C2BKDND68"

echo "📍 Deployer Address: $DEPLOYER_ADDRESS"
echo ""

# Check balance
echo "💰 Checking testnet STX balance..."
BALANCE=$(curl -s "https://api.testnet.hiro.so/extended/v1/address/$DEPLOYER_ADDRESS/stx" | grep -o '"balance":"[^"]*"' | cut -d'"' -f4)

if [ -z "$BALANCE" ]; then
    echo "❌ Could not fetch balance. Check your internet connection."
    exit 1
fi

# Convert from microSTX to STX
STX_BALANCE=$(echo "scale=6; $BALANCE / 1000000" | bc)
echo "✅ Current Balance: $STX_BALANCE STX ($BALANCE microSTX)"
echo ""

# Estimate deployment cost (from the deployment plan)
ESTIMATED_COST=370000  # microSTX (sum of all contract costs: 100k + 120k + 150k)
ESTIMATED_STX=$(echo "scale=2; $ESTIMATED_COST / 1000000" | bc)

echo "📊 Estimated Deployment Cost: ~$ESTIMATED_STX STX"
echo ""

if [ "$BALANCE" -lt "$ESTIMATED_COST" ]; then
    echo "⚠️  WARNING: Insufficient balance for deployment!"
    echo ""
    echo "You need testnet STX to deploy. Get free testnet STX from:"
    echo "🔗 https://explorer.hiro.so/sandbox/faucet?chain=testnet"
    echo ""
    echo "Steps:"
    echo "1. Visit the faucet URL above"
    echo "2. Enter your address: $DEPLOYER_ADDRESS"
    echo "3. Request STX (you'll receive 500 STX)"
    echo "4. Wait ~10 minutes for the transaction to confirm"
    echo "5. Run this script again"
    echo ""
    read -p "Do you want to open the faucet in your browser? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        xdg-open "https://explorer.hiro.so/sandbox/faucet?chain=testnet" 2>/dev/null || \
        open "https://explorer.hiro.so/sandbox/faucet?chain=testnet" 2>/dev/null || \
        echo "Please manually visit: https://explorer.hiro.so/sandbox/faucet?chain=testnet"
    fi
    exit 1
fi

echo "✅ Sufficient balance for deployment!"
echo ""
echo "📋 Deployment Plan:"
echo "  - workflow-registry.clar"
echo "  - event-processor.clar"
echo "  - subscription-manager.clar"
echo ""
echo "⚙️  Network: Testnet"
echo "🔗 API: https://api.testnet.hiro.so"
echo ""

read -p "🚀 Ready to deploy? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    echo "🔄 Deploying contracts to testnet..."
    echo ""
    
    clarinet deployments apply -p deployments/default.testnet-plan.yaml
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "🎉 Deployment successful!"
        echo ""
        echo "📍 Your contracts are now live on testnet!"
        echo "🔍 View on explorer:"
        echo "   https://explorer.hiro.so/address/$DEPLOYER_ADDRESS?chain=testnet"
        echo ""
        echo "📝 Contract Addresses:"
        echo "   workflow-registry: $DEPLOYER_ADDRESS.workflow-registry"
        echo "   event-processor: $DEPLOYER_ADDRESS.event-processor"
        echo "   subscription-manager: $DEPLOYER_ADDRESS.subscription-manager"
        echo ""
    else
        echo ""
        echo "❌ Deployment failed. Check the error messages above."
        echo ""
    fi
else
    echo "Deployment cancelled."
    exit 0
fi
