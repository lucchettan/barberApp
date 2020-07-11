//
//  ClientSettingsView.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 01/07/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import SwiftUI

struct ClientSettingsView: View {
    @Binding var userInfo: UserInfo

    @Binding var isPresented : Bool
    @Binding var presentModifyModal : Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Modifier")
                    .font(.system(size: 40))
                    .bold()
                    .foregroundColor(Color(#colorLiteral(red: 0.8770468831, green: 0.5742071271, blue: 0.3142549992, alpha: 1)))
                Spacer()
                Image(systemName: "xmark.circle")
                    .foregroundColor(Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1)))
                    .font(.system(size: 40))
                    .onTapGesture {
                        self.presentModifyModal.toggle()
                        self.isPresented.toggle()
                }
            }
            .padding(.trailing, 45)
            .padding(.leading, 45)
            VStack(spacing: 15){
                HStack{
                    Text(self.userInfo.email)
                        .bold()
                        .underline()
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 24))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    Spacer()
                }
                ZStack{
                    HStack{
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color(#colorLiteral(red: 0.4215126038, green: 0.354411304, blue: 0.3556520939, alpha: 1)))
                        TextField(self.userInfo.name, text: self.$userInfo.name)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 20))
                            .foregroundColor(Color(#colorLiteral(red: 0.4215126038, green: 0.354411304, blue: 0.3556520939, alpha: 1)))

                    }
                }
                .padding(15)
                .background(Color(#colorLiteral(red: 0.9896113276, green: 0.980209291, blue: 0.9757992625, alpha: 1)).opacity(0.55))
                .cornerRadius(15)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 15)
                
                ZStack{
                    HStack{
                        Image(systemName: "phone.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color(#colorLiteral(red: 0.4215126038, green: 0.354411304, blue: 0.3556520939, alpha: 1)))
                        TextField(self.userInfo.phoneNumber, text: self.$userInfo.phoneNumber)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 20))
                            .foregroundColor(Color(#colorLiteral(red: 0.4215126038, green: 0.354411304, blue: 0.3556520939, alpha: 1)))
                            .keyboardType(.phonePad)
                    }
                }
                .padding(15)
                .background(Color(#colorLiteral(red: 0.9896113276, green: 0.980209291, blue: 0.9757992625, alpha: 1)).opacity(0.55))
                .cornerRadius(15)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 15)
                Button(action: {
                    self.presentModifyModal.toggle()
                    FireBaseMethods().modifyInfoUser(info: self.userInfo)
                }){
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.height * 0.05)
                        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 15)
                        .foregroundColor(Color(#colorLiteral(red: 0.8770468831, green: 0.5742071271, blue: 0.3142549992, alpha: 1)))
                        .overlay(
                            Image(systemName:"checkmark")
                                .edgesIgnoringSafeArea(.all)
                                .font(.system(size: 50))
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                .offset(y: -UIScreen.main.bounds.height * 0.01)
                    )
                }
                .padding(.top, 5)
            }
            .padding(25)
            .frame(width: UIScreen.main.bounds.width * 0.80, height: UIScreen.main.bounds.height * 0.4)
            .cornerRadius(15)
            .background(
                Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1))
                    .cornerRadius(15)
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 15)
            )
            .keyboardAware()
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

//struct ClientSettingsView_Previews: PreviewProvider {
//    @State static var value = false
//
//    static var previews: some View {
//        ClientSettingsView(isPresented: $value, presentModifyModal: $value)
//    }
//}
