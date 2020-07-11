//
//  BookingView.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 20/05/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//
import Foundation
import SwiftUI
import FirebaseAuth

struct BookingView: View {
    @State var selectedDay = 1
    @State var sevenNextDays = get7NextDays()
    @State var selectedSpot = 0
    @State var slotOfTheDay = ["9:00","9:30","10:00","10:30","11:30","12:00","12:30","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00"]
    @State var counter = 2
    @State var presentConfirmationView = false
    @State var presentSeeSettings = false
    @State var userInfo = UserInfo(email: "", name: "", phoneNumber: "", token: "")
    @State var ownerInfo = UserInfo(email: "", name: "", phoneNumber: "", token: "")
    @State var viewState = CGSize.zero
    
    @Binding var isLoggedIn : Bool
    var body: some View {
        ZStack {
            ZStack {
                PlanningController(selectedDay: self.$selectedDay, sevenNextDays: self.$sevenNextDays, presentSeeSettings: $presentSeeSettings)
                VStack {
                    Spacer()
                    ScrollView {
                        GridView(rows: self.sevenNextDays[self.selectedDay - 1 ].availableSpots.count / 2, columns: 2) { row, col in
                            HourCell(selected: self.$selectedSpot, selectValue : (row * 2) + col, hour: self.sevenNextDays[self.selectedDay - 1].availableSpots[(row * 2) + col])
                                .padding(10)
                        }.frame(width: UIScreen.main.bounds.width * 0.75)
                    }
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width * 0.75)
                    .background(Blur().cornerRadius(15).opacity(0.95).background(Color.white.opacity(0.8).blur(radius: 80).cornerRadius(15)))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: -10, y: 15)
                    .frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height * 0.55)
                    .overlay(
                        Button(action: { self.presentConfirmationView.toggle() }){
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.06)
                                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 15)
                                .foregroundColor(Color(#colorLiteral(red: 0.8770468831, green: 0.5742071271, blue: 0.3142549992, alpha: 1)))
                                .overlay(
                                    Text("Confirmer")
                                        .bold()
                                        .font(.system(size: 24))
                                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            )
                        }.offset(y: (UIScreen.main.bounds.height * 0.55) / 1.65)
                    )
                }
                .frame(height: UIScreen.main.bounds.height * 0.75)

            }
            .frame(height: UIScreen.main.bounds.height)
            .offset(y: self.presentSeeSettings ? -UIScreen.main.bounds.height * 0.2 : 0)
            .rotation3DEffect(Angle(degrees: self.presentSeeSettings ? -10 : 0), axis: (x: 10.0, y: 0, z: 0))
            .scaleEffect(self.presentSeeSettings ? 0.9 : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            
            // MARK: Loading variables from Firebase DB
            .onAppear{
                print("onappear start")
                FireBaseMethods().getInfoOwner { result in
                    switch result {
                    case .success(let infoOwner):
                        self.ownerInfo = infoOwner
                    case .failure:
                        print("failure updating ownerInfo")
                    }
                }
                FireBaseMethods().loadReservations(){ (result) in
                    switch result {
                    case .success(var spotsReserved):
                        print("function lancee")
                        self.sevenNextDays[self.selectedDay].reservations = spotsReserved
                        print(spotsReserved)
                        print("selected day (-1)  is : " + self.sevenNextDays[self.selectedDay - 1].intDay)
                        print("array with the filter thing ")
                        spotsReserved.removeAll{($0.intDay != self.sevenNextDays[self.selectedDay - 1].intDay)}
                        spotsReserved.removeAll{$0.month != self.sevenNextDays[self.selectedDay].month}
                        print(spotsReserved )
                        let itemsToMap = spotsReserved.map { ($0.time, 1) }
                        print(itemsToMap)
                        print(self.ownerInfo.seatQuantity)
                        var dictionnary = Dictionary(itemsToMap, uniquingKeysWith: + )
                        for count in dictionnary {
                            if count.value >= self.ownerInfo.seatQuantity {
                                print(count.key)
                                print("...............occurence is........")
                                print(count.value)
                                self.sevenNextDays[self.selectedDay - 1].availableSpots.removeAll{$0 == count.key}
                                print(self.sevenNextDays[self.selectedDay - 1].availableSpots)
                            }
                        }
                    case .failure(let err):
                        print("function echouee")
                        print(err.localizedDescription)
                    }
                }

            }
            if self.presentConfirmationView || self.presentSeeSettings {
                Blur()
                    .edgesIgnoringSafeArea(.all)
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
            ConfirmationAlert(day: sevenNextDays[selectedDay - 1], hour: self.sevenNextDays[self.selectedDay - 1 ].availableSpots[self.selectedSpot], isPresented: $presentConfirmationView)
                .offset(y: presentConfirmationView ?  0 : UIScreen.main.bounds.height * 1.5)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            ClientSeeSettingsView(isPresented: $presentSeeSettings, isLoggedIn: self.$isLoggedIn)
                .background(Blur().blur(radius: 15))
                .offset(y: self.presentSeeSettings ? UIScreen.main.bounds.height * 0.2 : UIScreen.main.bounds.height)
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
            NavigationLink(destination: ContentView(), isActive: self.$isLoggedIn){ EmptyView() }
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





struct HourCell : View {
    @Binding var selected : Int
    var selectValue : Int
    var hour : String
    var body: some View {
        Button(action: {self.selected = self.selectValue}) {
            VStack {
                Text(hour)
                    .font(.system(size: 30))
                    .bold()
                    .lineLimit(1)
                    .foregroundColor(Color(#colorLiteral(red: 0.8859863877, green: 0.7683095336, blue: 0.674552381, alpha: 1)))
                Rectangle()
                    .frame(width: selected == selectValue ? UIScreen.main.bounds.width * 0.15 : 0 , height: selected == selectValue ? 2 : 0)
                    .foregroundColor(Color(#colorLiteral(red: 0.8770651817, green: 0.5741621852, blue: 0.3193312883, alpha: 1)))
                    .offset(y: -15)
            }
            .padding(.top, 15)
            .padding(.bottom, selected == selectValue ? 0 : -5)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        }
        .frame(width: UIScreen.main.bounds.width * 0.25)
        .background(Color.white.opacity(selected == selectValue ? 0.75 : 0.55).background(Blur()))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: -5, y: 15)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
    }
}

//struct BookingView_Previews: PreviewProvider {
//    @State static var value = true
//    static var previews: some View {
//        BookingView(isLoggedIn: $value)
//    }
//}

struct GridView<Content: View>: View{
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack {
                    ForEach(0 ..< self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}
