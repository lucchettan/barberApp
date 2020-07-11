//
//  BackgroundBrown.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 27/06/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import SwiftUI

struct BackgroundBrown: View {
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(#colorLiteral(red: 0.1882352941, green: 0.1098039216, blue: 0.1098039216, alpha: 1)))
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

struct BackgroundBrown_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundBrown()
    }
}
