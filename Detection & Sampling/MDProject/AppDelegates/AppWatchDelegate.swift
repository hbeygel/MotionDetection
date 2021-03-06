//
//  AppWatchDelegate.swift
//  MDProject
//
//  Created by Yevgeny Beygel on 11/10/17.
//  Copyright © 2017 BGU. All rights reserved.
//

import Foundation
import WatchConnectivity

// MARK: - Conform to WCSessionDelegate protocol
extension AppDelegate : WCSessionDelegate {
    
    
    /// 1. checks if watch session is supported - watch is connetcted
    /// 2. sets the phone app as watch delegate class
    /// 3. activates watch session
    internal func setupWatchSession() {
        if WCSession.isSupported()
        {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print ("Activation Completed With state: \(activationState.rawValue)")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print ("watch became inactive")
        // handle inactive
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print ("watch disconnected from phone")
        // handle disconnection
    }
    
//    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
//        guard let messageObject = userInfo[NSNotification.Name.message.rawValue] else {
//            print ("IPHONE - bad message received : \(userInfo)")
//            return
//        }
////        print (userInfo)
//        DispatchQueue.main.async {
//            NotificationCenter.default.post(name: NSNotification.Name.newDataArrived, object: messageObject)
//        }
//    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        guard let messageObject = message[NSNotification.Name.message.rawValue] else {
            print ("IPHONE - bad message received : \(message)")
            return
        }
        print (message)
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name.newDataArrived, object: messageObject)
        }
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        guard let messageObject = message[NSNotification.Name.message.rawValue] else {
            print ("IPHONE - bad message received : \(message)")
            return
        }
        print (message)
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name.newDataArrived, object: messageObject)
        }
    }
}
