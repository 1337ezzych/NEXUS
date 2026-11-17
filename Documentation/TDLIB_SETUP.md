# TDLib integration — setup guide

## 1. Create Telegram API credentials

1. Sign in at https://my.telegram.org.
2. Open API development tools.
3. Create an application and copy the API ID and API hash.
4. Keep both private. Do not paste them into public GitHub issues or commit them.

## 2. Build TDLib for iOS

Use the official TDLib repository and its iOS example as the source of truth:
- https://github.com/tdlib/td
- https://github.com/tdlib/td/tree/master/example/ios
- https://core.telegram.org/tdlib/docs/

A proper iOS build needs Apple's iOS SDK and Xcode toolchain. Use a Mac or a macOS CI runner. Linux is useful for editing code but is not a substitute for the iOS SDK.

Build a framework/XCFramework for the architectures you intend to support (physical iPhone arm64 and simulator arm64; Intel simulator x86_64 only if needed). Follow the exact instructions and CMake options in the TDLib version you choose; do not blindly copy commands from a different release.

## 3. Add TDLib to Xcode

1. Create an iOS App project called NEXUS using SwiftUI.
2. Add `Sources/NEXUS/**/*.swift` to the app target.
3. Add `TDLib.xcframework` to the project and the app target's Frameworks, Libraries, and Embedded Content as required by the build.
4. Configure Header Search Paths / Framework Search Paths.
5. Set the Objective-C Bridging Header to `Configuration/TDLib-Bridging-Header.h`, or create a module map matching your framework packaging.
6. Confirm the exact exported C symbols and header locations against your built TDLib version.

## 4. Implement the C bridge

`TDLibClient.swift` is deliberately a scaffold. Implement:
- `td_json_client_create`
- `td_json_client_send`
- `td_json_client_receive`
- `td_json_client_destroy`

Use the signatures in `td_json_client.h`. Do not guess pointer types or ownership rules. Make sure JSON strings are encoded and memory is managed correctly.

## 5. Authorization lifecycle

Handle TDLib authorization states:
- `authorizationStateWaitTdlibParameters`
- `authorizationStateWaitEncryptionKey`
- `authorizationStateWaitPhoneNumber`
- `authorizationStateWaitCode`
- `authorizationStateWaitPassword`
- `authorizationStateReady`
- closed / logging-out / error states

For `setTdlibParameters`, provide a suitable database directory inside the app's Application Support directory, database encryption key, API ID/hash, device and language parameters. Store the encryption key in Keychain. Never store it in source code or UserDefaults.

## 6. Updates and messages

Build a robust update dispatcher for:
- `updateAuthorizationState`
- `updateNewChat` / `updateChatLastMessage`
- `updateNewMessage`
- message content variants (text, photo, video, document, voice note)
- message send success/failure updates
- connection state and errors

Use TDLib's current schema for the version you build. Implement pagination, chat ordering, unread counters, message history, media downloads, cancellation and retries. Keep large media off the main thread.

## 7. Security and reliability

- Use Keychain for secrets and encryption keys.
- Use Application Support for TDLib database files.
- Handle logout and local database cleanup deliberately.
- Do not log auth codes, passwords, API hashes, session keys, or message contents.
- Add tests for reconnects, offline behavior, migrations and malformed updates.

## 8. Scope

This scaffold does not yet implement calls, push notifications, contacts synchronization, group/channel administration, stickers, reactions, message editing/deletion, or full media handling. These need separate implementation and testing.
