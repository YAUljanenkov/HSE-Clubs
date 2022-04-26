import UIKit
import HSEAuth

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
        signIn()
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
                    print(data)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    
    func refreshToken(with token: String) -> JWTResponse {
        let grantType = "refresh_token"
        let body: String = "client_id=\(clientId)&refresh_token=\(token)&grant_type=\(grantType)"
        return makeRequest(url: "https://auth.hse.ru/adfs/oauth2/token/", body: body, method: .post)
    }
    
    enum MethodType {
        case get
        case post
    }
    
    func makeRequest(url: String, body: String, method: MethodType) -> JWTResponse {
        return JWTResponse(accessToken: "", refreshToken: "")
    }
    
}

struct JWTResponse{
    let accessToken: String
    let refreshToken: String? //- опциональное поле
}
