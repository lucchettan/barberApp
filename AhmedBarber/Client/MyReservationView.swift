//
//  MyReservationView.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 01/07/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import SwiftUI

struct MyReservationView: View {
    var reservation: Reservation
    @State var ownerInfo : UserInfo?
    
    @State var presentCancellationAlert = false
    @State var presentSeeSettings = false
    
    @Binding var reservationIsFuture : Bool
    @Binding var isLoggedIn : Bool
    @State var viewState = CGSize.zero

    var body: some View {
        ZStack{
            BackGroundWhite()
            VStack {
                HStack{
                    Text("Mon Rendez Vous")
                        .foregroundColor(Color(#colorLiteral(red: 0.8770651817, green: 0.5741621852, blue: 0.3193312883, alpha: 1)))
                        .bold()
                        .font(.system(size: 40))
                        .offset(y: UIScreen.main.bounds.height * 0.015)
                    Spacer()
                }
                .padding(.leading, UIScreen.main.bounds.width * 0.05)
                .padding(.bottom, UIScreen.main.bounds.height * 0.05)
                .overlay(
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1)))
                        .font(.system(size: 40))
                        .offset(x: UIScreen.main.bounds.width * 0.36, y: -UIScreen.main.bounds.height * 0.09)
                        .onTapGesture {
                            self.presentSeeSettings.toggle()
                        }
                )
                VStack{
                    ZStack{
                        Text(reservation.intDay + " " + reservation.month)
                            .font(.system(size:40))
                            .bold()
                            .foregroundColor(.white)
                            .offset(y: -UIScreen.main.bounds.height * 0.09)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.25)
                    .background(Color(#colorLiteral(red: 0.8770651817, green: 0.5741621852, blue: 0.3193312883, alpha: 1))).cornerRadius(30).shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: -10, y: 15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.22)
                            .overlay(
                                Text(reservation.time)
                                    .font(.system(size: 100))
                                    .bold()
                                    .foregroundColor(Color(#colorLiteral(red: 0.8770651817, green: 0.5741621852, blue: 0.3193312883, alpha: 1)))
                        )
                            .offset(y: UIScreen.main.bounds.height * 0.055)
                    )
                    
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "pencil.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1)))
                            Text(self.ownerInfo != nil ? self.ownerInfo!.name : "Your favorite Barber")
                                .bold()
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 24))
                                .foregroundColor(Color(#colorLiteral(red: 0.8770651817, green: 0.5741621852, blue: 0.3193312883, alpha: 1)))
                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.675)
                        HStack{
                            Image(systemName: "mappin.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1)))
                            Text(self.ownerInfo != nil ? self.ownerInfo!.adress : "You know the Adress")
                                .bold()
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 24))
                                .foregroundColor(Color(#colorLiteral(red: 0.1999336779, green: 0.1053786352, blue: 0.1077213809, alpha: 1)))
//                                .frame(width: UIScreen.main.bounds.width * 0.475)
                                .edgesIgnoringSafeArea(.trailing)


                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.675)
                        HStack{
                            Image(systemName: "phone.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1)))
                            Text(self.ownerInfo != nil ? self.ownerInfo!.phoneNumber : "call your guy")
                                .bold()
                                .underline()
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 24))
                                .foregroundColor(Color(#colorLiteral(red: 0.8770651817, green: 0.5741621852, blue: 0.3193312883, alpha: 1)))
                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.675)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.25)
                    .offset(x: -UIScreen.main.bounds.width * 0.05)
                    VStack{
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.red)
                        Text("Annuler mon rendez-vous")
                            .font(.system(size: 24))
                            .bold()
                            .underline()
                            .foregroundColor(Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1)))
                        
                    }
                    .offset(y: UIScreen.main.bounds.height * 0.05)
                    .onTapGesture {
                        self.presentCancellationAlert.toggle()
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 0.65)
                .background(Blur().blur(radius: 30).offset(y: UIScreen.main.bounds.height * 0.3))
            }
            .frame(height: UIScreen.main.bounds.height * 0.75)

            if self.presentCancellationAlert || self.presentSeeSettings {
                Blur()
                   .gesture(
                        DragGesture().onChanged { value in
                            self.viewState = value.translation
                        }
                        .onEnded { value in
                            if self.presentSeeSettings {
                                if self.viewState.height >= 50 {
                                    self.presentSeeSettings = false
                                }
                            }
                            self.viewState = .zero
                        }
                )
            }
            AnnulationAlert(reservation: self.reservation, isPresented: $presentCancellationAlert, reservationIsFuture: self.$reservationIsFuture)
                .offset(y: self.presentCancellationAlert ? 0 : UIScreen.main.bounds.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            ClientSeeSettingsView(isPresented: $presentSeeSettings, isLoggedIn: self.$isLoggedIn)
                .background(Blur().blur(radius: 15))
                .offset(y: self.presentSeeSettings ? 200 : UIScreen.main.bounds.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .gesture(
                    DragGesture().onChanged { value in
                        self.viewState = value.translation
                    }
                    .onEnded { value in
                        if self.presentSeeSettings {
                            if self.viewState.height >= 50 {
                                self.presentSeeSettings = false
                            }
                        }
                        self.viewState = .zero
                    }
                )

        }
        .animation(.spring())
        .onAppear {
            print("Myreservation on Appear........")
            FireBaseMethods().getInfoOwner(){ result in
                switch result {
                    case .success(let info):
                        self.ownerInfo = info
                    case .failure:
                        print("failure loading owner info in reservationView")
                }
            }
            print("..... End myreservation OnAppear")
        }
    }
}
//
//struct MyReservationView_Previews: PreviewProvider {
//    @State static var value = false
//    static var previews: some View {
//        MyReservationView(reservation: Reservation(userName: "Kiko", userPhone: "0612121212", email: "kiko@kiko.com", time: "12:00", intDay: "03", month: "Juin", year: "2020"), isLoggedIn: $value)
//    }
//}
