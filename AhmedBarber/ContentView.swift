//
//  ContentView.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 19/05/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State var emailEntry = ""
    @State var password = ""
    @State var pushed: Bool = false
    @State var currentUser = Auth.auth().currentUser
    @State var isLoggedIn = Auth.auth().currentUser == nil ? false : true
    @State var userReservation : Reservation?
    @State var reservationIsFuture = false
    @State var infoOwner = InfoOwner(adress: "152 Avenue Jacques Vogt, 95340 Persan", name: "Ahmed Barber", phoneNumber: "contentView", seatQuantity: 1, email: "barberapp0@gmail.com", token: "")
    var body: some View {
        VStack{
            if (Auth.auth().currentUser == nil && self.isLoggedIn == false) {
                logInView(isLoggedIn: self.$isLoggedIn)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
            
            if Auth.auth().currentUser != nil && self.isLoggedIn == true {
                if Auth.auth().currentUser?.email?.lowercased() == "barberapp0@gmail.com" {
//                    ScheduleView(infoOwner: self.$infoOwner,isLoggedIn: self.$isLoggedIn)
//                        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                    ScheduleView(isLoggedIn: self.$isLoggedIn)
                        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                } else {
                    if self.userReservation != nil  && self.reservationIsFuture {
                        MyReservationView(reservation: self.userReservation!, reservationIsFuture: self.$reservationIsFuture, isLoggedIn: self.$isLoggedIn)
                            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                            .onTapGesture {
                                FireBaseMethods().loadUserNextReservations(email: (Auth.auth().currentUser?.email)!){ (result) in
                                    switch result {
                                        case .success(let nextSpotReserved):
                                            print("                                     |")
                                            print("Reservation Founded for current user v")
                                            print(nextSpotReserved)
                                            print("Reservation Founded for current user ^ ")
                                            print("END............                      |")
                                            self.userReservation = nextSpotReserved
                                        case .failure(let err):
                                            print("Booking view on Appear aucun rdv trouvé pour \(Auth.auth().currentUser?.email!)")
                                            print(err.localizedDescription)
                                    }
                                    self.reservationIsFuture = ReservationIsFuture(reservation: self.userReservation!)
                                    print("self.reservationIsFuture =====" + String(self.reservationIsFuture))
                                }
                                self.reservationIsFuture = ReservationIsFuture(reservation: self.userReservation!)
                            }
                    } else {
                        BookingView(isLoggedIn: self.$isLoggedIn)
                            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                    }
                }
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .onAppear {
            if  Auth.auth().currentUser != nil && Auth.auth().currentUser?.email?.lowercased() != "barberapp0@gmail.com" {
                FireBaseMethods().loadUserNextReservations(email: (Auth.auth().currentUser?.email)!){ (result) in
                    switch result {
                        case .success(let nextSpotReserved):
                            print("                                     |")
                            print("Reservation Founded for current user v")
                            print(nextSpotReserved)

                            self.userReservation = nextSpotReserved
                        case .failure(let err):
                            print("Booking view on Appear aucun rdv trouvé pour \(Auth.auth().currentUser?.email!)")
                            print(err.localizedDescription)
                    }
                    self.reservationIsFuture = ReservationIsFuture(reservation: self.userReservation!)
                    print("self.reservationIsFuture =====" + String(self.reservationIsFuture))
                }
            }
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
