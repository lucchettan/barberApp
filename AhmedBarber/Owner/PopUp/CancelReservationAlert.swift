//
//  CancelReservationAlert.swift
//  AhmedBarber
//
//  Created by mac on 05/07/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import SwiftUI

struct CancelReservationAlert: View {
    var reservation : Reservation
    @Binding var isPresented : Bool
    @Binding var reservationArray : Dictionary<String, [Any]>
    var body: some View {
        VStack{
            ZStack{
                 VStack(spacing: 15){
                     Text("Annulation")
                         .bold()
                         .font(.system(size: 24))
                         .foregroundColor(Color(#colorLiteral(red: 0.1862579584, green: 0.1104152128, blue: 0.1121566221, alpha: 1)))
                    Text("Êtes-vous sûr de vouloir annuler le rendez vous de \(reservation.userName) à \(reservation.time) le \(reservation.intDay) \(reservation.month)?")
                         .font(.system(size: 20))
                         .bold()
                         .foregroundColor(.white)
                         .multilineTextAlignment(.center)
                    HStack {
                        Spacer()
                        Button(action: {self.isPresented.toggle()}){
                             Image(systemName: "xmark.square")
                                 .font(.system(size: 40))
                                 .foregroundColor(Color(#colorLiteral(red: 0.8676875234, green: 0.5789795518, blue: 0.314088136, alpha: 1)))
                        }.padding(.top, 15)
                        Spacer()
                        Button(action: {
                            FireBaseMethods().cancelReservation(reservation: self.reservation)
                            print("CancerReservationAlert loading user informations")
                            FireBaseMethods().getUserInfo(mail: self.reservation.email){ result in
                                switch result {
                                case .success(let userInfo):
                                    PushNotificationSender().sendPushNotification(to: userInfo.token, title: "Réservation", body: "Désolé nous ne pourrons pas assurer ton rdv de \(self.reservation.userName) le \(self.reservation.intDay)\(self.reservation.month).")
                                case .failure:
                                    print("FAILURE GETTING TOKEN FOR NOTIFICATION SENDING")
                                }
                            }
                            self.reservationArray[self.reservation.time] = self.reservationArray[self.reservation.time]!.filter {$0 as! Reservation != self.reservation}
                            if self.reservationArray[self.reservation.time]?.count == 0 {
                                self.reservationArray.removeValue(forKey: self.reservation.time)
                            }
                            self.isPresented.toggle()
                        }){
                             Image(systemName: "checkmark.square")
                                 .font(.system(size: 40))
                                 .foregroundColor(Color(#colorLiteral(red: 0.8676875234, green: 0.5789795518, blue: 0.314088136, alpha: 1)))
                        }.padding(.top, 15)
                        Spacer()
                    }
                 }
                 .padding(20)
                 .background(Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1)).cornerRadius(15))
                 .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: -10, y: 15)
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
        }
    }
}

//struct CancelReservationAlert_Previews: PreviewProvider {
//    @State static var value = true
//    static var previews: some View {
//        CancelReservationAlert(reservation: Reservation(userName: "kiko", userPhone: "050505050", email: "ldjfhffjj", time: "09:00", intDay: "03", month: "juin", year: "2020"), isPresented: $value)
//    }
//}
