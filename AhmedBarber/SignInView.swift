//
//  SignInView.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 20/05/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @Binding var pushed: Bool
    
    @State var name = ""
    @State var phone = ""
    @State var email = ""
    @State var password = ""
    @State var checkPassword = ""

    var body: some View {
        VStack (spacing: 10){
            VStack(alignment: .center, spacing: 10){
                Text("Welcome!")
                TextField("name", text: $name)
                    .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .center)
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width * 0.9 , height: 2, alignment: .center)
                    .foregroundColor(Color.gray)
                TextField("Phone number", text: $phone)
                    .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .center)
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width * 0.9 , height: 2, alignment: .center)
                    .foregroundColor(Color.gray)
            }
            VStack(alignment: .center, spacing: 10 ){
                TextField("Email", text: $email)
                    .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .center)
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width * 0.9 , height: 2, alignment: .center)
                    .foregroundColor(Color.gray)
                TextField("Password", text: $password)
                    .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .center)
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width * 0.9 , height: 2, alignment: .center)
                    .foregroundColor(Color.gray)
                TextField("Verify password", text: $checkPassword)
                    .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .center)
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width * 0.9 , height: 2, alignment: .center)
                    .foregroundColor(Color.gray)
            }
            Button("Validate"){
                self.pushed = false
            } .navigationBarTitle("Sign In")
            
        }
    }
}

//
