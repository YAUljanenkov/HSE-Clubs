

import UIKit
import SnapKit


class AuthButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public init() {
        super.init(frame: .null)
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        self.layer.cornerRadius = 10
        self.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        self.backgroundColor = .systemBlue
        self.setTitleColor(.white, for: .normal)
    }
}
