import Foundation
import UIKit
import Alamofire


class SettingsViewController: UIViewController {
    @IBOutlet weak var telegramNicknameField: UITextField!
    @IBOutlet weak var vkNicknameField: UITextField!
    @IBOutlet weak var contactsSwitch: UISwitch!
    @IBOutlet weak var eventsSyncSwitch: UISwitch!
    
    override func viewDidLoad() {
        guard let uniqueName = UserDefaults.standard.string(forKey: "unique_name") else {
            showAlert(title: "Error", message: "Cannot find user data. Please, login again.")
            return
        }
        
        
        DispatchQueue.global().async {
            guard let url = RequestRoutes.getRoute(.getUser(uniqueName)) else {return}
            print(url)
            AF.request(url, method: .get).responseDecodable(of: User.Response.self) { response in
                
                switch response.result {
                case .success:
                    DispatchQueue.main.async {
                        guard let user = response.value else { return }
                        if let tg = user.telegram, !tg.isEmpty {
                            self.telegramNicknameField.text = tg
                        }
                        
                        if let vk = user.vk, !vk.isEmpty {
                            self.vkNicknameField.text = vk
                        }
                        
                        if let isShowContacts = user.isShowContacts {
                            self.contactsSwitch.isOn = !isShowContacts
                        }
                    }
                    
                case .failure(_):
                    self.showAlert(title: "Error", message: "Cannot find user data. Please, login again.")
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.title = "Настройки"
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        guard let uniqueName = UserDefaults.standard.string(forKey: "unique_name") else {
            showAlert(title: "Error", message: "Cannot find user data. Please, login again.")
            return
        }
        
        let body = UserDataModel(uniqueName: uniqueName, vk: vkNicknameField.text, telegram: telegramNicknameField.text, isShowContacts: !contactsSwitch.isOn)
        
        DispatchQueue.global().async {
            guard let url = RequestRoutes.getRoute(.updateUser(uniqueName)) else {return}
            
            AF.request(url, method: .post, parameters: body).response {
                response in
                if let code = response.response?.statusCode, code == 200 {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.showAlert(title: "Error \(String(describing: response.response?.statusCode))", message: "Error occured while connecting to server.")
                }
            }
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "unique_name")
        self.navigationController?.setViewControllers([AuthViewController()], animated: true)
        
    }
}


struct UserDataModel: Codable {
    var uniqueName: String?
    var name: String? = nil
    var email: String? = nil
    var vk: String?
    var telegram: String?
    var isShowContacts: String?
    
    init(uniqueName: String, vk: String?, telegram: String?, isShowContacts:Bool) {
        self.uniqueName = uniqueName
        self.vk = vk
        self.telegram = telegram
        self.isShowContacts = "\(String(describing: isShowContacts))"
    }
}
