//
//  EventView.swift
//  HSE Clubs
//
//  Created by Ярослав Ульяненков on 15.03.2022.
//

import UIKit

class EventView: UIView {
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .gray
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
        
    var dateTimeLabel: UILabel = {
        let label = UILabel()
        return label

    }()
    
    func setupDateTime() -> UIStackView {
        let icon = UIImageView(image: UIImage(named: "clock")?.resize(withSize: CGSize(width: 16.0, height: 16.0)))
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(dateTimeLabel)
        stackView.addBackground(color: UIColor(red: 242/256, green: 242/256, blue: 247/256, alpha: 1.0), cornerRadius: 10.0)
        return stackView
    }
    
    var roomLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    
    init(frame: CGRect, name: String?, description: String?, date: String, place: String?) {
        super.init(frame: frame)
        nameLabel.text = name
        descriptionLabel.text = description
        dateTimeLabel.text = date
        roomLabel.text = place
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(25)
        }
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.addArrangedSubview(setupDateTime())
        stackView.addArrangedSubview(roomLabel)
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
//            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(10)
            make.height.equalTo(40)
        }
        
        addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIStackView {
    func addBackground(color: UIColor, cornerRadius: CGFloat) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layer.cornerRadius = cornerRadius
        insertSubview(subView, at: 0)
    }
}
