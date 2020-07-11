//
//  PlanningController.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 01/07/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import SwiftUI

struct PlanningController: View {
    @Binding var selectedDay : Int
    @Binding var sevenNextDays : [Day]
    
    @Binding var presentSeeSettings : Bool
    var body: some View {
        ZStack {
            BackGroundWhite()
            VStack {
                HStack{
                    Spacer()
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1)))
                        .font(.system(size: 40))
                        .onTapGesture {
                            self.presentSeeSettings.toggle()
                    }
                }
                .padding(.trailing, UIScreen.main.bounds.width * 0.08)
                .padding(.top, -45)
                
                HStack{
                    Text("Planning")
                        .foregroundColor(Color(#colorLiteral(red: 0.8770651817, green: 0.5741621852, blue: 0.3193312883, alpha: 1)))
                        .bold()
                        .font(.system(size: 60))
                    Spacer()
                }
                .padding(.leading, UIScreen.main.bounds.width * 0.05)
                .padding(.top, -30)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack (alignment: .center){
                        ForEach((1...self.sevenNextDays.count), id: \.self) {
                            DayCell(selected: self.$selectedDay, selectValue: $0, day: self.$sevenNextDays[$0 - 1])
                        }
                    }
                    .padding(.leading, UIScreen.main.bounds.width * 0.05)
                    .padding(.top, -30)
                    .frame(height: UIScreen.main.bounds.height * 0.12)
                }
                .padding(.top, -30)
                .padding(.bottom, -20)
                
                Spacer()
            }
            .frame(height: UIScreen.main.bounds.height * 0.75)
        }.frame(height: UIScreen.main.bounds.height)

    }
}


