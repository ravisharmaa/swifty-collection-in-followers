import UIKit

class ProfilesViewController: UIViewController {
    
    //MARK:- Properties
    
    var username: String?
    
    let apiUrl: String = "https://api.github.com/users/"
    
    var followers: [Followers] = [Followers]()
    
    
    //MARK:- Subviews
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        let width = (self.view.frame.size.width - 40) / 5
        
        layout.itemSize = CGSize(width: width, height: width)
        
        layout.scrollDirection = .vertical
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    //MARK:- Viewlife Cycle
    
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
    
    
    
    fileprivate func fetchDataFromApi(_ forEmail: String) {
        
        
        guard let url = URL(string: apiUrl + "\(username!)" + "/followers") else { return  }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let jsonData = data else { return }
            
            do {
                let followers = try JSONDecoder().decode([Followers].self, from: jsonData)
                self.followers = followers
                DispatchQueue.main.async { [weak self ] in
                    self?.collectionView.reloadData()
                }
            } catch let jsonError {
                print("Could not parse json \(jsonError)")
            }
            }.resume()
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
    
}

