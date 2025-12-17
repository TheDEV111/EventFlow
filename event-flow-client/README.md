# EventFlow Frontend

![EventFlow](https://img.shields.io/badge/EventFlow-Blockchain_Automation-blue?style=for-the-badge)
![Next.js](https://img.shields.io/badge/Next.js-15.5-black?style=for-the-badge&logo=next.js)
![Stacks](https://img.shields.io/badge/Stacks-Mainnet-purple?style=for-the-badge)

**🚀 Event-driven blockchain automation platform built on Stacks**

## ✨ Features

- **Workflow Management**: Create, edit, and manage blockchain event workflows
- **Real-time Event Monitoring**: Live event tracking via Chainhooks integration  
- **Subscription System**: Tiered plans with STX payments
- **Beautiful UI**: Modern interface with Framer Motion animations
- **Smart Contract Integration**: Direct integration with mainnet contracts
- **Responsive Design**: Works on desktop and mobile

## 🛠️ Tech Stack

- **Next.js 15.5** - React framework with App Router
- **TypeScript** - Type-safe development
- **Tailwind CSS 4.0** - Utility-first styling
- **shadcn/ui** - Beautiful component library
- **Framer Motion** - Smooth animations
- **Stacks blockchain** - Mainnet deployed contracts
- **Chainhooks** - Real-time event streaming

## 🚀 Quick Start

```bash
# Install dependencies
pnpm install

# Run development server
pnpm dev

# Open http://localhost:3000
```

## 🔧 Environment Setup

Create `.env.local`:

```env
NEXT_PUBLIC_APP_NAME=EventFlow
NEXT_PUBLIC_STACKS_NETWORK=mainnet
NEXT_PUBLIC_CONTRACT_ADDRESS=SPVQ61FEWR6M4HVAT3BNE07D4BNW6A1C2ACCNQ6F
NEXT_PUBLIC_WORKFLOW_REGISTRY=workflow-registry
NEXT_PUBLIC_EVENT_PROCESSOR=event-processor
NEXT_PUBLIC_SUBSCRIPTION_MANAGER=subscription-manager
```

## 📁 Project Structure

```
event-flow-client/
├── app/                    # Next.js pages
│   ├── layout.tsx         # Root layout
│   ├── page.tsx           # Dashboard
│   └── globals.css        # Global styles
├── components/            # React components
│   ├── logo.tsx          # EventFlow logo
│   ├── workflow-card.tsx # Workflow cards
│   ├── event-item.tsx    # Event items
│   └── subscription-card.tsx # Plans
├── lib/                  # Utilities
│   ├── contracts.ts      # Contract functions
│   └── types.ts          # TypeScript types
└── providers/            # Context providers
    ├── chainhook-provider.tsx
    └── auth-session-provider.tsx
```

## 🎯 Smart Contracts

### Mainnet Contracts
```
Address: SPVQ61FEWR6M4HVAT3BNE07D4BNW6A1C2ACCNQ6F

- workflow-registry      (Workflow management)
- event-processor        (Event processing)
- subscription-manager   (Subscriptions & credits)
```

### Contract Functions

**Workflow Registry**
- `register-workflow` - Create workflow (10 STX)
- `update-workflow` - Update details (5 STX)
- `toggle-workflow-status` - Enable/disable (1 STX)
- `unlock-premium` - Premium features (50 STX)

**Event Processor**
- `process-event` - Process single event (0.1 STX)
- `batch-process-events` - Process multiple (0.05 STX each)
- `add-action` - Add workflow action (5 STX)

**Subscription Manager**
- `subscribe` - Subscribe to tier (20-100 STX)
- `purchase-credits` - Buy credits (0.001 STX each)
- `transfer-credits` - Transfer to another user

## 💎 Subscription Tiers

| Tier | Price | Events | Features |
|------|-------|--------|----------|
| **Starter** | 20 STX | 1,000/mo | Basic workflows, Email notifications |
| **Pro** ⭐ | 50 STX | 5,000/mo | Premium workflows, Priority support, API |
| **Enterprise** | 100 STX | 20,000/mo | Unlimited workflows, 24/7 support, SLA |

## 🎨 Design System

### Color Palette
- Primary: `#3b82f6` (Blue)
- Secondary: `#a855f7` (Purple)  
- Accent: `#ec4899` (Pink)
- Success: `#22c55e` (Green)
- Warning: `#eab308` (Yellow)
- Error: `#ef4444` (Red)

### Animations
- Page transitions with stagger effects
- Hover lift on cards
- Pulsing status indicators
- Smooth gradient animations

## 🔌 Chainhooks Integration

Real-time blockchain event monitoring:

```typescript
import { useChainhooks } from "@/providers/chainhook-provider";

function MyComponent() {
  const { events, subscribeToWorkflow } = useChainhooks();
  
  useEffect(() => {
    subscribeToWorkflow(workflowId);
  }, [workflowId]);
  
  return events.map(event => <EventItem event={event} />);
}
```

## 🧪 Development

```bash
# Development
pnpm dev

# Build
pnpm build

# Production
pnpm start

# Lint
pnpm lint

# Format
pnpm format
```

## 🚀 Deployment

### Vercel (Recommended)
```bash
vercel
```

### Environment Variables
Set all `NEXT_PUBLIC_*` variables in your deployment platform.

## 📱 Responsive Breakpoints

- **Desktop**: 1920px+
- **Laptop**: 1280px - 1920px
- **Tablet**: 768px - 1280px
- **Mobile**: 320px - 768px

## 🔐 Security

- ✅ No private keys stored
- ✅ Wallet signature required for transactions
- ✅ Read-only functions for public data
- ✅ Environment variables for config
- ✅ HTTPS only in production

## 📚 Resources

- [Stacks Docs](https://docs.stacks.co)
- [Next.js Docs](https://nextjs.org/docs)
- [shadcn/ui](https://ui.shadcn.com)
- [Framer Motion](https://www.framer.com/motion)

## 🤝 Contributing

1. Fork the repo
2. Create feature branch (`git checkout -b feature/amazing`)
3. Commit changes (`git commit -m 'Add feature'`)
4. Push branch (`git push origin feature/amazing`)
5. Open Pull Request

## 📄 License

MIT License - see LICENSE file

## 🔗 Links

- **Explorer**: [View Contracts](https://explorer.hiro.so/address/SPVQ61FEWR6M4HVAT3BNE07D4BNW6A1C2ACCNQ6F?chain=mainnet)
- **GitHub**: [EventFlow Repo](https://github.com/TheDEV111/EventFlow)

---

**Built with ❤️ on Stacks • EventFlow © 2025**
