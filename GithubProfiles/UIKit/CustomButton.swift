import Foundation
import UIKit

class CustomButton: UIButton {
    
    var title: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init()
        
        self.title = title
        
        setupView()
        
    }
    
    func setupView() {
        //backgroundColor = UIColor(red: 0.53, green: 1.79, blue: 0.81, alpha: 1.0)
        backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel?.textColor = .black
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
    
}
