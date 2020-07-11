//
//  ConfirmationAlert.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 01/07/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import SwiftUI
import FirebaseAuth
struct ConfirmationAlert: View {
    var day : Day
    var hour : String
    @State var user = UserInfo(email: "", name: "", phoneNumber: "", token: "")
    @Binding var isPresented : Bool
    var body: some View {
        VStack{
            ZStack{
                VStack(spacing: 15){
                    Text("Confirmation")
                        .bold()
                        .font(.system(size: 24))
                        .foregroundColor(Color(#colorLiteral(red: 0.1862579584, green: 0.1104152128, blue: 0.1121566221, alpha: 1)))
                    Text("Êtes-vous sûr de vouloir résérver pour\nle \(day.intDay + " " + day.month) à \(hour)?")
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
                            FireBaseMethods().getUserInfo(mail: (Auth.auth().currentUser?.email!)!){ result in
                                switch result {
                                case .success(let userInfo):
                                    FireBaseMethods().createReservation(email: userInfo.email, userName: userInfo.name , userPhone: "00000000", time: self.hour, intDay: self.day.intDay, month: self.day.month)
                                    PushNotificationSender().sendPushNotification(to: userInfo.token, title: "Nouvelle Réservation", body: "\(userInfo.name) a réservé pour \(self.hour) le \(self.day.intDay)\(self.day.month)")
                                case .failure:
                                    print("FAILURE GETTING TOKEN FOR NOTIFICATION SENDING")
                                }
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
            .fixedSize(horizontal: false, vertical: true)
            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.45)
//            .onAppear{
//                FireBaseMethods().getUserInfo(mail: (Auth.auth().currentUser?.email!)!){ result in
//                    switch result {
//                    case .success(let userFound):
//                        print("function lancee")
//                        print(userFound.email)
//
//                        self.user = userFound
//                        print("user founded" + String(self.user.email))
//                    case .failure(let err):
//                        print("get user echouee")
//                        print(err.localizedDescription)
//                    }
//                }
//            }
        }
    }
}

//struct ConfirmationAlert_Previews: PreviewProvider {
//    static var previews: some View {
//        ConfirmationAlert(day: Day(weekday: "Mardi", intDay: "03", month: "Juin"), hour: "09:00")
//    }
//}
