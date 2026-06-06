# Using Zhang On iPhone Without Local SDKs

Zhang can be developed from this Windows repo without installing Android SDK, macOS, or Xcode locally.

## Fastest iPhone Path: Web App

The GitHub Pages workflow builds the Flutter web app on every push to `main`.

After the first successful Pages deployment, open this URL on iPhone Safari:

```text
https://kiiing025.github.io/zhang/
```

Then install it to the Home Screen:

1. Tap Safari's Share button.
2. Tap Add to Home Screen.
3. Keep the name as Zhāng.
4. Open Zhang from the Home Screen icon.

This uses the PWA icon and metadata in `web/`.

## Native iPhone Path: Cloud Build First, TestFlight Later

`codemagic.yaml` includes an unsigned iOS build check. This proves Codemagic can compile the iOS app on a hosted Mac without requiring this Windows machine to have Xcode.

Unsigned iOS builds are not installable on an iPhone. To install the native app completely through TestFlight later, the project will need:

- Apple Developer Program membership.
- App Store Connect access.
- Codemagic iOS signing setup for bundle ID `app.zhang`.
- A signed `.ipa` upload to TestFlight.

Until then, the PWA is the no-local-SDK path for using Zhang on iPhone.
