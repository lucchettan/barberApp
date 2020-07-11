//
//  BackGroundWhite.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 30/06/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import SwiftUI

struct BackGroundWhite: View {
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            VStack{
                HStack {
                    Image("barber-shop")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.87, height: UIScreen.main.bounds.height * 0.45)
                        .blur(radius: 2)
                    Spacer()
                }.offset(x: -UIScreen.main.bounds.width * 0.35)
            }
            VStack{
                HStack {
                    Spacer()
                    Image("barber")
                        .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.5)
                        .blur(radius: 4)
                }.offset(x: UIScreen.main.bounds.width * 0.35, y: -UIScreen.main.bounds.height * 0.1)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct BackGroundWhite_Previews: PreviewProvider {
    static var previews: some View {
        BackGroundWhite()
    }
}
