//
//  Models.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 19/05/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import Foundation
import SwiftUI

struct Reservation: Hashable, Identifiable {
    var id = UUID()
    var userName : String
    var userPhone : String
    var email : String
    var time : String
    var weekday : String?
    var intDay : String
    var month : String
    var year : String
}

struct Day : Hashable {
    var weekday : String?
    var intDay : String
    var month : String
    var reservations : [Reservation]?
    var availableSpots = ["9:00","9:30","10:00","10:30","11:00","11:30","12:00","12:30","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00"]
}


func get7NextDays() -> [Day]{
    var sevenDays = [Day]()
    let hour : TimeInterval = 60 * 60
    let day : TimeInterval = 24 * hour

    func getWeekDay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
    func getMonth(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "MMM"
        return formatter.string(from: date)
    }
    func getDay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "dd"
        return formatter.string(from: date)
    }
    while sevenDays.count < 7 {
        for i in 1 ... 8 {
            if (getWeekDay(date: Date(timeIntervalSinceNow: Double(i) * day))) != "lundi" {
                var dayToAdd = Date(timeIntervalSinceNow: Double(i) * day)
//                print(getDay(date: dayToAdd))
//                print(getMonth(date: dayToAdd))
//                print("---------------------")
                let newDay = Day(weekday: getWeekDay(date: dayToAdd), intDay: getDay(date: dayToAdd), month: getMonth(date: dayToAdd))
                sevenDays.append(newDay)
            }
        }
    }
    return sevenDays
}

func getDayAvailability(day: Day) -> Day {
    var counter = 2
    var newDay = day
    var reservationTimeArray = [String]()
    for time in day.reservations! {
        reservationTimeArray.append(time.time)
    }
    let mappedReservations = reservationTimeArray.map { ($0, 1) }
    
    let dictionnary = Dictionary(mappedReservations, uniquingKeysWith: +)
    for slot in dictionnary {
        if slot.value == counter {
            newDay.availableSpots = newDay.availableSpots.filter() { $0 != slot.key }
        }
    }
    print("array loaded and filtrated")
    print("array loaded :")
    print(newDay.reservations)
    print("array filtered :")
    print(newDay.availableSpots)
    return newDay
}


func ReservationIsFuture(reservation: Reservation) -> Bool{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MMM-dd'T'-HH:mm"
    dateFormatter.locale = Locale(identifier: "fr_FR")
    if dateFormatter.date(from:"\(reservation.year)-\(reservation.month)-\(reservation.intDay)T-\(reservation.time)")! >= Date(timeIntervalSinceNow: TimeInterval(exactly: -600.0)!) {
        return true
    }
    return false
}
struct InfoOwner : Hashable {
    var adress : String
    var name : String
    var phoneNumber : String
    var seatQuantity : Int
    var email : String
    var token : String
}

struct UserInfo : Hashable {
    var email : String
    var name : String
    var phoneNumber : String
    var adress = ""
    var seatQuantity = 1
    var token : String
}
