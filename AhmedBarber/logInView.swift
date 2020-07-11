//
//  logInView.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 30/06/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import SwiftUI
import Firebase

struct logInView: View {
    @State var mailInput = ""
    @State var passwordInput = ""
    @State var presentSignInForm = false
    @Binding var isLoggedIn : Bool
    @State private var offsetValue: CGFloat = 0.0
    @State var wrongLogIn = false
    @State var displayForgotPassword = false

    
    //    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        ZStack{
            BackgroundBrown()
            VStack {
                Spacer()
                Text("Chez Ahmed")
                    .font(.system(size: 60))
                    .bold()
                    .foregroundColor(Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1)))
                    .padding(.bottom, UIScreen.main.bounds.height * 0.05)
                ZStack{
                    VStack(spacing: 10){
                        Text("Bienvenue sur l'app\nde ton barber préféré!")
                            .bold()
                            .foregroundColor(Color(#colorLiteral(red: 0.8770468831, green: 0.5742071271, blue: 0.3142549992, alpha: 1)))
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 24))
                        Text("On se retrouve à Persan\n152 Avenue Jacques Vogt")
                            .bold()
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 24))
                    }
                    .padding(15)
                    .background(Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1)).opacity(0.8).background(Blur()))
                    .cornerRadius(15)
                }.padding(.top, -20)
                Spacer()
                VStack(spacing: 15){
                    ZStack{
                        HStack{
                            Image(systemName: "envelope.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(Color(#colorLiteral(red: 0.4215126038, green: 0.354411304, blue: 0.3556520939, alpha: 1)))
                            TextField("Adresse Email", text: $mailInput)
                                .multilineTextAlignment(.center)
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
                            Image(systemName: "lock.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(Color(#colorLiteral(red: 0.4215126038, green: 0.354411304, blue: 0.3556520939, alpha: 1)))
                            SecureField("Mot de passe", text: $passwordInput)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 20))
                                .foregroundColor(Color(#colorLiteral(red: 0.4215126038, green: 0.354411304, blue: 0.3556520939, alpha: 1)))
                        }
                    }
                    .padding(15)
                    .background(Color(#colorLiteral(red: 0.9896113276, green: 0.980209291, blue: 0.9757992625, alpha: 1)).opacity(0.55))
                    .cornerRadius(15)
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 15)
                    
                    
                    Button(action: {
                        Auth.auth().signIn(withEmail: self.mailInput.lowercased(), password: self.passwordInput.lowercased()) {(authData, error) in
                            if error != nil {
                                print(error)
                                print("sign in FAILED")
                                self.wrongLogIn = true
                            } else {
                                print("error == nil, sign in successfully done after signIn()")
                                self.isLoggedIn.toggle()
                                print("logIn()  isSignedIs ==" + self.isLoggedIn.description)
                            }
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
                    Button(action: {
                        Auth.auth().sendPasswordReset(withEmail: self.mailInput) { error in
                            if let error = error {
                                print(error.localizedDescription)
                                return
                            }
                        }
                        self.displayForgotPassword = true
                    }){
                        Text("Mot de passe oublié?")
                            .underline()
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(width: UIScreen.main.bounds.width * 0.67)
                .padding(20)
                .padding(.top, 25)
                .background(Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1)).opacity(1)).cornerRadius(15)
                .overlay(
                    Image(systemName:"person.crop.circle.fill")
                        .resizable()
                        .foregroundColor(Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1)).opacity(1))
                        .background(Circle().frame(width: 50, height: 50).foregroundColor(Color(#colorLiteral(red: 0.1862579584, green: 0.1104152128, blue: 0.1121566221, alpha: 1))))
                        .clipShape(Circle())
                        .frame(width:65, height: 65)
                        .offset(y: UIScreen.main.bounds.width * 0.67 * -0.53)
                )
                .keyboardAware()

                Text("Marre de faire la queue?")
                    .bold()
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                    .opacity(0.7)
                    .padding(.bottom, -10)
                Button(action: {self.presentSignInForm.toggle()}){
                    Text("Inscris toi en cliquant ici!")
                        .bold()
                        .underline()
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .opacity(self.presentSignInForm ? 0 : 1)
                        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                }
                .padding(.top, 15)
                Spacer()
            }
                .offset(y: self.presentSignInForm ? -UIScreen.main.bounds.height * 0.4 : 0)
                .rotation3DEffect(Angle(degrees: self.presentSignInForm ? 20 : 0), axis: (x: 20.0, y: 0, z: 0))
                .scaleEffect(self.presentSignInForm ? 0.8 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))

            SignInForm(isPresented: self.$presentSignInForm)
                .offset(y: self.presentSignInForm ? -UIScreen.main.bounds.height * 0.05 :  UIScreen.main.bounds.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .background(Blur().opacity(self.presentSignInForm ? 0.6 : 0).blur(radius: 30).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            WrongLogIn(isPresented: self.$wrongLogIn)
                .offset(y: self.wrongLogIn ?  0 : UIScreen.main.bounds.height * 1.5)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .background(Blur().opacity(self.wrongLogIn ? 0.6 : 0).blur(radius: 30).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            ForgotPasswordAlert(isPresented: self.$displayForgotPassword)
                .offset(y: self.displayForgotPassword ?  0 : UIScreen.main.bounds.height * 1.5)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .background(Blur().opacity(self.displayForgotPassword ? 0.6 : 0).blur(radius: 30).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct logInView_Previews: PreviewProvider {
    @State static var value = true
    @State static var revalue = false

    static var previews: some View {
        logInView(isLoggedIn: $value)
    }
}
extension logInView {
    func keyboardSensible(_ offsetValue: Binding<CGFloat>) -> some View {

      return self
          .padding(.bottom, offsetValue.wrappedValue)
          .animation(.spring())
          .onAppear {
          NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in

              let keyWindow = UIApplication.shared.connectedScenes
                  .filter({$0.activationState == .foregroundActive})
                  .map({$0 as? UIWindowScene})
                  .compactMap({$0})
                  .first?.windows
                  .filter({$0.isKeyWindow}).first

              let bottom = keyWindow?.safeAreaInsets.bottom ?? 0

              let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
              let height = value.height

              offsetValue.wrappedValue = height - bottom
          }

          NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
              offsetValue.wrappedValue = 0
          }
      }
    }
}


struct WrongLogIn : View {
    @Binding var isPresented : Bool
    var body: some View {
        VStack{
            ZStack{
                VStack(spacing: 15){
                    Text("Identifiants incorrects")
                        .bold()
                        .font(.system(size: 24))
                        .foregroundColor(Color(#colorLiteral(red: 0.1862579584, green: 0.1104152128, blue: 0.1121566221, alpha: 1)))
                    Text("Veuillez vérifier vos identifiants.")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    HStack {
                        Button(action: {self.isPresented = false }){
                            Image(systemName: "arrow.uturn.left.square")
                                .font(.system(size: 40))
                                .foregroundColor(Color(#colorLiteral(red: 0.8676875234, green: 0.5789795518, blue: 0.314088136, alpha: 1)))
                        }.padding(.top, 15)
                    }
                }
                .padding(20)
                .background(Color(#colorLiteral(red: 0.8872029185, green: 0.7698594928, blue: 0.6743299365, alpha: 1)).cornerRadius(15))
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: -10, y: 15)
            }
            .fixedSize(horizontal: false, vertical: true)
            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.45)
        }
    }
}
