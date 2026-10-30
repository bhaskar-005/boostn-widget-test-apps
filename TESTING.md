# Boostn Widget App Test Status

Oct 30, 2026

Android testing is done and working fine. iOS still needs to be tested on a real iPhone.

## Status

| Platform | Status | Notes |
| --- | --- | --- |
| Android | Done | Tested and working fine. |
| iOS | To test | Test app code is ready in the `ios` folder of this repo. Must be tested on a real iPhone. |

## Test event

<https://boostn-admin.nmdevai.com/events/fe742f1a-0e12-4da8-a875-41cb43ed5a66>

Widget settings in the app: club `e2e-test-club-name-official-name`, mode `event-list`, grid source `fe742f1a-0e12-4da8-a875-41cb43ed5a66` (same as the event ID).

## Download the code and app

Everything is in this public GitHub repo: [github.com/bhaskar-005/boostn-widget-test-apps](https://github.com/bhaskar-005/boostn-widget-test-apps)

- **Download:** on the repo page, click **Code → Download ZIP**.
- `ios/` is the Xcode project, `android/` is the Android Studio project, and `apk/BoostnTest-debug.apk` is the ready-to-install Android app.
- **iOS build without a Mac:** open the repo's **Actions** tab, then the latest green "iOS build" run. Download `BoostnTest-unsigned-ipa` under Artifacts.

## iOS: install on an iPhone

**Step 1: get the iOS code (either way works)**

- **Option A, download:** [BoostnTest-iOS-code.zip](https://github.com/bhaskar-005/boostn-widget-test-apps/raw/main/downloads/BoostnTest-iOS-code.zip), or the `ios` folder of [the GitHub repo](https://github.com/bhaskar-005/boostn-widget-test-apps). Nothing else to change.
- **Option B, from the website:** open the [test event](https://boostn-admin.nmdevai.com/events/fe742f1a-0e12-4da8-a875-41cb43ed5a66) on the Boostn website and copy its iOS widget code. In the test app, paste it into `BoostnTicketsViewController.swift`, replacing the existing code. Keep the `onPurchaseComplete` line so the bottom status line still updates.

**Step 2: install on the iPhone**

Use one of these two ways.

**With a Mac (Xcode)**

1. Open `ios/BoostnTest.xcodeproj`.
2. Connect the iPhone with a cable.
3. In Signing & Capabilities, choose your Apple ID under Team. If Xcode says the bundle ID is taken, change `com.example.boostntest` to something unique.
4. Select the iPhone at the top and press Run.

**Without a Mac**

1. Open this repo's **Actions** tab and the latest green "iOS build" run. (To build your own changes, fork the repo; the build runs on every push that changes `ios/`.)
2. Download `BoostnTest-unsigned-ipa` under Artifacts.
3. Install `BoostnTest-unsigned.ipa` on the iPhone with Sideloadly (Windows or Mac) and an Apple ID.

On the iPhone, trust the developer certificate under Settings > General > VPN & Device Management. Newer iOS versions also ask you to turn on Developer Mode. With a free Apple ID, the app works for 7 days.

## iOS test checklist (on the iPhone)

- [ ] Blue header at the top, tabs at the bottom, event list loads between them.
- [ ] The event list scrolls inside its section.
- [ ] Open the test event, pick tickets, go to payment. The payment form loads and accepts input.
- [ ] Finish the purchase. The bottom line changes to "Purchase complete, order: ...".
- [ ] If something looks wrong: connect the iPhone to a Mac and inspect the widget with Safari's Develop menu.

Note: the iOS project has not been compiled yet. If the build fails, the error is in the Xcode or GitHub Actions build log.

## Android

Android testing is done: the test app works fine. Use it to repeat the test or compare with iOS.

**Downloads**

- **APK (ready to install):** [BoostnTest-debug.apk](https://github.com/bhaskar-005/boostn-widget-test-apps/raw/main/apk/BoostnTest-debug.apk)
- **Android code (zip):** [BoostnTest-Android-code.zip](https://github.com/bhaskar-005/boostn-widget-test-apps/raw/main/downloads/BoostnTest-Android-code.zip)
- **GitHub:** [the `android` folder](https://github.com/bhaskar-005/boostn-widget-test-apps/tree/main/android) and [the `apk` folder](https://github.com/bhaskar-005/boostn-widget-test-apps/tree/main/apk) in the repo

* **App:** `BoostnTest-debug.apk` (Android 7.0 and newer). Open it on the phone and allow installs from that app, or run `adb install BoostnTest-debug.apk`. It is signed with a debug key, for testing only.
* **Code:** Android Studio project in Kotlin. Open the `android` folder and press Run.
* **Same screen as iOS:** blue header on top, the widget in the middle, purchase status and tabs at the bottom.
* **Debugging:** connect the phone and open `chrome://inspect` in desktop Chrome.
