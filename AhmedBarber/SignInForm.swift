//
//  SignInForm.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 30/06/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct SignInForm: View {
    @State var nameInput = ""
    @State var phoneInput = ""
    @State var mailInput = ""
    @State var passwordInput = ""
    @State var checkPasswordInput = ""
    @Binding var isPresented : Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "xmark.circle")
                    .foregroundColor(Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1)))
                    .font(.system(size: 40))
                    .onTapGesture {
                        self.isPresented.toggle()
                }
            }
            .padding(.trailing, 40)
            .padding(.bottom, 0)
            .padding(.top, 90)
            VStack(spacing: 15){
                HStack {
                    Text("Crée ton compte")
                        .font(.system(size: 30))
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                }
                ZStack{
                    HStack{
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color(#colorLiteral(red: 0.4215126038, green: 0.354411304, blue: 0.3556520939, alpha: 1)))
                        TextField("Prénom", text: $nameInput)
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
                        TextField("0612345678", text: $phoneInput)
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
                        Image(systemName: "envelope.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color(#colorLiteral(red: 0.4215126038, green: 0.354411304, blue: 0.3556520939, alpha: 1)))
                        TextField("Adresse email", text: $mailInput)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 20))
                            .foregroundColor(Color(#colorLiteral(red: 0.4215126038, green: 0.354411304, blue: 0.3556520939, alpha: 1)))
                            .keyboardType(.emailAddress)
                        
                        
                    }
                }
                .padding(15)
                .background(Color(#colorLiteral(red: 0.9896113276, green: 0.980209291, blue: 0.9757992625, alpha: 1)).opacity(0.55))
                .cornerRadius(15)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 15)
                ZStack{
                    HStack{
                        Image(systemName: "lock.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color(#colorLiteral(red: 0.4215126038, green: 0.354411304, blue: 0.3556520939, alpha: 1)))
                        SecureField("Mot de passe", text: $passwordInput)
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
                        Image(systemName: "lock.circle")
                            .font(.system(size: 40))
                            .foregroundColor(Color(#colorLiteral(red: 0.4215126038, green: 0.354411304, blue: 0.3556520939, alpha: 1)))
                        SecureField("Vérification", text: $checkPasswordInput)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 20))
                            .foregroundColor(Color(#colorLiteral(red: 0.4215126038, green: 0.354411304, blue: 0.3556520939, alpha: 1)))
                        
                    }
                }
                .padding(15)
                .background(Color(#colorLiteral(red: 0.9896113276, green: 0.980209291, blue: 0.9757992625, alpha: 1)).opacity(0.55))
                .cornerRadius(15)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 15)
                
                Button(action: {
                    if self.nameInput.count > 3 {
                        if self.phoneInput.count >= 9 {
                            if self.passwordInput.count > 6 {
                                if self.passwordInput == self.checkPasswordInput {
                                    Auth.auth().createUser(withEmail: self.mailInput.lowercased(), password: self.passwordInput.lowercased()) {(authData, error) in
                                        if error != nil {
                                            //
                                        } else {
                                            print("User registred...")
                                            FireBaseMethods().createUser(email: self.mailInput.lowercased(), name: self.nameInput, phoneNumber: self.phoneInput, token: PushNotificationManager().getFCMToken())
                                            let pushManager = PushNotificationManager()
                                            pushManager.registerForPushNotifications()
                                            print("User created...")
                                        }
                                    }
                                    self.isPresented.toggle()
                                } else {
                                    print("the passwords are the problem")
                                }
                            } else {
                                print("password is the problem")
                            }
                        } else {
                            print("phone is the problem")
                        }
                    } else {
                        print("name is the problem")
                    }
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
//                .padding(.top,30)
                Text("Valides tes informations")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }
            .padding(25)
            .frame(width: UIScreen.main.bounds.width * 0.80, height: UIScreen.main.bounds.height * 0.8)
            .cornerRadius(15)
            .background(
                Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1))
                    .cornerRadius(15)
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 15)
            )
                .overlay(
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .foregroundColor(Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1)))
                        .background(Circle().frame(width: 50, height: 50).foregroundColor(Color(#colorLiteral(red: 0.1862579584, green: 0.1104152128, blue: 0.1121566221, alpha: 1))))
                        .clipShape(Circle())
                        .frame(width:65, height: 65)
                        .offset(y: -(UIScreen.main.bounds.height * 0.4))
            )
        }
        .keyboardAware()
        .onTapGesture {
            UIApplication.shared.endEditing()
            
        }
    }
}

struct SignInForm_Previews: PreviewProvider {
    @State static var value = true
    @State static var revalue = false
    static var previews: some View {
        SignInForm(isPresented: $value)
    }
}
