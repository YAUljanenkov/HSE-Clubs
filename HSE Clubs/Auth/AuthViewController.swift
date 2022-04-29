import UIKit
import HSEAuth
import JWTDecode
import Alamofire

class AuthViewController: UIViewController
{
    let clientId = "b2738476-352a-432f-8a0e-a3fc860c7a9b"
    
    let model: AuthManagerProtocol = AuthModel(
        with: "b2738476-352a-432f-8a0e-a3fc860c7a9b",
        host: "auth.hse.ru",
        loginCallback: RedirectCallback(scheme: "ru.schmitzer.hseclubs", host: "auth.hse.ru", path: "/adfs/oauth2/callback"),
        logoutCallback: RedirectCallback(scheme: "https", host: "", path: ""))
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if !checkLoggedIn() {
            signIn()
        } else {
            moveToApp()
        }
    }
    
    func checkLoggedIn() -> Bool {
        if UserDefaults.standard.string(forKey: "unique_name") != nil {
            return true
        }
        
        return false
    }
    
    func signIn() {
        if let context = UIApplication.shared.keyWindow {
            model.authManager = AuthManager(with: context)
        }
        DispatchQueue.global(qos: .utility).async {
            let result = self.model.auth(prefersEphemeralWebBrowserSession: true, login: nil)
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    print("got data")
                    if let request = self.decodeData(data: data) {
                        self.loginUser(body: request)
                        self.moveToApp()
                    }
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    func decodeData(data: AccessTokenResponse) ->  Auth.Request? {
        do {
            let jwt = try decode(jwt: data.idToken)
            var user = Auth.Request()
            
            guard let commonName = jwt.claim(name: "commonname").string,
                  let uniqueName = jwt.claim(name: "unique_name").string,
                  let email = jwt.claim(name: "email").string
            else {
                return nil
            }
            
            user.Name = commonName
            user.Email = email
            user.UniqueName = uniqueName
            
            UserDefaults.standard.set(uniqueName, forKey: "unique_name")
            
            print("decoded data")
            return user
            
        } catch {
            print("error decoding JWT")
        }
        
        return nil
    }
    
    func loginUser(body: Auth.Request) {
        AF.request(RequestRoutes.getRoute(.loginUser), method: .post, parameters: body).response { response in
            print(response)
        }
    }
    
    func moveToApp() {
        let tabBarController = SceneDelegate.createTabController()!
        self.navigationController?.setViewControllers([tabBarController], animated: true)
    }
}
