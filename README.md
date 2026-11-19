# AnyDesk Reset Utility

A lightweight Windows batch script to **completely reset AnyDesk to its factory state**, clearing all stored credentials, session tokens, pairing data, and configuration files. Useful for IT support, security audits, red team engagements (within authorized scope), and client handovers.

> 🔐 **Author**: Krasimir Uzun

---

## ✅ Purpose

AnyDesk retains persistent identifiers and authentication data that can:
- Reset Anydesk Trail
- Reset Anydesk Time
- Reset Anydesk

This script ensures a **full reset**, forcing AnyDesk to generate a **new unique ID** on next launch—effectively breaking all prior trust relationships.

---

## 🛠 Features

- Stops AnyDesk service and processes gracefully
- Deletes all configs from `%ProgramData%` and `%APPDATA%`
- Optional backup of old configuration (timestamped)
- Silent reinitialization to regenerate default files
- Requires **Administrator privileges** (enforced)
- Leaves no residual session artifacts

---

## ▶️ Usage

1. **Right-click** → *Run as Administrator*
2. Wait for completion (~5 seconds)
3. Launch AnyDesk normally — it will behave like a fresh install

> 💡 Tip: Deploy via GPO, Intune, or endpoint management tools for enterprise-wide cleanup.


