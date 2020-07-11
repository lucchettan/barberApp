//
//  SettingsView.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 20/05/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct ModifySettingsView: View {
    @Binding var infoOwner : UserInfo

    @Binding var presentModifyModal : Bool
    @Binding var isPresented : Bool
    
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
                ZStack{
                    HStack{
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color(#colorLiteral(red: 0.4215126038, green: 0.354411304, blue: 0.3556520939, alpha: 1)))
                        TextField(self.infoOwner.name, text: self.$infoOwner.name)
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
                        Image(systemName: "mappin.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color(#colorLiteral(red: 0.4215126038, green: 0.354411304, blue: 0.3556520939, alpha: 1)))
                        TextField(self.infoOwner.adress, text: self.$infoOwner.adress)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
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
                        TextField(self.infoOwner.phoneNumber, text: self.$infoOwner.phoneNumber)
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
                
                ZStack{
                    HStack{
                        Image("barberseat")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("Sieges(s):")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(Color(#colorLiteral(red: 0.4529437423, green: 0.3858019412, blue: 0.3870281875, alpha: 1)))
                        Spacer()
                        
                        Button (action: {
                            if  self.infoOwner.seatQuantity >= 2 {
                                self.infoOwner.seatQuantity -= 1
                            }
                        }){
                            Image(systemName: "minus.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Color(#colorLiteral(red: 0.8770468831, green: 0.5742071271, blue: 0.3142549992, alpha: 1)))
                        }
                        Text(String(self.infoOwner.seatQuantity))
                            .bold()
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .font(.system(size: 30))
                            .bold()
                        Button (action: {
                            if  self.infoOwner.seatQuantity <= 15 {
                                self.infoOwner.seatQuantity += 1
                            }
                        }){
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Color(#colorLiteral(red: 0.8770468831, green: 0.5742071271, blue: 0.3142549992, alpha: 1)))
                        }
                    }
                }
                .padding(15)
                .frame(width: UIScreen.main.bounds.width * 0.675)
                .background(Color(#colorLiteral(red: 0.9896113276, green: 0.980209291, blue: 0.9757992625, alpha: 1)).opacity(0.55))
                .cornerRadius(15)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 15)
                Button(action: {
                    self.presentModifyModal.toggle()
                    FireBaseMethods().modifyInfoOwner(info: self.infoOwner)
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
            .frame(width: UIScreen.main.bounds.width * 0.80, height: UIScreen.main.bounds.height * 0.55)
            .cornerRadius(15)
            .background(
                Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1))
                    .cornerRadius(15)
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 15)
            )
        }
        .frame(height: UIScreen.main.bounds.height * 0.35)
        .onTapGesture {
            UIApplication.shared.endEditing()
            
        }

        .keyboardAware()
    }
}
