import UIKit
import HSEAuth
import JWTDecode
import Alamofire
import SnapKit

class AuthViewController: UIViewController
{
    let clientId = "b2738476-352a-432f-8a0e-a3fc860c7a9b"
    
    let model: AuthManagerProtocol = AuthModel(
        with: "b2738476-352a-432f-8a0e-a3fc860c7a9b",
        host: "auth.hse.ru",
        loginCallback: RedirectCallback(scheme: "ru.schmitzer.hseclubs", host: "auth.hse.ru", path: "/adfs/oauth2/callback"),
        logoutCallback: RedirectCallback(scheme: "https", host: "", path: ""))
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "HSE Clubs"
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if checkLoggedIn() {
            moveToApp()
        }
        
        view.backgroundColor = .white
        let logo = UIImageView(image: UIImage(named: "logo")?.resize(withSize: CGSize(width: 150, height: 150)))
        let loginButton = AuthButton()
        loginButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        loginButton.setTitle("Войти", for: .normal)
        let stack = UIStackView()
        stack.spacing = 20
        stack.axis = .vertical
        stack.addArrangedSubview(logo)
        stack.addArrangedSubview(loginButton)
        view.addSubview(stack)
        view.addSubview(titleLabel)
        
        stack.snp.makeConstraints {make in
            make.center.equalTo(view)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view)
        }
    }
    
    func checkLoggedIn() -> Bool {
        if UserDefaults.standard.string(forKey: "unique_name") != nil {
            return true
        }
        
        return false
    }
    
    @objc func signIn(sender: UIButton) {
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
                    }
                case let .failure(error):
                    print(error)
                    self.showAlert(title: "Error", message: "Error getting data.")
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
                showAlert(title: "Error", message: "Error getting data.")
                return nil
            }
            
            user.Name = commonName
            user.Email = email
            user.UniqueName = uniqueName
                        
            print("decoded data")
            return user
            
        } catch {
            showAlert(title: "Error", message: "Error parsing token.")
        }
        
        return nil
    }
    
    func loginUser(body: Auth.Request) {
        guard let url = RequestRoutes.getRoute(.loginUser) else {return}
        print(url)
        AF.request(url, method: .post, parameters: body).response {response in
            if let code = response.response?.statusCode, code == 200 {
                UserDefaults.standard.set(body.UniqueName, forKey: "unique_name")
                self.moveToApp()
            } else {
                self.showAlert(title: "Error", message: "Error occured while connecting to server.")
            }
        }
    }
    
    func moveToApp() {
        let tabBarController = SceneDelegate.createTabController()!
        self.navigationController?.setViewControllers([tabBarController], animated: true)
    }
    

}


extension UIViewController {
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
