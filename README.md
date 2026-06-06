# Zhāng

Zhāng is a cross-platform manga and comic reader for user-owned libraries and approved source connectors.

## First Foundation

This Flutter app currently includes:

- Library screen with seed series.
- Series detail and reader shell.
- Extensions screen with bundled connector metadata.
- Import and settings foundation screens.
- Tests for library data, extension metadata, and app navigation.

## Development

Run tests:

```powershell
flutter test
```

Run on an available device:

```powershell
flutter run
```

iOS builds require macOS and Xcode.

## iPhone Without Local SDKs

Zhang now includes a Flutter web/PWA target and GitHub Pages deployment workflow. After GitHub Pages is enabled for Actions deployments, the iPhone-friendly web app will be available at:

```text
https://kiiing025.github.io/zhang/
```

Open that URL in Safari, then use Share > Add to Home Screen.

For native iPhone builds without owning a Mac, use the Codemagic workflow in `codemagic.yaml`. The included iOS workflow checks that the app compiles on a hosted Mac; TestFlight installation later requires Apple Developer Program signing.
