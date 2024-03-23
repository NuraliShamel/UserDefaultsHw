import UIKit
import SnapKit

class ViewController: UIViewController {
    lazy var textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.placeholder = "Enter names"
        field.textAlignment = .center
        field.backgroundColor = .white
        field.textColor = .myGreen
        field.font = UIFont.systemFont(ofSize: 25)
        return field
    }()

    lazy var namesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25)
        label.numberOfLines = 0
        label.backgroundColor = .myGreen
        return label
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Name", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(addNameButtonPressed), for: .touchUpInside)
        button.setTitleColor(.myGreen, for: .normal)
        return button
    }()
    
    lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear Names", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(clearNamesButtonPressed), for: .touchUpInside)
        button.setTitleColor(.myGreen, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .myBiege
        setUi()
        loadNames()
    }
    
    private func setUi() {
        view.addSubview(textField)
        view.addSubview(namesLabel)
        view.addSubview(addButton)
        view.addSubview(clearButton)
        
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(150)
            make.centerX.equalToSuperview()
            make.width.equalTo(370)
            make.height.equalTo(50)
        }
        
        namesLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(370)
            make.height.equalTo(100)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(namesLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        clearButton.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func textFieldDidChange(textField: UITextField) {
        if let text = textField.text {
            saveName(text)
            updateNamesLabel()
        }
    }
    
    @objc private func addNameButtonPressed() {
        if let text = textField.text, !text.isEmpty {
            saveName(text)
            updateNamesLabel()
            textField.text = nil
        }
    }
    
    @objc private func clearNamesButtonPressed() {
        clearNames()
        updateNamesLabel()
    }
    
    private func saveName(_ name: String) {
        var names = UserDefaults.standard.stringArray(forKey: "names") ?? []
        names.append(name)
        UserDefaults.standard.set(names, forKey: "names")
    }
    
    private func loadNames() {
        let names = UserDefaults.standard.stringArray(forKey: "names") ?? []
        namesLabel.text = names.joined(separator: "")
    }
    
    private func updateNamesLabel() {
        let names = UserDefaults.standard.stringArray(forKey: "names") ?? []
        namesLabel.text = names.joined(separator: "")
    }
    
    private func clearNames() {
        UserDefaults.standard.removeObject(forKey: "names")
    }
}


extension UIColor {
    static let myGreen = UIColor(red: 79/255, green: 111/255, blue: 82/255, alpha: 1)
    static let myBiege = UIColor.init(red: 236/255, green: 227/255, blue: 206/255, alpha: 1)
}

