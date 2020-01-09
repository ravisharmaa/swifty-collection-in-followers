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
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    func setFields(data: Followers) {
        
        fetchImageFromAvatarUrl(data.avatar_url)
    }
    
    func fetchImageFromAvatarUrl(_ url: String?) {
        
        guard let imageUrl = url else {
            return
        }
    
        guard let url = URL(string: imageUrl) else { return }
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data!)
            }
            
        }
    }
}
