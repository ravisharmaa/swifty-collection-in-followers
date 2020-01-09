import UIKit

class ViewController: UIViewController {
    
    //MARK:- Subviews
    
    lazy var imageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "github")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var searchButton: UIButton = {
        let button = CustomButton(title: "Search Profiles")
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(searchUsers), for: .touchUpInside)
        
        return button
    }()
    
    lazy var emailField: UITextField = {
        let emailField = UITextField()
        emailField.delegate = self
        emailField.font = UIFont.systemFont(ofSize: 15)
        emailField.borderStyle = UITextField.BorderStyle.roundedRect
        emailField.autocorrectionType = UITextAutocorrectionType.no
        emailField.autocapitalizationType = UITextAutocapitalizationType.none
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.placeholder = "Please Input Your Email"
        return emailField
    }()
    
    lazy var buttonAndTextFieldStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
        
    }()
    
    //MARK:- Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(imageContainer)
        
        setupViews()
        
        setupAdditionalConstraintForSearchAndTextField()
        
        view.addSubview(buttonAndTextFieldStack)
        
        setupConstraintForButtonAndTextStack()
    }
    
    // To hide the navgation bar from the first view controller
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //MARK:- Autolayout Constraints
    
    // autolayout constraints for image and its container
    
    func setupViews(){
        
        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: view.topAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
        
        imageContainer.addSubview(logoImage)
        
        NSLayoutConstraint.activate([
            logoImage.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
            logoImage.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    // autolayout constraint for stack view buttons and textfield
    
    func setupConstraintForButtonAndTextStack() {
        
        buttonAndTextFieldStack.alignment = .center
        buttonAndTextFieldStack.distribution = .fill
        buttonAndTextFieldStack.axis = .vertical
        
        buttonAndTextFieldStack.spacing = 10
        
        NSLayoutConstraint.activate([
            buttonAndTextFieldStack.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            buttonAndTextFieldStack.widthAnchor.constraint(equalTo: logoImage.widthAnchor),
            buttonAndTextFieldStack.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 10)
        ])
        
        buttonAndTextFieldStack.addArrangedSubview(emailField)
        
        buttonAndTextFieldStack.addArrangedSubview(searchButton)
    }
    
    func setupAdditionalConstraintForSearchAndTextField(){
        
        NSLayoutConstraint.activate([
            emailField.heightAnchor.constraint(equalToConstant: 35),
            searchButton.widthAnchor.constraint(equalToConstant: 150),
            searchButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    //MARK:- Search Button Action
    
    @objc func searchUsers(sender: UIButton){
        
        guard let username = emailField.text, username != "" else {
            return
        }
        
        let profilesViewController = ProfilesViewController()
        
        profilesViewController.username = username
        
        self.navigationController?.pushViewController(profilesViewController, animated: true)
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
