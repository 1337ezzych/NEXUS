import Foundation

enum TDLibConfiguration {
    // Put real values in a local, untracked configuration file or inject them
    // through your build configuration. Never commit API credentials.
    static var apiID: Int32 {
        Int32(ProcessInfo.processInfo.environment["TELEGRAM_API_ID"] ?? "") ?? 0
    }

    static var apiHash: String {
        ProcessInfo.processInfo.environment["TELEGRAM_API_HASH"] ?? ""
    }
}
