//
//  ClientSeeSettingsView.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 01/07/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct ClientSeeSettingsView: View {
    @State var  userInfo = UserInfo(email: "", name: "", phoneNumber: "", token: "")

    @State var presentModifyModal = false
    @Binding var isPresented : Bool
    @Binding var isLoggedIn : Bool
    var body: some View {
        ZStack {
            ClientSettingsView(userInfo: self.$userInfo, isPresented: $isPresented, presentModifyModal: $presentModifyModal)
                .offset(x: self.presentModifyModal ? 0 : UIScreen.main.bounds.width)
            
            VStack {
                HStack {
                    Text("Settings")
                        .font(.system(size: 40))
                        .bold()
                        .foregroundColor(Color(#colorLiteral(red: 0.8770468831, green: 0.5742071271, blue: 0.3142549992, alpha: 1)))
                    Spacer()
                    Image(systemName: "xmark.circle")
                        .foregroundColor(Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1)))
                        .font(.system(size: 40))
                        .onTapGesture {
                            self.isPresented.toggle()
                    }
                }
                .padding(.trailing, 45)
                .padding(.leading, 45)
                VStack(spacing: 15){
                    HStack{
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color(#colorLiteral(red: 0.1999336779, green: 0.1053786352, blue: 0.1077213809, alpha: 1)))
                        Text(self.userInfo.name)
                            .bold()
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 20))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        Spacer()
                        
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.675)
                    HStack{
                        Image(systemName: "envelope.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color(#colorLiteral(red: 0.1999336779, green: 0.1053786352, blue: 0.1077213809, alpha: 1)))
                        Text(self.userInfo.email)
                            .bold()
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 20))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        Spacer()
                        
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.675)
                    HStack{
                        Image(systemName: "phone.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color(#colorLiteral(red: 0.1999336779, green: 0.1053786352, blue: 0.1077213809, alpha: 1)))
                        Text(self.userInfo.phoneNumber)
                            .bold()
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        Spacer()
                        
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.675)
                    Button(action: {self.presentModifyModal.toggle()}){
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.height * 0.05)
                            .background(Color(#colorLiteral(red: 0.9896113276, green: 0.980209291, blue: 0.9757992625, alpha: 1)).opacity(0.55)).cornerRadius(15)
                            .foregroundColor(.clear)
                            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 15)
                            .overlay(
                                Text("Modifier")
                                    .font(.system(size: 24))
                                    .underline()
                                    .foregroundColor(Color(#colorLiteral(red: 0.3449193835, green: 0.2717259824, blue: 0.2644888163, alpha: 1)))
                        )
                    }
                    HStack{
                        Image(systemName: "person.crop.circle.fill.badge.xmark")
                            .font(.system(size: 40))
                            .foregroundColor(Color(#colorLiteral(red: 0.1999336779, green: 0.1053786352, blue: 0.1077213809, alpha: 1)))
                        Text("Se déconnecter")
                            .bold()
                            .underline()
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1999336779, green: 0.1053786352, blue: 0.1077213809, alpha: 1)))
                        Spacer()
                        
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.675)
                    .onTapGesture {
                        print("Log oFFFFFFFF")
                        do {
                            try Auth.auth().signOut()
                            self.isLoggedIn = false
                        } catch {
                            print("Error signing out")
                        }
                    }
                }
                .padding(UIScreen.main.bounds.width * 0.05)
                .frame(width: UIScreen.main.bounds.width * 0.80, height: UIScreen.main.bounds.height * 0.4)
                .cornerRadius(15)
                .background(
                    Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1))
                        .cornerRadius(15)
                        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 15)
                )
            }
            .offset(x: self.presentModifyModal ? -UIScreen.main.bounds.width : 0)
            
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .onAppear{
            print(" about loading user infos...... with mail \( (Auth.auth().currentUser?.email)!)")
            FireBaseMethods().getUserInfo(mail: (Auth.auth().currentUser?.email)!){ result in
                switch result {
                    case .success(let info):
                        print("loading user success")
                        self.userInfo = info
                        print(self.userInfo)
                    case .failure:
                        print("loading user failure")
                        self.userInfo = UserInfo(email: (Auth.auth().currentUser?.email)!, name: "Error", phoneNumber: "Error", token: "")
                }
            }
        }
    }
}

struct ClientSeeSettingsView_Previews: PreviewProvider {
    @State static var value = false
    static var previews: some View {
        ClientSeeSettingsView(isPresented: $value, isLoggedIn: $value)
    }
}
