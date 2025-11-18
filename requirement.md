# Cart Modification Feature Requirements

## 1. Feature Description and Purpose

The Cart Modification feature enables users of the Sandwich Shop Flutter app to manage the contents of their cart before checkout. Users can adjust the quantity of each sandwich or remove items. Editing sandwich details (such as bread type or size) is not supported on the cart page; users must add a new item from the order screen if they wish to change sandwich options. This feature aims to provide a flexible and user-friendly shopping experience, ensuring users can easily correct mistakes or change their order without starting over.

---

## 2. User Stories

### 2.1. Adjust Quantity

- **As a user**, I want to increase or decrease the quantity of a sandwich in my cart, so I can order the exact number I want.
- **As a user**, I want the cart to automatically remove an item if I decrease its quantity below 1, so my cart never contains items with zero or negative quantity.

### 2.2. Remove Item

- **As a user**, I want to remove a sandwich from my cart with a single action, so I can quickly update my order if I change my mind.

### 2.3. Feedback and UI Responsiveness

- **As a user**, I want the cart and total price to update immediately when I make changes, so I always see an accurate summary of my order.
- **As a user**, I want to receive feedback (such as a snackbar) when I remove or update an item, so I know my action was successful.
- **As a user**, I want to see a clear message if my cart is empty, so I know I need to add items before checking out.

---

## 3. Acceptance Criteria

### 3.1. Quantity Adjustment

- [x] Each cart item displays "+" and "–" buttons for quantity adjustment.
- [x] Tapping "+" increases the quantity by 1.
- [x] Tapping "–" decreases the quantity by 1.
- [x] If the quantity is reduced below 1, the item is removed from the cart.
- [x] The total price updates automatically and accurately.
- [x] The UI updates immediately to reflect changes.

### 3.2. Remove Item

- [ ] Each cart item has a "Remove" button (e.g., trash icon).
- [ ] Tapping "Remove" deletes the item from the cart.
- [x] The total price updates accordingly.
- [ ] A snackbar or similar feedback is shown when an item is removed.

### 3.3. General UI and Behavior

- [x] All changes are reflected immediately in the UI.
- [x] The cart's total price is always accurate.
- [ ] The cart handles empty states gracefully (e.g., displays a message if empty).
- [x] The UI prevents negative quantities.
- [ ] User feedback is provided for all cart modification actions.

---

## 4. Subtasks

1. Implement "+" and "–" quantity adjustment buttons for each cart item. ✅
2. Implement logic to remove an item if its quantity is reduced below 1. ✅
3. Add a "Remove" button for each cart item. ⛔
4. Ensure the total price and UI update immediately after any change. ✅
5. Provide user feedback (snackbar) for remove and update actions. ⛔
6. Handle empty cart states with a clear message. ⛔

###################EXERCISE 1 WORKSHEET 6############################

# Profile / Sign-in Screen Requirements

## 1. Feature Description and Purpose

Add one new screen to the Sandwich Shop Flutter app. This screen can act as a **Profile** or **Sign-up/Sign-in** screen where users can enter and/or view their basic details. The goal is to introduce a new standalone screen and simple navigation to it from the existing **OrderScreen**.

For now:

- No real authentication is required.
- No data persistence (e.g., no saving to disk or backend) is required.
- The screen is purely UI and local state.

---

## 2. User Stories

### 2.1. Navigate to Profile / Sign-in Screen

- **As a user**, I want to be able to navigate from the order screen to a profile/sign-in screen via a link at the bottom of the order screen, so I know where I would manage my account in the future.

### 2.2. View / Enter Basic Details

- **As a user**, I want to see a simple form on the profile/sign-in screen (e.g., name and email fields, optionally a password field), so I understand where my details would be entered in a future, fully functional version.

### 2.3. Return to Order Screen

- **As a user**, I want to go back from the profile/sign-in screen to the order screen, so I can continue ordering sandwiches after viewing or entering my details.

---

## 3. Acceptance Criteria

### 3.1. New Screen UI

- [x] A new screen widget exists (e.g., `ProfileScreen` or `SignInScreen`).
- [x] The screen shows a title in the app bar (e.g., "Profile", "Sign In", or "My Account").
- [x] The screen contains at least:
  - [x] A text field for **Name** (or **Email** if sign-in).
  - [x] A text field for **Email** (optional if using Name-only sign-in).
  - [x] Optionally a password field (masked input) if implementing a sign-in style UI.
- [x] The screen includes a primary button (e.g., "Save", "Continue", or "Sign In") that currently only provides basic visual feedback (e.g., a snackbar) but does not perform real authentication or persistence.

### 3.2. Navigation from Order Screen

- [x] The **OrderScreen** has a link/button at the bottom (e.g., "Profile" or "Sign In").
- [x] Tapping this link navigates to the new profile/sign-in screen using Flutter navigation (`Navigator.push` or a named route).
- [x] Navigation uses the existing `MaterialApp` setup (either via a route entry or a `MaterialPageRoute`).

### 3.3. Navigation Back to Order Screen

- [x] The profile/sign-in screen shows a system back button (via the app bar) that returns to the order screen when tapped.
- [x] Alternatively or additionally, the screen may include an explicit "Back to Order" button that calls `Navigator.pop`. *(if you added it; if not, change to [ ] )*

### 3.4. Behavior and Constraints

- [x] No real authentication is implemented (no network calls, no token handling).
- [x] No data persistence is implemented (field values are not saved beyond the screen’s lifetime).
- [x] Form validation may be minimal or omitted (e.g., non-empty check is optional for this exercise).
- [x] UI is consistent with the rest of the app (uses existing styles where appropriate, such as `heading1`, `heading2`, `normalText` if available).

---

## 4. Subtasks

1. Create a new screen widget (e.g., `ProfileScreen` / `SignInScreen`) with an app bar title. ✅
2. Add basic form fields (name, email, optional password) and a primary action button. ✅
3. Add a link/button at the bottom of `OrderScreen` that navigates to the new screen. ✅
4. Implement navigation back from the new screen to `OrderScreen` (using `Navigator.pop`). ✅
5. (Optional) Show simple feedback (e.g., `SnackBar`) when the primary button is tapped. ✅



#######################EXERCISE 2##############################
# App-wide Navigation Drawer & Responsive Navigation Requirements

## 1. Feature Description and Purpose

The goal of this feature is to enhance the navigation in the Sandwich Shop Flutter app by:

1. **Adding a Drawer menu** that:
   - Slides in from the side of the screen (standard `Scaffold.drawer`).
   - Shows the app’s main navigation options (e.g., Order, Cart, Profile, About).

2. **Making the Drawer accessible from all main screens** in the app:
   - Order screen
   - Cart screen
   - Checkout screen
   - Profile / Sign-in screen
   - About screen (if used)

3. **Reducing redundant code** by centralising the Drawer and navigation logic:
   - Avoid duplicating the Drawer widget in every screen file.
   - Use a shared widget, base layout, or helper method to provide a consistent Drawer.

4. **Adding simple responsive navigation behaviour**:
   - On smaller screens (phones): use a standard Drawer.
   - On wider screens (e.g., tablets / desktop widths): show navigation as a side panel or top navigation bar instead of a hidden Drawer, adapting layout based on screen width.

This improves usability, keeps navigation consistent across screens, and encourages clean, reusable code.

---

## 2. User Stories

### 2.1. Basic Drawer Navigation

- **As a user**, I want to open a navigation menu from anywhere in the app, so I can quickly move between key screens (Order, Cart, Profile, About) without going back step‑by‑step.
- **As a user**, I want the Drawer to clearly show where I am (current screen) and what other options are available, so I don’t get lost.

### 2.2. Drawer Access from All Screens

- **As a user**, I want the navigation menu icon (hamburger icon) or equivalent trigger to be present on each main screen, so I always have a consistent way to navigate.
- **As a user**, when I navigate from one screen to another via the Drawer, I expect the new screen to open and the Drawer to close, so I can focus on the content.

### 2.3. Consistent, Reusable Drawer

- **As a developer**, I want a single implementation of the Drawer that can be shared across screens, so that changing the navigation options only requires updating one place.
- **As a developer**, I want to minimise boilerplate for each screen’s `Scaffold`, so new screens can easily plug into the shared navigation pattern.

### 2.4. Responsive Navigation

- **As a user on a small device (phone)**, I want a standard Drawer that slides in over the content, so navigation doesn’t permanently take up screen space.
- **As a user on a larger device (tablet/desktop)**, I want the main navigation visible at all times (e.g., side navigation or top bar), so I can switch screens quickly without opening and closing a Drawer.
- **As a developer**, I want to handle different screen sizes in a single reusable component, so I don’t duplicate layout logic across screens.

---

## 3. Acceptance Criteria

### 3.1. Drawer Content & Options

- [ ] A shared navigation widget (e.g., `AppNavigationDrawer` or `AppScaffold`) exists and is used across main screens.
- [ ] The Drawer includes (at minimum) navigation entries for:
  - [ ] Order screen (home / “Order Sandwiches”).
  - [ ] Cart screen.
  - [ ] Profile / Sign-in screen.
  - [ ] About screen.
- [ ] Each entry has:
  - [ ] An icon appropriate to the destination.
  - [ ] A text label (e.g., “Order”, “Cart”, “Profile”, “About”).

### 3.2. Drawer Behaviour

- [ ] On mobile/small-width screens:
  - [ ] The Drawer is opened via the standard hamburger icon in the `AppBar` or an equivalent menu icon.
  - [ ] Tapping outside the Drawer or navigating closes the Drawer.
- [ ] Tapping a navigation item:
  - [ ] Closes the Drawer.
  - [ ] Navigates to the correct screen (via `Navigator.push`, `pushReplacement`, or named routes).
- [ ] If the user is already on the selected screen:
  - [ ] Either the current screen remains without stacking duplicates (e.g., using `pushReplacement` or a route check),
  - [ ] Or duplicates are acceptable for this exercise, but behaviour is documented.

### 3.3. Drawer Available on All Main Screens

For each of the following, if they exist in the app:

- [ ] `OrderScreen` uses a `Scaffold` that exposes the shared Drawer / navigation structure.
- [ ] `CartScreen` uses the shared Drawer / navigation structure.
- [ ] `CheckoutScreen` uses the shared Drawer / navigation structure.
- [ ] `ProfileScreen` uses the shared Drawer / navigation structure.
- [ ] `AboutScreen` uses the shared Drawer / navigation structure.

Concretely:

- [ ] Every main screen’s top-level widget either:
  - [ ] Uses a common “app scaffold” widget (`AppScaffold`) that wraps content and provides the Drawer, or
  - [ ] Uses a helper function that returns a `Scaffold` with the common Drawer, or
  - [ ] Uses a shared Drawer widget injected into `Scaffold.drawer`.

### 3.4. Code Reuse & Non-duplication

- [ ] There is **one** central implementation of the Drawer UI; other screens do not copy-paste Drawer markup.
- [ ] Navigation items in the Drawer are defined in a single place (e.g., a list of destinations or a config), so adding/removing a destination only requires changing one file.
- [ ] If an “app scaffold” wrapper widget is introduced (e.g., `AppScaffold` taking `title` and `body`), screens use it instead of redefining repeated `Scaffold` + Drawer code.

### 3.5. Responsive Navigation Behaviour

- [ ] The app detects screen width (e.g., via `MediaQuery.of(context).size.width` or `LayoutBuilder`).
- [ ] At least two behaviours are implemented:
  - [ ] **Small screen** mode (e.g., width < 600):
    - [ ] Uses standard `Scaffold.drawer`.
    - [ ] Main body content takes full width when Drawer is closed.
  - [ ] **Large screen** mode (e.g., width ≥ 600):
    - [ ] Navigation is always visible, using one of:
      - [ ] A `Row` with a fixed-width side navigation panel and a main content area, or
      - [ ] A `NavigationRail` / side panel, or
      - [ ] A top navigation bar with buttons/tabs.
    - [ ] No slide-in Drawer is required in this mode (or Drawer is disabled).
- [ ] The navigation and content remain functional and readable on both small and large widths.

### 3.6. Visual and UX Consistency

- [ ] The Drawer / nav panel uses the app’s existing styles and theme (colors, typography) where appropriate.
- [ ] Each destination screen’s title in the `AppBar` or header matches the item selected in the navigation.
- [ ] The currently active screen is visually indicated in the navigation (e.g., using `selected` style on a `ListTile` or by highlighting the active nav item).

---

## 4. Subtasks

### 4.1. Define Navigation Destinations

- [ ] Identify and list all main screens to expose in the Drawer:
  - Order, Cart, Profile, About, Checkout (if appropriate).
- [ ] Decide on labels and icons for each destination.
- [ ] Create a small config/model (e.g., enum or list) describing these destinations.

### 4.2. Implement Shared Drawer Widget

- [ ] Create a reusable widget (e.g., `AppNavigationDrawer`) that:
  - [ ] Builds a `Drawer` with the configured navigation items.
  - [ ] Handles taps by navigating to the correct route.
- [ ] Integrate it into at least one screen’s `Scaffold.drawer` for testing.

### 4.3. Introduce Shared App Scaffold / Layout

- [ ] Create an `AppScaffold` (or similar) widget that:
  - [ ] Wraps a `Scaffold` and injects the Drawer.
  - [ ] Accepts parameters like `title`, `body`, and optionally actions for the `AppBar`.
- [ ] Update each main screen to use `AppScaffold` instead of manually creating a `Scaffold`.

### 4.4. Wire Up Navigation Logic

- [ ] Decide whether to use named routes (`MaterialApp.routes`) or direct `MaterialPageRoute` for Drawer navigation.
- [ ] Implement navigation callbacks in the Drawer to:
  - [ ] Close the Drawer.
  - [ ] Navigate to the appropriate screen.
- [ ] Verify navigation works from all screens in both directions (e.g., Order → Cart → Profile, etc.).

### 4.5. Implement Responsive Navigation

- [ ] Update `AppScaffold` (or a higher-level widget) to:
  - [ ] Use `LayoutBuilder` or `MediaQuery` to choose between Drawer mode (small screens) and side-nav/top-nav mode (large screens).
- [ ] Implement the large-screen layout:
  - [ ] E.g., `Row` with a fixed-width nav column and an expanded content area.
  - [ ] Or `NavigationRail` for side navigation.
- [ ] Ensure all navigation interactions still work identically in both modes.

### 4.6. Polish & Validation

- [ ] Ensure all screens still show their intended content with the new navigation structure.
- [ ] Confirm that the Drawer/menu is accessible from all main screens.
- [ ] Confirm there is no duplicated Drawer code in individual screens.
- [ ] Optionally add simple tests (widget tests) to verify:
  - [ ] Drawer opens and shows expected items.
  - [ ] Tapping an item navigates to the correct screen.