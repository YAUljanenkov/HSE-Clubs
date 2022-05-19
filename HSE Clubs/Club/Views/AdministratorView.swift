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
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
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
//        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
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
        
        
        avatarView.image = avatar?.resize(withSize: CGSize(width: 70, height: 70))
        
        addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(70)
            make.left.equalToSuperview().inset(10)
            make.top.equalTo(administratorTitle.snp.bottom).offset(20)
        }
        
        addSubview(administratorName)
        administratorName.snp.makeConstraints { make in
            make.top.equalTo(administratorTitle.snp.bottom).offset(10)
            make.left.equalTo(avatarView.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
        }
        
        addSubview(vkButton)
        addSubview(tgButton)
        addSubview(emailButton)
        
        vkButton.snp.makeConstraints {make in
            make.top.equalTo(administratorName.snp.bottom).offset(10)
            make.left.equalTo(avatarView.snp.right).offset(10)
        }
        
        tgButton.snp.makeConstraints { make in
            make.top.equalTo(administratorName.snp.bottom).offset(10)
            make.left.equalTo(vkButton.snp.right).offset(10)
        }
        
        emailButton.snp.makeConstraints { make in
            make.top.equalTo(administratorName.snp.bottom).offset(10)
            make.left.equalTo(tgButton.snp.right).offset(10)
        }
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAdministratorName(name: String) {
        administratorName.text = name
    }
    
}
