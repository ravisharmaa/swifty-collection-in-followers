import UIKit

class ProfilesCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Subviews
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
        imageView.layer.cornerRadius = 8
        
        return imageView
    }()
    
    //MARK:- Initializers
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        
        setupConstraintsForImageView()
    }
    
    func setupConstraintsForImageView() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    
    func setFields(data: Followers) {
        
        Service.shared.fetchAvatarFrom(data.avatar_url) { (data: Data) in
            self.imageView.image = UIImage(data: data)
        }
    }
    
}
