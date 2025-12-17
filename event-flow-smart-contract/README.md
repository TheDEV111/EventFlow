# EventFlow Smart Contracts

**Real-Time Stacks Blockchain Event Platform**

This repository contains the smart contracts for EventFlow, a comprehensive real-time blockchain event monitoring and automation platform built on the Stacks blockchain using Clarity 3.0.

## 📋 Overview

EventFlow enables users to create sophisticated "if-this-then-that" workflows that react to on-chain Stacks events instantly, powering notifications, analytics dashboards, automated trading strategies, and cross-platform integrations.

### Key Features

- ✅ **Workflow Registry**: Register and manage event-driven workflows
- ✅ **Event Processing**: Process blockchain events with rate limiting and analytics
- ✅ **Subscription Management**: Tiered subscriptions with credit-based billing
- ✅ **Premium Features**: Unlimited workflows and advanced capabilities
- ✅ **Marketplace Ready**: Transfer and sell workflows
- ✅ **Referral System**: Earn rewards by referring new users

## 🏗️ Architecture

The platform consists of three core smart contracts:

### 1. Workflow Registry (`workflow-registry.clar`)

Central registry for user-created workflows with access control and metadata management.

**Key Functions:**
- `register-workflow`: Create a new workflow (10 STX fee)
- `update-workflow`: Modify workflow configuration (2 STX fee)
- `transfer-workflow`: Transfer ownership with 5% platform fee
- `toggle-visibility`: Change public/private status (1 STX fee)
- `unlock-premium`: Unlock unlimited workflows (50 STX)
- `delete-workflow`: Deactivate a workflow

**Features:**
- Free tier: 5 workflows maximum
- Premium tier: Unlimited workflows
- Public/private visibility control
- Ownership transfer with marketplace support
- Versioning and statistics tracking

### 2. Event Processor (`event-processor.clar`)

Processes Chainhook payloads, validates events, and triggers automated actions.

**Key Functions:**
- `process-event`: Process single event (0.1 STX, +0.05 STX for priority)
- `batch-process-events`: Process up to 50 events (0.05 STX each)
- `execute-contract-call`: Trigger on-chain actions (1 STX)
- `execute-token-transfer`: Automated token transfers
- `trigger-webhook`: Record webhook execution (0.01 STX)
- `set-rate-limit`: Configure per-workflow rate limits

**Features:**
- Duplicate event prevention via SHA256 hashing
- Rate limiting (configurable per workflow)
- Batch processing for efficiency
- Retry queue for failed events
- Comprehensive action logging
- Real-time statistics tracking

### 3. Subscription Manager (`subscription-manager.clar`)

Manages user subscriptions, credits, and billing for event processing.

**Key Functions:**
- `subscribe`: Subscribe to Pro or Enterprise tier
- `renew-subscription`: Extend subscription with auto-renewal option
- `upgrade-subscription`: Upgrade tier (1 STX fee + price difference)
- `cancel-subscription`: Cancel with 30% penalty on remaining value
- `purchase-credits`: Buy credit packages (discounts for bulk)
- `transfer-credits`: Transfer credits to other users
- `generate-referral-code`: Create referral code (10% reward)

**Subscription Tiers:**

| Tier | Cost | Events/Month | Workflows | Features |
|------|------|--------------|-----------|----------|
| Free | 0 STX | 100 | 5 | Basic |
| Pro | 20 STX | 10,000 | Unlimited | Advanced |
| Enterprise | 100 STX | Unlimited | Unlimited | All + SLA |

**Credit Packages:**
- Small: 1,000 events = 5 STX
- Medium: 10,000 events = 40 STX (20% discount)
- Large: 100,000 events = 300 STX (40% discount)

## 🚀 Getting Started

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) v2.0+
- Node.js v18+
- npm or yarn

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd event-flow-smart-contract

# Install dependencies
npm install

# Check contracts
clarinet check

# Run tests
npm test
```

### Testing

The project includes comprehensive test suites for all three contracts:

```bash
# Run all tests
npm test

# Run specific test file
npm test workflow-registry.test.ts
npm test event-processor.test.ts
npm test subscription-manager.test.ts
```

### Deployment

```bash
# Deploy to devnet
clarinet integrate

# Deploy to testnet
clarinet deployments apply -p deployments/testnet.yaml

# Deploy to mainnet
clarinet deployments apply -p deployments/mainnet.yaml
```

## 📊 Revenue Model

### Projected Annual Revenue (Year 1)

**Subscription Revenue:**
- Pro: 1,000 users × 20 STX/month × 12 = 240,000 STX
- Enterprise: 50 users × 100 STX/month × 12 = 60,000 STX
- **Total: 300,000 STX**

**Transaction Fees:**
- Workflow registrations: 20,000 STX
- Workflow updates: 10,000 STX
- Event processing (Free): 100,000 STX
- Event processing (Pro): 1,000,000 STX
- Credit packages: 240,000 STX
- **Total: 1,370,000 STX**

**Marketplace:**
- Template sales: 2,500 STX
- Custom integrations: 10,000 STX
- **Total: 12,500 STX**

### **Total Projected Revenue: ~1,682,500 STX/year**
**At $1.50/STX ≈ $2,523,750 USD annually**

## 🔒 Security Features

- ✅ **Access Control**: Owner-only functions with principal verification
- ✅ **Input Validation**: All user inputs validated before processing
- ✅ **Reentrancy Protection**: Safe STX transfer patterns
- ✅ **Rate Limiting**: Prevent abuse and spam
- ✅ **Duplicate Prevention**: SHA256 hashing for event deduplication
- ✅ **Fee Collection**: All fees properly tracked and collected

## 🛠️ Clarity Features Used

This project leverages Clarity 3.0-4.0 features including:

- ✅ `string-utf8` for efficient text storage
- ✅ `buff` operations for binary data handling
- ✅ `principal` operations for access control
- ✅ `stacks-block-height` for timestamp tracking
- ✅ Advanced map operations with `merge` and `default-to`
- ✅ List operations with `fold` and `filter`
- ✅ Optional types for flexible parameters
- ✅ Comprehensive error handling with custom error codes

## 📝 Contract Specifications

### Error Codes

**Workflow Registry (100-199)**
- `u100`: Owner only
- `u101`: Not found
- `u102`: Unauthorized
- `u103`: Already exists
- `u104`: Invalid price
- `u105`: Insufficient funds
- `u106`: Invalid name
- `u107`: Invalid description
- `u108`: Workflow limit reached
- `u109`: Not premium

**Event Processor (200-299)**
- `u200`: Owner only
- `u201`: Not found
- `u202`: Unauthorized
- `u203`: Invalid payload
- `u204`: Insufficient credits
- `u205`: Rate limit exceeded
- `u206`: Workflow inactive
- `u207`: Duplicate event
- `u208`: Invalid signature
- `u209`: Batch too large

**Subscription Manager (300-399)**
- `u300`: Owner only
- `u301`: Not found
- `u302`: Unauthorized
- `u303`: Insufficient balance
- `u304`: Invalid tier
- `u305`: Invalid duration
- `u306`: Already subscribed
- `u307`: Not subscribed
- `u308`: Invalid amount
- `u309`: Subscription active
- `u310`: Invalid referral

## 🧪 Test Coverage

All contracts include comprehensive test suites covering:

- ✅ Success cases for all public functions
- ✅ Error cases and edge conditions
- ✅ Access control validation
- ✅ Fee calculation verification
- ✅ State transitions and data integrity
- ✅ Integration scenarios
- ✅ Rate limiting enforcement
- ✅ Referral system mechanics

## 🤝 Contributing

Contributions are welcome! Please ensure:

1. All tests pass: `npm test`
2. Contracts pass clarinet check: `clarinet check`
3. Code follows Clarity best practices
4. New features include tests

## 📄 License

[Add your license here]

## 🔗 Links

- [Hiro Platform Documentation](https://docs.hiro.so/)
- [Clarity Language Reference](https://docs.stacks.co/clarity/)
- [Chainhooks Documentation](https://docs.hiro.so/chainhooks/)

## 🎯 Roadmap

- [x] Core smart contracts implementation
- [x] Comprehensive test suites
- [x] Clarinet compliance
- [ ] Frontend integration
- [ ] Chainhook integration
- [ ] API backend development
- [ ] Mainnet deployment
- [ ] Marketplace launch

## 📧 Support

For support, please open an issue in the GitHub repository or contact the development team.

---

**Built with ❤️ on Stacks using Clarity**
