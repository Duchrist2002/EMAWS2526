# UniBudget — Roadmap to a Complete App

A phased plan to grow the current prototype into a full budget tracker.
Each phase is shippable on its own. Effort tags: 🟢 small · 🟡 medium · 🔴 large.

---

## ✅ Phase 0 — Done (branch `feature/auth-darkmode-i18n`)
- Firebase Authentication wired in (email + password) with a **local demo-mode
  fallback** so the app runs before a Firebase project is connected.
- `AuthGate` routes by auth state; real **logout**.
- **Dark mode** with a switch (light/dark `ThemeData` + `ThemeController`).
- All UI copy **translated to English**.
- Wired the previously-unused `BudgetSummaryCard`, `TransactionItem` and
  `mockTransactions` into the dashboard; removed the broken `/login` `/register`
  navigation.

---

## Phase 1 — Finish authentication 🟡
- [ ] Run `flutterfire configure`; enable **Email/Password** in the Firebase console.
- [ ] **Password reset** via `sendPasswordResetEmail` (currently a "coming soon" toast).
- [ ] **Email verification** after sign-up.
- [ ] **Profile**: show/edit display name + avatar; change password.
- [ ] Optional: **Google sign-in**.

## Phase 2 — Real data layer (Cloud Firestore) 🔴
- [ ] Add `cloud_firestore`; collection `users/{uid}/transactions`.
- [ ] Extend `TransactionModel`: `toMap`/`fromMap`, `type` (income/expense), currency.
- [ ] **CRUD** for transactions; stream them live into the dashboard.
- [ ] Enable offline persistence.
- [ ] Replace `mockTransactions` everywhere with the Firestore stream.

## Phase 3 — Core budgeting 🔴  *(fills the commented-out routes)*
- [ ] **Add Expense / Income** screen → the `/add-expense` route (amount, category, date, note).
- [ ] **Categories**: manage icons/colors + a per-category budget.
- [ ] **Monthly budget & savings goal** that persist (the `$800` / `$220` become real).
- [ ] Balance = income − expenses; remaining-budget progress bars.
- [ ] Recurring transactions.

## Phase 4 — Insights & statistics 🟡  → `/statistics`
- [ ] Real charts with `fl_chart` (spending-by-category pie, monthly trend) — replaces the placeholder bars.
- [ ] Filters by month / category / date range; budget-vs-actual.
- [ ] Export to CSV / PDF.

## Phase 5 — History & search 🟡  → `/history`
- [ ] Full transaction history grouped by day/month.
- [ ] Search + filter; pagination / infinite scroll.

## Phase 6 — Settings & localization 🟡  → `/settings`
- [ ] **Persist the theme choice** (`shared_preferences`) — it currently resets on reload.
- [ ] Proper i18n with `flutter_localizations` + ARB files (real EN/DE/FR, not mixed strings).
- [ ] Currency selection; local notifications / reminders.
- [ ] Delete account / reset data.

## Phase 7 — Quality & release 🟡
- [ ] State management (`provider` or `riverpod`) as the app grows.
- [ ] Unit + widget + integration tests; empty/loading/error states everywhere.
- [ ] CI (GitHub Actions: `flutter analyze` + `flutter test` + build).
- [ ] App icon + splash (`flutter_launcher_icons`, `flutter_native_splash`).

---

### Suggested order
**1 → 2 → 3** delivers a genuinely usable app (real accounts + real, editable
transactions + budgets). **4 → 5 → 6 → 7** turn it into a polished product.
