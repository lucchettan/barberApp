//
//  DayCell.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 30/06/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import SwiftUI

struct DayCell : View {
    @Binding var selected : Int
    var selectValue : Int
    @Binding var day : Day
    var widthSize = 0
    var body: some View {
        Button(action: {
            self.selected = self.selectValue
        }) {
            VStack {
                    Text(day.intDay + " " + day.month)
                        .font(.system(size: 30))
                        .lineLimit(1)
                        .foregroundColor(Color(#colorLiteral(red: 0.8859863877, green: 0.7683095336, blue: 0.674552381, alpha: 1)))
                    Rectangle()
                        .frame(width: selected == selectValue ? UIScreen.main.bounds.width * 0.15 : 0 , height: selected == selectValue ? 2 : 0)
                        .foregroundColor(Color(#colorLiteral(red: 0.8770651817, green: 0.5741621852, blue: 0.3193312883, alpha: 1)))
                        .offset(y: -15)
            }
            .padding(.bottom, selected == selectValue ? -5 : -15)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        }
            .frame(width: UIScreen.main.bounds.width * 0.25)
            .background(Color.white.opacity(selected == selectValue ? 0.75 : 0.55).background(Blur()))
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: -5, y: 15)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .onAppear {
                print("DayCell() on appear......")
                FireBaseMethods().loadReservationsOfADay(day: self.day){ result in
                    switch result {
                    case .success(let foundedReservations):
                        self.day.reservations = foundedReservations
                        print("On \(self.day.intDay) \(self.day.month) you have: \(self.day.reservations!.description)")
                    case .failure(let err):
                        print("function chargement reservations du jour echouee")
                        print(err.localizedDescription)
                    }
                }
                print(".............end DayCell() on appear")

            }
    }
}

