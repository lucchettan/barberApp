//
//  Schedule.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 20/05/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import SwiftUI
struct ScheduleView: View {
    @State var selectedDay = 1
    @State var sevenNextDays = get7NextDays()
    @State var groupReservation : Dictionary = Dictionary<String, [Any]>()
    @State var presentSeeSettings = false
    @State var presentCancellationAlert = false
    @State var reservationToDelete = Reservation(userName: "", userPhone: "", email: "", time: "", intDay: "", month: "", year: "")
    @State var infoOwner = UserInfo(email: "", name: "", phoneNumber: "", adress: "", seatQuantity: 1, token: "")
    @State var viewState = CGSize.zero


    @Binding var isLoggedIn : Bool
    var body: some View {
        ZStack {
            ZStack {
                PlanningController(selectedDay: self.$selectedDay, sevenNextDays: self.$sevenNextDays, presentSeeSettings: self.$presentSeeSettings)
                    .onTapGesture {
                        FireBaseMethods().loadReservationsOfADay(day: self.sevenNextDays[self.selectedDay - 1]){ result in
                            switch result {
                            case .success(let array):
                                self.groupReservation = Dictionary(grouping: array, by: { $0.time })
                            case.failure:
                                print("scheduleview scrollview onappear no reservation found")
                            }
                        }
                    }
                VStack {
                    Spacer()
                    ScrollView(showsIndicators: true) {
                        if self.sevenNextDays[self.selectedDay - 1].reservations != nil && self.groupReservation.count != 0 {
                            if self.sevenNextDays[self.selectedDay - 1].reservations?.count != 0 {
                                Text("")
                                ForEach(self.groupReservation.keys.sorted(), id: \.self) { key in
                                    VStack {
                                        TimeCellView(time: key)
                                        ForEach(0..<self.groupReservation[key]!.count, id: \.self){ reservation in
                                            ReservationCellView(reservation: self.groupReservation[key]![reservation] as! Reservation, presentCancellationAlert:  self.$presentCancellationAlert, reservationToDelete : self.$reservationToDelete)
                                        }
                                    }
                                }
                            }
                        } else {
                            VStack {
                                Spacer()
                                Text(" Pas encore de réservations pour le \(sevenNextDays[self.selectedDay - 1].intDay) \(sevenNextDays[self.selectedDay - 1].month)")
                                    .foregroundColor(Color(#colorLiteral(red: 0.8770651817, green: 0.5741621852, blue: 0.3193312883, alpha: 1)))
                                    .font(.system(size: 30))
                                    .bold()
                                    .lineLimit(3)
                                    .multilineTextAlignment(.center)
                                    .animation(.none)
                                Spacer()
                            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.9 , height: UIScreen.main.bounds.height * 0.7)
                    .background(Blur().cornerRadius(15).opacity(0.95).background(Color.white.opacity(0.8).blur(radius: 80).cornerRadius(15)))
                    .onAppear{
                        FireBaseMethods().loadReservationsOfADay(day: self.sevenNextDays[self.selectedDay - 1]){ result in
                            switch result {
                            case .success(let array):
                                self.groupReservation = Dictionary(grouping: array, by: { $0.time })
                            case.failure:
                                print("scheduleview scrollview onappear no reservation found")
                            }
                            
                        }
                     }
                }
                .frame(height: UIScreen.main.bounds.height * 1.05)
            }
            .offset(y: self.presentSeeSettings ? -250 : 0)
            .rotation3DEffect(Angle(degrees: self.presentSeeSettings ? -10 : 0), axis: (x: 10.0, y: 0, z: 0))
            .scaleEffect(self.presentSeeSettings ? 0.9 : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))

            if  self.presentCancellationAlert || self.presentSeeSettings{
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
            SeeSettingsView(infoOwner: self.$infoOwner, isPresented: self.$presentSeeSettings, isLoggedIn: self.$isLoggedIn)
                .offset(y: self.presentSeeSettings ? UIScreen.main.bounds.height * 0.1 : UIScreen.main.bounds.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onAppear{
                    print("Scheduleview().seeSettingsView() on appear......")
                    FireBaseMethods().getInfoOwner() { result in
                        switch result {
                        case .success(let info):
                            print("loading owner success schedule")
                            self.infoOwner = info
                        case .failure:
                            print("loading owner failure")
                        }
                    }
                    print("...... END SettingsView() on appear")
                }
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
            CancelReservationAlert(reservation: self.reservationToDelete, isPresented:  self.$presentCancellationAlert, reservationArray: self.$groupReservation)
                .offset(y:  self.presentCancellationAlert ?  0 : UIScreen.main.bounds.height * 1.5)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        }
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
}

struct ReservationCellView : View {
    var reservation : Reservation
    @State var reservationArray : [Reservation] = []
    @Binding var presentCancellationAlert : Bool
    @Binding var reservationToDelete : Reservation

    var body: some View {
        HStack(alignment: .bottom){
            Text(reservation.userName)
                .font(.system(size: 24))
                .bold()
                .frame(width: UIScreen.main.bounds.width * 0.5)
                .padding(.trailing, 20)
            Spacer()
            Image(systemName: "phone.fill.arrow.up.right")
                .font(.system(size: 40))
                .foregroundColor(Color(#colorLiteral(red: 0.8770651817, green: 0.5741621852, blue: 0.3193312883, alpha: 1)))
                .onTapGesture {
                    FireBaseMethods().getUserInfo(mail: self.reservation.email){ result in
                        switch result {
                        case .success(let userInfo):
                            PushNotificationSender().sendPushNotification(to: userInfo.token, title: "Ton Barber préféré", body: "Oublie pas ton rdv de \(self.reservation.time) le \(self.reservation.intDay)\(self.reservation.month)")
                        case .failure:
                            print("FAILURE GETTING TOKEN FOR NOTIFICATION SENDING")
                        }
                    }
            }
            Spacer()
            Image(systemName: "xmark.square.fill")
                .font(.system(size: 40))
                .foregroundColor(.red)
                .onTapGesture {
                    self.reservationToDelete = self.reservation
                    self.presentCancellationAlert.toggle()
                }
        }
        .frame(width: UIScreen.main.bounds.width * 0.7 ,height: UIScreen.main.bounds.height * 0.06)
    }
}

struct TimeCellView : View {
    var time : String
    var body: some View {
        VStack {
            HStack {
                Text(time)
                    .font(.system(size: 40))
                    .bold()
                    .foregroundColor(Color(#colorLiteral(red: 0.8770651817, green: 0.5741621852, blue: 0.3193312883, alpha: 1)))
                Spacer()
            }
                .padding(15)
                .overlay(Color(#colorLiteral(red: 0.8708441257, green: 0.7582760453, blue: 0.6626496315, alpha: 1)).frame(width: UIScreen.main.bounds.width * 0.7, height: 3).cornerRadius(5).offset(y: 30))
        }
    }
}
