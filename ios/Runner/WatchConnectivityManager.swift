import Foundation
import WatchConnectivity

class WatchConnectivityManager: NSObject, WCSessionDelegate {
    static let shared = WatchConnectivityManager()
    private var session: WCSession?
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    // MARK: - WCSessionDelegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("Watch connectivity activation failed: \(error.localizedDescription)")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Watch connectivity session became inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Watch connectivity session deactivated")
        WCSession.default.activate()
    }
    
    // MARK: - Message Handling
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if let command = message["command"] as? String {
                self.handleCommand(command)
            }
        }
    }
    
    private func handleCommand(_ command: String) {
        // 处理来自 watchOS 的命令
        switch command {
        case "start":
            NotificationCenter.default.post(name: NSNotification.Name("WatchStartExercise"), object: nil)
        case "pause":
            NotificationCenter.default.post(name: NSNotification.Name("WatchPauseExercise"), object: nil)
        case "resume":
            NotificationCenter.default.post(name: NSNotification.Name("WatchResumeExercise"), object: nil)
        case "stop":
            NotificationCenter.default.post(name: NSNotification.Name("WatchStopExercise"), object: nil)
        default:
            break
        }
    }
    
    // MARK: - Message Sending
    
    func sendMessage(_ message: [String: Any]) {
        guard let session = session, session.activationState == .activated else {
            print("Watch connectivity session not activated")
            return
        }
        
        session.sendMessage(message, replyHandler: nil) { error in
            print("Failed to send message: \(error.localizedDescription)")
        }
    }
} 