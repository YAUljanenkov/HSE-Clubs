//
//  ClubNameView.swift
//  HSE Clubs
//
//  Created by Ярослав Ульяненков on 14.03.2022.
//

import UIKit
import SnapKit

class ClubNameView: UIView {
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var avatar = UIImageView()
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    init(frame: CGRect, name: String?, avatar: UIImage?, description: String?) {
        super.init(frame: frame)
        self.nameLabel.text = name
        self.avatar.image = avatar?.resize(withSize: CGSize(width: 80, height: 80))
        self.descriptionLabel.text = description
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(self.avatar)
        
        self.avatar.layer.cornerRadius = 40
        self.avatar.clipsToBounds = true
        self.avatar.translatesAutoresizingMaskIntoConstraints = false
                
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.alignment = .leading
        labelsStackView.spacing = 5
        labelsStackView.distribution = .fillProportionally
        [nameLabel, descriptionLabel].forEach {
            labelsStackView.addArrangedSubview($0)
        }
        
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.alignment = .leading
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
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupName(name: String) {
        nameLabel.text = name
    }
    
    func setupDescription(description: String) {
        descriptionLabel.text = description
    }
}
