//
//  ClubCell.swift
//  HSE Clubs
//
//  Created by Ярослав Ульяненков on 13.03.2022.
//

import UIKit
import SnapKit

class MyClubCell: UICollectionViewCell {
    public static let cellId = "MyClub cell"
    
    static let cellSize = 400.0
    
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
    
    var eventStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    
    let eventsTitle: UILabel = {
        let label = UILabel()
        label.text = "Мероприятия"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
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
        
        let addIcon = UIImageView(image: UIImage(named: "added group")?.resize(withSize: CGSize(width: 32, height: 16)))
        addIcon.contentMode = .scaleAspectFit
        addIcon.translatesAutoresizingMaskIntoConstraints = false
        [avatar, textStackView].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
        textStackView.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        avatar.snp.makeConstraints { make in
            make.width.equalTo(ClubCell.cellSize)
            make.height.equalTo(ClubCell.cellSize)
        }
        
        addSubview(addIcon)
        addIcon.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.height.equalTo(50)
            make.top.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
        }
    
        addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-30)
            make.height.equalTo(60).offset(-10)
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(15)
        }
        
        addSubview(eventsTitle)
        
        eventsTitle.snp.makeConstraints { make in
            make.top.equalTo(mainStackView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
        }
        eventStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(eventStackView)
        eventStackView.snp.makeConstraints { make in
            make.top.equalTo(eventsTitle.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(10)
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
    
    public func setupEvents(events: [ClubData.Info.Event]) {
        if(events.count > 0) {
            eventsTitle.textColor = UIColor(red: 0, green: 47/225.0, blue: 141/225.0, alpha: 100)
        } else {
            eventsTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }
        
        for v in self.eventStackView.arrangedSubviews {
            v.removeFromSuperview()
        }
        
        events.forEach {
            let event = EventView(frame: CGRect(x: 0, y: 0, width: 350, height: 150), name: $0.name, description: $0.description, date: $0.dateTime ?? "", place: $0.place)
            eventStackView.addArrangedSubview(event)
            event.snp.makeConstraints { make in
//                make.height.equalTo(100)
                make.width.equalToSuperview()
            }
            event.clipsToBounds = true
        }
        eventStackView.addHorizontalSeparators(color: .systemGray5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
