//
//  ContactsView.swift
//  HSE Clubs
//
//  Created by Ярослав Ульяненков on 13.03.2022.
//

import UIKit
import SnapKit
import OrderedCollections

class ContactsView: UIView {
    
    var data: OrderedDictionary<String, String> = [:]
    
    init(frame: CGRect, tg: String, vk: String, email: String) {
        super.init(frame: frame)
        let contacts = UIStackView()
        contacts.axis = .vertical
        contacts.alignment = .leading
        contacts.spacing = 5
        
        self.data = ["vk": vk, "telegram": tg, "email": email]
        let tags = ["vk": 1, "telegram": 2, "email": 3]
        
        data.forEach { (key, value) in
            let contact = UIStackView()
            contact.axis = .horizontal
            contact.distribution = .fillProportionally
            contact.spacing = 10
            
            let icon = UIImageView(image: UIImage(named: key)?.resize(withSize: CGSize(width: 30, height: 30)))
            contact.addArrangedSubview(icon)
            
            let text = UILabel()
            text.text = value
            text.font = UIFont.systemFont(ofSize: 18, weight: .light)
            contact.addArrangedSubview(text)
            
            let button = UIButton()
            button.setImage(UIImage(named: "copy")?.resize(withSize: CGSize(width: 25, height: 25)), for: .normal)
            button.setImage(UIImage(named: "copy pressed")?.resize(withSize: CGSize(width: 25, height: 25)), for: .highlighted)
            button.tag = tags[key] ?? 0
            button.addTarget(self, action: #selector(self.copyContact), for: .touchUpInside)
            contact.addArrangedSubview(button)
            contact.isUserInteractionEnabled = true
            contact.translatesAutoresizingMaskIntoConstraints = false
            
            contacts.addArrangedSubview(contact)
            contacts.translatesAutoresizingMaskIntoConstraints = false
            let separator = UIView()
            contacts.addArrangedSubview(separator)
            separator.snp.makeConstraints { make in
                make.width.equalTo(contacts.snp.width)
                make.height.equalTo(1)
            }
            separator.backgroundColor = UIColor(red: 142/255.0, green: 142/255.0, blue: 147/255.0, alpha: 1)
        }
        
        contacts.isUserInteractionEnabled = true
        addSubview(contacts)
        
        contacts.snp.makeConstraints { make in
            make.leading.equalTo(self)
        }
        
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func copyContact(sender: UIButton) {
        print("worked")
        var link: String?
        switch sender.tag {
        case 1:
            link = data["vk"]
        case 2:
            link = data["telegram"]
        case 3:
            link = data["email"]
        default:
            link = ""
        }
        
        UIPasteboard.general.string = link
    }
}
