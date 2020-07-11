//
//  ForgotPasswordAlert.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 30/06/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct ForgotPasswordAlert: View {
//    @State var mailInput = ""
    @Binding var isPresented : Bool
    var body: some View {
        VStack(spacing: 15){
            Text("Mot de passe oublié")
                .bold()
                .font(.system(size: 24))
                .foregroundColor(Color(#colorLiteral(red: 0.1862579584, green: 0.1104152128, blue: 0.1121566221, alpha: 1)))
            Text("Un mail vous a été envoyé à l'adresse que vous avez indiqué")
                .bold()
                .font(.system(size: 20))
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .multilineTextAlignment(.center)
//            ZStack{
//                HStack{
//                    TextField("Email", text: $mailInput)
//                        .font(.system(size: 20))
//                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
//                }
//            }
//            .padding(15)
//            .background(Color(#colorLiteral(red: 0.9896113276, green: 0.980209291, blue: 0.9757992625, alpha: 1)).opacity(0.55))
//            .cornerRadius(15)
//            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 15)

                Button(action: {
                    self.isPresented.toggle()
                }){
                    Image(systemName: "checkmark.square")
                        .font(.system(size: 40))
                        .foregroundColor(Color(#colorLiteral(red: 0.8676875234, green: 0.5789795518, blue: 0.314088136, alpha: 1)))
                }.padding(.top, 15)
        }
        .keyboardAware()
        .padding(20)
        .background(Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1)).cornerRadius(15))
        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: -10, y: 15)
        .frame(width: UIScreen.main.bounds.width * 0.85)
    }
}

