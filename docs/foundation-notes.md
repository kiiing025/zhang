# Zhāng Foundation Notes

Zhāng is a Flutter manga and comic reader foundation for Android and iOS.

## Current Slice

- Material 3 app shell.
- Library, Extensions, Import, Settings, Series Detail, and Reader screens.
- Seed series and chapter data.
- Bundled extension registry.
- Local Files extension metadata.
- iOS guardrail for bundled or reviewed connectors.
- Android-only external extension package manager represented as disabled foundation metadata.

## Platform Notes

Flutter app code can be developed on Windows. iOS simulator, device, signing, and App Store builds require macOS with Xcode.

## Extension Guardrails

The iOS App Store build must not download or execute extension code. It should use bundled, reviewed, or declarative connectors. Android can later support signed external extension packages through a separate implementation plan.
