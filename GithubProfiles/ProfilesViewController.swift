import UIKit

class ProfilesViewController: UIViewController {
    
    //MARK:- Properties
    
    var username: String?
    
    let apiUrl: String = "https://api.github.com/users/"
    
    var followers: [Followers] = [Followers]()
    
    let sectionInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    private let itemsPerRow: CGFloat = 4
    private let cellPadding: CGFloat = 32
    
    
    //MARK:- Sub-views
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        layout.scrollDirection = .vertical
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    //MARK:- View life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.title = "Followers of \(username!)"
        
        fetchDataFromApi(self.username!)
        
        view.addSubview(collectionView)
        
        setupLayoutForCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    fileprivate func fetchDataFromApi(_ forUser: String) {
        
        Service.shared.fetchDataOfProfiles(forUser) { (followers) in
            self.followers = followers
            
            DispatchQueue.main.async { [weak self ] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    func setupLayoutForCollectionView() {
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        collectionView.register(ProfilesCollectionViewCell.self, forCellWithReuseIdentifier: "profileCell")
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
}

extension ProfilesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfilesCollectionViewCell
        
        cell.setFields(data: followers[indexPath.item])
        
        return cell
        
    }
}

extension ProfilesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthOfCell = ((self.view.frame.size.width - (sectionInsets.left + sectionInsets.right) - (cellPadding * (itemsPerRow-1)))/itemsPerRow)
        let sizeOfCell = CGSize(width: widthOfCell, height: widthOfCell)
        print(sizeOfCell)
        return sizeOfCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return cellPadding
        //return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellPadding
    }
}


