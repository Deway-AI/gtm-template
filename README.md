# Deway Web SDK — Google Tag Manager template

The official **Google Tag Manager custom template** for the
[Deway Web SDK](https://www.deway.ai) — the autonomous adoption layer that adds an
AI-powered user-assistance engine to your product. Install and configure Deway
entirely from your GTM container, with **no changes to your app bundle**.

This repository exists to publish the template to the **Community Template Gallery**,
where you can add it directly from inside GTM (**Templates → Search Gallery → "Deway
Web SDK"**) — no file import required.

## What it does

A single **multi-action tag** driven by a top-level **Command** selector — one
template, one tag per action, so you can map your own GTM triggers to Deway actions
(most importantly, mapping a trigger to a Deway event via **Report event**).

| Command | Purpose |
|---------|---------|
| **Initialize** | Install Deway (`Deway.init`) + optional identify / set profile. Injects the loader. |
| **Identify user** | `Deway.identify(userId)` |
| **Set user profile** | `Deway.setUserProfile(profile)` |
| **Report event** | `Deway.reportEvent(name, params)` — wire a GTM trigger to a Deway event |
| **Open chat** | `Deway.openChat(prompt?)` |
| **Show widget** | `Deway.show({ appearanceMode? })` |
| **Hide widget** | `Deway.hide()` |
| **Reset user (local)** | `Deway.resetUserLocally()` |

Add one **Initialize** tag on *All Pages*, then add more command tags wired to your
own triggers. The loader ships a command queue, so a command tag that fires before
`Deway.init()` finishes is queued and replayed automatically.

## Data layer

User ID, User Profile, and Event Params are read from the GTM data layer under the
**`deway.` namespace** — e.g. `deway.userId`, `deway.userProfile`, `deway.eventParams`.
Keys outside that namespace are not read.

```js
window.dataLayer.push({
  'deway.userId': 'user-123',
  'deway.userProfile': { name: 'Jane Doe', plan: 'pro' }
});
```

## Configuration

Get your **Deway App Key** at https://admin.deway.ai/settings/sdk-setup and enter it
in the **Initialize** tag. Everything else — themes, feature flags, AI prompts — is
managed remotely.

## Licensing

The GTM template in `template.tpl` is licensed under the **Apache License, Version
2.0** (see [`LICENSE`](./LICENSE)). That license covers **only** this template
wrapper. The Deway Web SDK, backend, and product remain proprietary to Deway AI — see
[`NOTICE`](./NOTICE) for the exact scope.

## Links

- Product & docs: https://www.deway.ai
- SDK package: https://www.npmjs.com/package/@deway-ai/web-sdk
