# Boostn Widget Test Apps

Two small native apps that show the Boostn ticket widget as one section of a screen: a native header on top, the widget in a WebView in the middle, and a native status line + tabs at the bottom. After a purchase, the bottom line changes to "Purchase complete ✅ order: …".

| Folder | What |
| --- | --- |
| `android/` | Android Studio project (Kotlin). Open the folder and press Run. |
| `ios/` | Xcode project (Swift). Open `ios/BoostnTest.xcodeproj` and press Run. |
| `apk/BoostnTest-debug.apk` | Ready-to-install Android test app (debug-signed, testing only). |

**Status:** Android tested and working. iOS still to be tested on a real iPhone.

**Test event:** https://boostn-admin.nmdevai.com/events/fe742f1a-0e12-4da8-a875-41cb43ed5a66
Widget settings: club `e2e-test-club-name-official-name`, mode `event-list`, grid source `fe742f1a-0e12-4da8-a875-41cb43ed5a66`.

## iOS without a Mac

Every push that changes `ios/` runs the **iOS build** workflow on a GitHub macOS runner (Actions tab). It produces two artifacts:

- `BoostnTest-unsigned-ipa` — install on an iPhone with Sideloadly and an Apple ID (free Apple ID: 7 days).
- `BoostnTest-simulator` — upload to appetize.io to run in a browser.

## Notes

- The APK uses Android's built-in `Activity` and theme; the Android Studio project uses `AppCompatActivity`. The WebView setup is the same in both.
- Debugging: Android via `chrome://inspect` in desktop Chrome; iOS via Safari's Develop menu on a Mac.
