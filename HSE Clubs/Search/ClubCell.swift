//
//  ClubCell.swift
//  HSE Clubs
//
//  Created by Ярослав Ульяненков on 13.03.2022.
//

import UIKit
import SnapKit

class ClubCell: UICollectionViewCell {
    public static let cellId = "Club cell"
    
    static let  cellSize = 60.0
    
    var avatar: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var name: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var descript: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let textStackView = UIStackView()
        textStackView.axis = .vertical
//        textStackView.spacing = 5
        textStackView.distribution = .fillProportionally
        [name, descript].forEach {
            textStackView.addArrangedSubview($0)
        }
        
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.spacing = 10
        mainStackView.distribution = .fillProportionally
        
        let addIcon = UIImageView(image: UIImage(named: "add group")?.resize(withSize: CGSize(width: 32, height: 16)))
        addIcon.contentMode = .scaleAspectFit
        addIcon.translatesAutoresizingMaskIntoConstraints = false
        [avatar, textStackView, addIcon].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
        textStackView.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
        
        avatar.snp.makeConstraints { make in
            make.width.equalTo(ClubCell.cellSize)
            make.height.equalTo(ClubCell.cellSize)
        }
        
        addIcon.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.height.equalTo(16)
        }
        
        addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-10)
            make.height.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(5)
        }
    }
    
    public func customize(name: String, description: String, avatar: UIImage?) {
        self.name.text = name
        self.descript.text = description
        self.avatar.image = avatar?.resize(withSize: CGSize(width: ClubCell.cellSize, height: ClubCell.cellSize))
        
        self.avatar.layer.cornerRadius = ClubCell.cellSize / 2.0
        self.avatar.clipsToBounds = true
    }
    
    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
        self.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
