//
//  SeeSettingsView.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 01/07/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct SeeSettingsView: View {
    @Binding var infoOwner : UserInfo
    
    @State var presentModifyModal = false
    @Binding var isPresented : Bool
    @Binding var isLoggedIn : Bool

    var body: some View {
        ZStack {
            ModifySettingsView(infoOwner: self.$infoOwner, presentModifyModal: self.$presentModifyModal, isPresented: self.$isPresented)
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
                        Text(infoOwner.name)
                            .bold()
                            .underline()
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.675)
                    HStack{
                        Image(systemName: "mappin.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color(#colorLiteral(red: 0.1999336779, green: 0.1053786352, blue: 0.1077213809, alpha: 1)))
                        Text(infoOwner.adress)
                            .bold()
                            .underline()
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.675)
                    HStack{
                        Image(systemName: "phone.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color(#colorLiteral(red: 0.1999336779, green: 0.1053786352, blue: 0.1077213809, alpha: 1)))
                        Text(infoOwner.phoneNumber)
                            .bold()
                            .underline()
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.675)
                    HStack{
                        Image("barberseat")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("Sieges(s):")
                            .font(.system(size: 24))
                            .bold()
                            .foregroundColor(Color(#colorLiteral(red: 0.1999336779, green: 0.1053786352, blue: 0.1077213809, alpha: 1)))
                        Text(String(infoOwner.seatQuantity))
                            .bold()
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .font(.system(size: 30))
                            .bold()
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
                    .padding(.bottom)
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
                .padding(25)
                .frame(width: UIScreen.main.bounds.width * 0.80, height: UIScreen.main.bounds.height * 0.5)
                .cornerRadius(15)
                .background(
                    Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1))
                        .cornerRadius(15)
                        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 15)
                )
            }
            .offset(x: self.presentModifyModal ? -UIScreen.main.bounds.width : 0)
        }

        .frame(height: UIScreen.main.bounds.height * 0.5)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
    }
}


