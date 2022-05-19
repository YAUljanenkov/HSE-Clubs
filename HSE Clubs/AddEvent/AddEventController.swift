//
//  AddEventController.swift
//  HSE Clubs
//
//  Created by Ярослав Ульяненков on 19.05.2022.
//

import UIKit
import Alamofire


class AddEventController: UIViewController, UITextViewDelegate {
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionView: UITextView!
    @IBOutlet var dateTimePicker: UIDatePicker!
    @IBOutlet var roomTextField: UITextField!
    let textViewPlaceholderColor: UIColor = .systemGray4
    var clubID: Int?
    
    override func viewDidLoad() {
        setupDescriptionView()
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
    
    public func setupClubID(clubId: Int?) {
        self.clubID = clubId
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        guard let text = nameTextField.text, let description = self.descriptionView.text, !text.isEmpty else {
            showAlert(title: "Ошибка", message: "Название мероприятия не может быть пустым!")
            return
        }
        
        guard let clubID = clubID else {
            showAlert(title: "Ошибка", message: "Что-то пошло не так.")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        let dateTime = dateFormatter.string(from: dateTimePicker.date)
        

        let body = EventCreationModel(clubID: clubID, name: text, description: description, dateTime: dateTime, room: roomTextField.text)
        
        DispatchQueue.global().async {
            guard let url = RequestRoutes.getRoute(.createEvent) else {return}
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


struct EventCreationModel: Codable {
    var clubID: Int
    var name: String
    var description: String?
    var dateTime: String?
    var room: String?
}
