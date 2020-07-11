//
//  PushNotificationManager.swift
//  AhmedBarber
//
//  Created by mac on 07/07/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import Firebase
import FirebaseFirestore
import FirebaseMessaging
import UserNotifications
import FirebaseAuth


class PushNotificationManager: NSObject, MessagingDelegate, UNUserNotificationCenterDelegate {
    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM)
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        UIApplication.shared.registerForRemoteNotifications()
        updateFirestorePushTokenIfNeeded()
    }
    func updateFirestorePushTokenIfNeeded() {
        if let token = Messaging.messaging().fcmToken {
            let fireStoreDB = Firestore.firestore()
            if  Auth.auth().currentUser?.email?.lowercased() != "barberapp0@gmail.com" {
                fireStoreDB.collection("Users").whereField("email", isEqualTo: Auth.auth().currentUser?.email).addSnapshotListener { (snapshot, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                    } else {
                        if snapshot?.isEmpty != true && snapshot != nil {
                            for document in snapshot!.documents {
                                fireStoreDB.collection("Users").document(document.documentID).setData(["token": token]) { err in
                                    if let err = err {
                                        print("Error removing document: \(err)")
                                    } else {
                                        print("token sucesfully updated for user!")
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                fireStoreDB.collection("Info").whereField("email", isEqualTo: "barberapp0@gmail.com").addSnapshotListener { (snapshot, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                    } else {
                        if snapshot?.isEmpty != true && snapshot != nil {
                                fireStoreDB.collection("Info").document(snapshot!.documents[0].documentID).setData(["token": token]) { err in
                                    if let err = err {
                                        print("Error removing document: \(err)")
                                    } else {
                                        print("TOKEN sucesfully updated for owner!")
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        updateFirestorePushTokenIfNeeded()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response)
    }
    
    func getFCMToken() -> String {
        if let token = Messaging.messaging().fcmToken {
            return token
        } else { return "error creating token" } 
    }
    
}

class PushNotificationSender {
    func sendPushNotification(to token: String, title: String, body: String) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["to" : token,
                                           "notification" : ["title" : title, "body" : body],
                                           "data" : ["user" : "test_id"]
        ]
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAAnlNy5x4:APA91bHIDPKstmg5AJ2I1ck5HfzYgb4bPs97fm6wpNpP-4QkIZZ9Zz0fVTNCUiFtvB4OaZTab-GvHDbUNThS0e0wrGJ9plwN4bdILycO1y-qXonSUDiOwtZY0rK5Tsbxd2Aw1fqXI_U3", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}
