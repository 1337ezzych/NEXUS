import Foundation
import Combine

enum TelegramAuthState: Equatable {
    case waiting
    case phoneNumber
    case code
    case password
    case ready
    case error(String)
}

/// Integration boundary for the app. Replace TODO sections with calls to TDLib.
/// Keep TDLib updates on a controlled background queue and publish UI changes on main.
@MainActor
final class TelegramService: ObservableObject {
    @Published private(set) var authState: TelegramAuthState = .waiting
    @Published private(set) var isConnected = false

    private let client = TDLibClient()

    func start() {
        guard TDLibConfiguration.apiID > 0, !TDLibConfiguration.apiHash.isEmpty else {
            authState = .error("Не заданы TELEGRAM_API_ID и TELEGRAM_API_HASH")
            return
        }
        // TODO: start receive loop and process updateAuthorizationState.
        // Send setTdlibParameters when requested by TDLib.
    }

    func submitPhoneNumber(_ phone: String) {
        // TODO: send setAuthenticationPhoneNumber.
    }

    func submitCode(_ code: String) {
        // TODO: send checkAuthenticationCode.
    }

    func submitPassword(_ password: String) {
        // TODO: send checkAuthenticationPassword.
    }

    func loadChats() {
        // TODO: send loadChats and process chat list updates.
    }

    func sendText(_ text: String, to chatID: Int64) {
        // TODO: send sendMessage with inputMessageText.
    }
}
