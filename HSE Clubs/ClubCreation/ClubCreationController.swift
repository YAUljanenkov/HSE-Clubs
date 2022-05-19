import UIKit
import Alamofire

class ClubCreationController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var nameView: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    let textViewPlaceholderColor: UIColor = .systemGray4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDescriptionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Создание клуба"
    }
    
    func setupDescriptionView() {
        descriptionView.textColor = textViewPlaceholderColor
        descriptionView.delegate = self
        descriptionView.layer.borderColor = UIColor.systemGray6.cgColor
        descriptionView.layer.cornerRadius = 10
        descriptionView.layer.borderWidth = 1
    }
    
    func textViewDidBeginEditing (_ textView: UITextView) {
        print("worked")
        if textView.textColor == textViewPlaceholderColor {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing (_ textView: UITextView) {
        print("end worked")
        if textView.text.isEmpty || textView.text == "" {
            textView.textColor = textViewPlaceholderColor
            textView.text = "Описание клуба"
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        guard let text = nameView.text, let description = self.descriptionView.text, !text.isEmpty else {
            showAlert(title: "Ошибка", message: "Название клуба не может быть пустым!")
            return
        }
        
        guard let uniqueName = UserDefaults.standard.string(forKey: "unique_name") else {
            showAlert(title: "Error", message: "Cannot find user data. Please, login again.")
            return
        }
        
        DispatchQueue.global().async {
            guard let url = RequestRoutes.getRoute(.createClub) else {return}
            let body = ClubCreationModel(name: text, description: description, unique_name: uniqueName)
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
}


struct ClubCreationModel: Codable {
    var name: String
    var description: String
    var unique_name: String
}
