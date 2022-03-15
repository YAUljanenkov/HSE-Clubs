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
//        let imageAttachment = NSTextAttachment()
//        imageAttachment.image = UIImage(named: "clock")?.resize(withSize: CGSize(width: 16, height: 16))
//        let imageOffsetY: CGFloat = -5.0
//        imageAttachment.bounds = CGRect(x: 0, y: 0, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
//        let attachmentString = NSAttributedString(attachment: imageAttachment)
//        let completeText = NSMutableAttributedString(string: "")
//        completeText.append(attachmentString)
//        label.textAlignment = .center
//        label.attributedText = completeText
        return label
    }()
    
    var roomLabel: UILabel = {
        let label = UILabel()
//        let imageAttachment = NSTextAttachment()
//        imageAttachment.image = UIImage(named: "door")?.resize(withSize: CGSize(width: 16, height: 16))
//        let imageOffsetY: CGFloat = -5.0
//        imageAttachment.bounds = CGRect(x: 0, y: 0, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
//        let attachmentString = NSAttributedString(attachment: imageAttachment)
//        let completeText = NSMutableAttributedString(string: "")
//        completeText.append(attachmentString)
//        label.textAlignment = .center
//        label.attributedText = completeText
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
        let dateLabel = UILabel()
        dateLabel.text = "Дата"
        dateLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        dateLabel.textColor = .gray
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(dateTimeLabel)
        let addreessLabel = UILabel()
        addreessLabel.text = "Адрес"
        addreessLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        addreessLabel.textColor = .gray
        stackView.addArrangedSubview(addreessLabel)
        stackView.addArrangedSubview(roomLabel)
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
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
