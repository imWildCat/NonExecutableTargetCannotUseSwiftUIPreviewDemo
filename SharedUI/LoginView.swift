// Note:
// The following code is copied from https://www.hackingwithswift.com/forums/swiftui/my-preview-isn-t-working-what-should-i-do-to-fix-it/6969
// Different license may apply.

import SwiftUI

struct LoginView: View {
  var body: some View {
    LogView()
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}

struct LogView: View {
  @StateObject var model = ModelData()

  var body: some View {
    VStack {
      Spacer(minLength: 0)

      EmptyView()
        .padding(.horizontal)
        .padding(.vertical, 20)
        .background(Color.white.opacity(0.2))
        .cornerRadius(30)

      VStack(spacing: 4) {
        HStack(spacing: 0) {
          Text("Food = ")
            .font(.system(size: 35))
            .foregroundColor(Color.white)
            .fontWeight(.semibold)

          Text("Life.")
            .font(.system(size: 35))
            .foregroundColor(Color.white)
            .fontWeight(.bold)
        }

        Text("Let order some deliciousness!")
      }
      .padding(.top)

      VStack(spacing: 20) {
        CustomTextField(image: "envelope", placeHolder: "Email", txt: $model.email)

        CustomTextField(image: "lock", placeHolder: "Password", txt: $model.password)
      }
      .padding(.top)

      Button(action: /*@START_MENU_TOKEN@*/ {}/*@END_MENU_TOKEN@*/, label: {
        Text("Login")
          .fontWeight(.bold).foregroundColor(Color("Blue")).padding(.vertical).frame(width: UIScreen.main.bounds.width - 30)
          .background(Color.white).clipShape(Capsule())

      })

      HStack(spacing: 12) {
        Text("Don't have an account?").foregroundColor(Color.white.opacity(0.7))

        Button(action: { model.isSignUp.toggle() }) {
          Text("Sign Up Now").fontWeight(.bold).foregroundColor(.white)
        }
      }.padding(.top, 25)

        .padding(.bottom, 1)

      Button(action: {
        model.resetPassword()
      }) {
        Text("Forget Password?").fontWeight(.bold).foregroundColor(.white)
      }
      .padding(.top, 20)

      Divider()

      Spacer(minLength: 0)
    }
    .background(LinearGradient(gradient: Gradient(colors: [Color("Blue"), Color("Purple")]), startPoint: .top, endPoint: .bottom))
//    .ignoresSafeArea(.all, edges: .all)
//    .fullScreenCover(isPresented: $model.isSignUp) {
//      SignUpView(model: model)
//    }
    alert(isPresented: $model.isLinkSend, content: {
      Alert(title: Text("Message"), message: Text("Password reset link has been sent."), dismissButton: .destructive(Text("Ok")))
    })
  }
}

struct SignUpView: View {
  @ObservedObject var model: ModelData

  var body: some View {
    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
      VStack {
        Spacer(minLength: 0)

        EmptyView()
          .padding(.horizontal)
          .padding(.vertical, 20)
          .background(Color.white.opacity(0.2))
          .cornerRadius(30)

        VStack(spacing: 4) {
          HStack(spacing: 0) {
            Text("New ")
              .font(.system(size: 35))
              .foregroundColor(Color.white)
              .fontWeight(.semibold)

            Text("Account")
              .font(.system(size: 35))
              .foregroundColor(Color.white)
              .fontWeight(.bold)
          }

          Text("Create An Account!")
        }
        .padding(.top)

        VStack(spacing: 20) {
          CustomTextField(image: "envelope", placeHolder: "Email", txt: $model.email_SignUp)

          CustomTextField(image: "lock", placeHolder: "Password", txt: $model.password_SignUp)

          CustomTextField(image: "lock", placeHolder: "Re - Enter Password", txt: $model.reEnterPassword)
        }
        .padding(.top)

        Button(action: /*@START_MENU_TOKEN@*/ {}/*@END_MENU_TOKEN@*/, label: {
          Text("Sign Up")
            .fontWeight(.bold).foregroundColor(Color("Blue")).padding(.vertical).frame(width: UIScreen.main.bounds.width - 30)
            .background(Color.white).clipShape(Capsule())

        })

        Spacer(minLength: 0)
      }

      Button(action: {
        model.isSignUp.toggle()
      }, label: {
        Image(systemName: "xmark")
          .padding()
          .foregroundColor(.white)
          .background(Color.black.opacity(0.6)).clipShape(Circle())
      })
        .padding(.trailing)
        .padding(.top, 10)
    }
    .background(LinearGradient(gradient: Gradient(colors: [Color("Blue"), Color("Purple")]), startPoint: .top, endPoint: .bottom))
//    .ignoresSafeArea(.all, edges: .all)
  }
}

struct CustomTextField: View {
  var image: String
  var placeHolder: String
  @Binding var txt: String
  var body: some View {
    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
      Image(systemName: image).font(.system(size: 24)).foregroundColor(Color("Purple")).frame(width: 60, height: 60).background(Color.white).clipShape(Circle())

      ZStack {
        if placeHolder == "Password" || placeHolder == "Re-Enter" { SecureField(placeHolder, text: $txt) } else {
          TextField(placeHolder, text: $txt)
        }
      }.padding(.horizontal).padding(.leading, 65).frame(height: 60).background(Color.white.opacity(0.2)).clipShape(Capsule())
    }.padding(.horizontal)
  }
}

class ModelData: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var isSignUp = false
  @Published var email_SignUp = ""
  @Published var password_SignUp = ""
  @Published var reEnterPassword = ""
  @Published var resetEmail = ""
  @Published var isLinkSend = false

  func resetPassword() {
    let alert = UIAlertController(title: "Reset You Password", message: "Enter your email to reset your password.", preferredStyle: .alert)

    alert.addTextField { password in

      password.placeholder = "Email"
    }
    let proceed = UIAlertAction(title: "Reset", style: .default)

    resetEmail = alert.textFields![0].text!

    isLinkSend.toggle()

    let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)

    alert.addAction(proceed)
    alert.addAction(cancel)

//    UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
  }
}
