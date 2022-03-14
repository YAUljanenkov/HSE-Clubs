//
//  AdministratorView.swift
//  HSE Clubs
//
//  Created by Ярослав Ульяненков on 14.03.2022.
//

import UIKit
import SnapKit

class AdministratorView: UIView {
    
    let administratorTitle: UILabel = {
        let label = UILabel()
        label.text = "Председатель"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let administratorName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        return label
    }()
    
    init(frame: CGRect, name: String?, vk: String?, telegram: String?, email: String, avatar: UIImage?) {
        super.init(frame: frame)
        
        addSubview(administratorTitle)
        administratorTitle.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        let vkButton = UIButton()
        vkButton.setImage(UIImage(named: "vk")?.resize(withSize: CGSize(width: 30, height: 30)), for: .normal)
        
        let tgButton = UIButton()
        tgButton.setImage(UIImage(named: "telegram")?.resize(withSize: CGSize(width: 30, height: 30)), for: .normal)
        
        let emailButton = UIButton()
        emailButton.setImage(UIImage(named: "email")?.resize(withSize: CGSize(width: 30, height: 30)), for: .normal)
        
        let contactsStack = UIStackView()
        contactsStack.axis = .horizontal
        contactsStack.spacing = 2
        contactsStack.alignment = .leading
        contactsStack.distribution = .fillEqually
        contactsStack.translatesAutoresizingMaskIntoConstraints = false
        contactsStack.isUserInteractionEnabled = true
        
        [vkButton, tgButton, emailButton].forEach {
            contactsStack.addArrangedSubview($0)
        }
        
        administratorName.text = name
        
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = true
        [administratorName, contactsStack].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.layoutIfNeeded()
        
        
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.spacing = 10
        mainStackView.distribution = .fillProportionally
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.isUserInteractionEnabled = true
        
        avatarView.image = avatar?.resize(withSize: CGSize(width: 70, height: 70))
        
        
        avatarView.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        
        [avatarView, stackView].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
        
        addSubview(mainStackView)
        

        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(administratorTitle.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
