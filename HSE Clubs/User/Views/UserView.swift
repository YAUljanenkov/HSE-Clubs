//
//  UserView.swift
//  HSE Clubs
//
//  Created by Ярослав Ульяненков on 12.03.2022.
//

import UIKit
import SnapKit

class UserView: UIView {
    
    var nameLabel = UILabel()
    var avatar = UIImageView()
    var postLabel = UILabel()
    
    init(frame: CGRect, name: String?, avatar: UIImage?, post: String?, department: String?) {
        super.init(frame: frame)
        self.nameLabel.text = name
        self.avatar.image = avatar?.resize(withSize: CGSize(width: 80, height: 80))
        self.postLabel.text = "\(post ?? "") • \(department ?? "")"
        addSubview(nameLabel)
        addSubview(postLabel)
        addSubview(self.avatar)
        
        self.avatar.layer.cornerRadius = 40
        self.avatar.clipsToBounds = true
        
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
//        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 0
        
        postLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        postLabel.adjustsFontSizeToFitWidth = true
        postLabel.textColor = UIColor(red: 0, green: 74/225.0, blue: 221/225.0, alpha: 100)
        
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.alignment = .leading
        labelsStackView.spacing = 5
        labelsStackView.distribution = .fillEqually
        [nameLabel, postLabel].forEach {
            labelsStackView.addArrangedSubview($0)
        }
                
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.spacing = 20
        [self.avatar, labelsStackView].forEach {
                mainStackView.addArrangedSubview($0)
        }
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        
        backgroundColor = .white
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setName(name: String) {
        nameLabel.text = name
    }
}
