//
//  FireBaseMethods.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 19/05/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabase
/*

 
 */


struct FireBaseMethods {
    
    // MARK: Reservations functions
    func getYear(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "yyyy"
        return formatter.string(from: date)
    }
    /* --------CREATE A RESERVATION--------- */
    func createReservation(email: String,userName : String, userPhone : String, time : String, intDay : String, month : String){
        let fireStoreDatabase = Firestore.firestore()
        var fireStoreReference: DocumentReference? = nil
        let firePost : [String: Any] = ["email" : email,"userName" : userName, "userPhone" : userPhone, "time" : time, "intDay" : intDay, "month" : month, "year" : getYear(date: Date())]
        
        fireStoreReference = fireStoreDatabase.collection("Reservation").addDocument(data: firePost, completion: {(error) in
            if error != nil {
                // self.alertMessage(title: "Error", message: "issue with : \(error?.localizedDescription ?? "Error")")
            } else {
                
            }
        })
        print(fireStoreReference.debugDescription)
    }
    
    func loadReservationsOfADay(day: Day,completion: @escaping (Result<[Reservation], Error>) -> ()) {
        let fireStoreDB = Firestore.firestore()
        var reservationsFounded = [Reservation]()
        var reservationID = ""
        var username = ""
        var userPhone = ""
        var time = ""
        var intOfDay = ""
        var monthOfDay = ""
        var email = ""
        var year = ""
        
        let rdv = fireStoreDB.collection("Reservation").whereField("intDay", isEqualTo: day.intDay).whereField("month", isEqualTo: day.month)
        rdv.addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        if let documentid = document.documentID as? String {
                            reservationID  = documentid
                        }
                        if let UserPhone = document.get("userPhone") as? String {
                            userPhone = UserPhone
                        }
                        if let UserName = document.get("userName") as? String {
                            username = UserName
                        }
                        if let Time = document.get("time") as? String {
                            time = Time
                        }
                        if let IntOfDay = document.get("intDay") as? String {
                            intOfDay = IntOfDay
                        }
                        if let MonthOfDay = document.get("month") as? String {
                            monthOfDay = MonthOfDay
                        }
                        if let Email = document.get("email") as? String {
                            email = Email
                        }
                        if let Year = document.get("year") as? String {
                            year = Year
                        }
                        let reservationToAdd = Reservation(userName: username, userPhone: userPhone, email: email, time: time, intDay: intOfDay, month: monthOfDay, year: year)
                        reservationsFounded.append(reservationToAdd)
                    }
                    DispatchQueue.main.async {
                        print("loading spots ok from loader reservationOfADay")
                        print(reservationsFounded)
                        completion(.success(reservationsFounded))
                    }
                }
            }
        }
    }
    

    //     Owner Func to retrieve the reservation not working giving back all reservations
    func loadReservations(completion: @escaping (Result<[Reservation], Error>) -> ()) {
        let fireStoreDB = Firestore.firestore()
        var reservationsFounded = [Reservation]()
        var reservationID = ""
        var username = ""
        var userPhone = ""
        var time = ""
        var intOfDay = ""
        var monthOfDay = ""
        var email = ""
        var year = ""
        let rdv = fireStoreDB.collection("Reservation")
        //        rdv
        //            .whereField("intDay", isEqualTo: intDay)
        //            .whereField("month", isEqualTo: month)
        
        rdv.addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        print("bzzz bbbzzz    bzzz document founded")
                        if let documentid = document.documentID as? String {
                            reservationID  = documentid
                        }
                        if let UserPhone = document.get("userPhone") as? String {
                            userPhone = UserPhone
                        }
                        if let UserName = document.get("userName") as? String {
                            username = UserName
                        }
                        if let Time = document.get("time") as? String {
                            time = Time
                        }
                        if let IntOfDay = document.get("intDay") as? String {
                            intOfDay = IntOfDay
                        }
                        if let MonthOfDay = document.get("month") as? String {
                            monthOfDay = MonthOfDay
                        }
                        if let Email = document.get("email") as? String {
                            email = Email
                        }
                        if let Year = document.get("year") as? String {
                            year = Year
                        }
                        let reservationToAdd = Reservation(userName: username, userPhone: userPhone, email: email, time: time, intDay: intOfDay, month: monthOfDay, year: year)
                        reservationsFounded.append(reservationToAdd)
                    }
                    DispatchQueue.main.async {
                        print("Spots loaded from BookingView() loadReservations()")
                        print(reservationsFounded)
                        print("end ------------------- Spots loaded from BookingView() loadReservations()")
                        completion(.success(reservationsFounded))
                    }
                }
            }
        }
    }
    
    func loadReservationsOfADAyV2(intDay: String, month: String,completion: @escaping (Result<[Reservation], Error>) -> ()) {
        let fireStoreDB = Firestore.firestore()
        var reservationsFounded = [Reservation]()
        var reservationID = ""
        var username = ""
        var userPhone = ""
        var time = ""
        var intOfDay = ""
        var monthOfDay = ""
        var email = ""
        var year = ""
        let rdv = fireStoreDB.collection("Reservation").whereField("intDay", isEqualTo: intDay).whereField("month", isEqualTo: month)
        
        rdv.addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        print("bzzz bbbzzz    bzzz document founded")
                        if let documentid = document.documentID as? String {
                            reservationID  = documentid
                        }
                        if let UserPhone = document.get("userPhone") as? String {
                            userPhone = UserPhone
                        }
                        if let UserName = document.get("userName") as? String {
                            username = UserName
                        }
                        if let Time = document.get("time") as? String {
                            time = Time
                        }
                        if let IntOfDay = document.get("intDay") as? String {
                            intOfDay = IntOfDay
                        }
                        if let MonthOfDay = document.get("month") as? String {
                            monthOfDay = MonthOfDay
                        }
                        if let Email = document.get("email") as? String {
                            email = Email
                        }
                        if let Year = document.get("year") as? String {
                            year = Year
                        }
                        let reservationToAdd = Reservation(userName: username, userPhone: userPhone, email: email, time: time, intDay: intOfDay, month: monthOfDay, year: year)
                        reservationsFounded.append(reservationToAdd)
                    }
                    DispatchQueue.main.async {
                        print("Spots loaded from BookingView() loadReservations()")
                        print(reservationsFounded)
                        print("end ------------------- Spots loaded from BookingView() loadReservations()")
                        completion(.success(reservationsFounded))
                    }
                }
            }
        }
    }
    
//func getYear(date: Date) -> String {
//    let formatter = DateFormatter()
//    formatter.locale = Locale(identifier: "fr_FR")
//    formatter.dateFormat = "yyyy"
//    return formatter.string(from: date)
//}
    
    func getAvailableSpots(spots: [String], intDay: String, month: String, completion: @escaping (Result<[String], Error>) -> ()){
        let fireStoreDB = Firestore.firestore()
        var reservationsTime = [String]()
        var time = ""
        fireStoreDB.collection("Reservation").whereField("intDay", isEqualTo: intDay).whereField("month", isEqualTo: month).whereField("year", isEqualTo: getYear(date: Date())).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        if let Time = document.get("time") as? String {
                            time = Time
                        }
                        reservationsTime.append(time)
                    }
                    DispatchQueue.main.async {
                        print("loading spots ok")
                        print("reservationTime =")
                        print(reservationsTime)
                        print("spots = ")
                        print(spots.filter { !reservationsTime.contains($0) })
                        completion(.success(spots.filter { !reservationsTime.contains($0) }))
                    }
                }
            }
        }
    }
    
    
    func loadUserNextReservations(email: String,completion: @escaping (Result<Reservation, Error>) -> ()) {
        let fireStoreDB = Firestore.firestore()
        var reservationsFounded = [Reservation]()
        var reservationID = ""
        var username = ""
        var userPhone = ""
        var time = ""
        var intOfDay = ""
        var monthOfDay = ""
        
        let rdv = fireStoreDB.collection("Reservation").whereField("email", isEqualTo: email)
        
        rdv.addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        if let documentid = document.documentID as? String {
                            reservationID  = documentid
                        }
                        if let UserPhone = document.get("userPhone") as? String {
                            userPhone = UserPhone
                        }
                        if let UserName = document.get("userName") as? String {
                            username = UserName
                        }
                        if let Time = document.get("time") as? String {
                            time = Time
                        }
                        if let IntOfDay = document.get("intDay") as? String {
                            intOfDay = IntOfDay
                        }
                        if let MonthOfDay = document.get("month") as? String {
                            monthOfDay = MonthOfDay
                        }
                        let reservationToCheck = Reservation(userName: username, userPhone: userPhone, email: email, time: time, intDay: intOfDay, month: monthOfDay, year: self.getYear(date: Date()))
                        if ReservationIsFuture(reservation: reservationToCheck) {
                            print("voila une reservation apres la date actuelle")
                            print(reservationToCheck)
                            reservationsFounded.append(reservationToCheck)
                            completion(.success(reservationToCheck))
                        }
                    }
                    if reservationsFounded.count == 0 {
                        print("no reservation founded after current date")
                        completion(.success(Reservation(userName: "", userPhone: "", email: "", time: "01:00", intDay: "01", month: "juin", year: "2000")))
                    }
                }
            }
        }
    }
    
    func cancelReservation(reservation: Reservation){
        let fireStoreDB = Firestore.firestore()
        fireStoreDB.collection("Reservation").whereField("intDay", isEqualTo: reservation.intDay).whereField("month", isEqualTo: reservation.month).whereField("userName", isEqualTo: reservation.userName).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        fireStoreDB.collection("Reservation").document(document.documentID).delete() { err in
                            if let err = err {
                                print("Error removing document: \(err)")
                            } else {
                                print("Document \(reservation)successfully removed!")
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: User functions
    func createUser(email : String, name : String, phoneNumber : String, token: String){
        let fireStoreDatabase = Firestore.firestore()
        var fireStoreReference: DocumentReference? = nil
        let firePost : [String: Any] = ["email" : email, "name" : name, "phone" : phoneNumber, "token" : token]
        
        fireStoreReference = fireStoreDatabase.collection("Users").addDocument(data: firePost, completion: {(error) in
            if error != nil {
                // self.alertMessage(title: "Error", message: "issue with : \(error?.localizedDescription ?? "Error")")
            } else {
                print("creation reussie")
            }
        })
        print(fireStoreReference.debugDescription)
    }

    func getUserInfo(mail: String, completion: @escaping (Result<UserInfo, Error>)-> ()){
        let fireStoreDB = Firestore.firestore()
        var email = ""
        var name  = ""
        var phoneNumber = ""

        var token = ""
        fireStoreDB.collection("Users").whereField("email", isEqualTo: mail).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        if let Email = document.get("email") as? String {
                            email = Email
                        }
                        if let Name = document.get("name") as? String {
                            name = Name
                        }
                        if let Phone = document.get("phone") as? String {
                            phoneNumber = Phone
                        }
                        if let Token = document.get("token") as? String {
                            token = Token
                        }
                        DispatchQueue.main.async {
                            let info = UserInfo(email: email, name: name, phoneNumber: phoneNumber, token: token)
                            print("loading userInfo ok from a getUserInfo() func")
                            completion(.success(info))
                        }
                    }
                }
            }
        }
    }
    
    func modifyInfoUser(info: UserInfo){
        let fireStoreDB = Firestore.firestore()
        fireStoreDB.collection("Users").whereField("email", isEqualTo: info.email).getDocuments { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        fireStoreDB.collection("Users").document(document.documentID).updateData(["name" : info.name, "phone" : info.phoneNumber]) { err in
                            if let err = err {
                                print("Error removing document: \(err)")
                            } else {
                                print("Document successfully removed!")
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    // MARK: Owner functions
 
    func getInfoOwner(completion: @escaping (Result<UserInfo, Error>)-> ()){
        let fireStoreDB = Firestore.firestore()
        var adress = ""
        var name = ""
        var phoneNumber = ""
        var seatQuantity = 0
        var email = ""
        var token = ""
        fireStoreDB.collection("Users").whereField("email", isEqualTo: "barberapp0@gmail.com").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        if let Adress = document.get("adress") as? String {
                            adress = Adress
                        }
                        if let Name = document.get("name") as? String {
                            name = Name
                        }
                        if let Phone = document.get("phone") as? String {
                            phoneNumber = Phone
                        }
                        if let Quantity = document.get("seatQuantity") as? Int {
                            seatQuantity  = Quantity
                        }
                        if let Email = document.get("email") as? String {
                            email = Email
                        }
                        if let Token = document.get("token") as? String {
                            token  = Token
                        }
                        DispatchQueue.main.async {
                            let ownerInfo = UserInfo(email: email, name: name, phoneNumber: phoneNumber, adress: adress, seatQuantity: seatQuantity,  token: token)
                            print("loading infoOwner ok")
                            print(ownerInfo)
                            completion(.success(ownerInfo))
                        }
                    }
                }
            }
        }
    }
    func modifyInfoOwner(info: UserInfo){
        let fireStoreDB = Firestore.firestore()
        fireStoreDB.collection("Users").whereField("email", isEqualTo: "barberapp0@gmail.com").getDocuments { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        fireStoreDB.collection("Users").document(document.documentID).setData(["adress" : info.adress, "name" : info.name, "phone" : info.phoneNumber, "seatQuantity" : info.seatQuantity, "email" : info.email, "token" : info.token]){ error in
                            if let error = error {
                                print("Data could not be saved: \(error).")
                            } else {
                                print("Owner Data saved successfully!")
                            }
                        }
                    }
                }
            }
        }
    }
}
