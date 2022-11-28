//
//  ViewController.swift
//  Jokerist App
//
//  Created by jeremy.fermin on 11/24/22.
//

import UIKit

class MainScreenView: UIViewController {
    
    let faveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
        view.addSubview(label)
        view.addSubview(refreshButton)
        setConstraints()
        setupButton()
        loadData()
        
        //MARK: NAVIGATION TITLE
        //view.backgroundColor = .systemBackground
        title = "J🤪KES"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private var dataTask: URLSessionDataTask?
    
    private var joke: [Joke]? {
        didSet {
            guard let joke = joke?.randomElement() else { return }
            label.text = "\(joke.setup)\n\(joke.punchline)"
            label.sizeToFit()
        }
    }
    
    // MARK: FAVE BUTTON
    private func setupButton() {
        //view.addSubview(faveButton)
        
        faveButton.setTitle("♥ Add To Favorites", for: .normal)
        faveButton.backgroundColor = .systemFill
        faveButton.setTitleColor(.white, for: .normal)
        faveButton.layer.cornerRadius = 10
        faveButton.addTarget(self, action: #selector(goToFaveScreen), for: .touchUpInside)
        
        addButtonConstraints()
    }
    
    //MARK: FAVE BUTTON CONSTRAINTS
    func addButtonConstraints() {
        view.addSubview(faveButton)
        faveButton.translatesAutoresizingMaskIntoConstraints = false
//        faveButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
//        faveButton.leadingAnchor.constraint(equalTo: label.centerXAnchor).isActive = true

        NSLayoutConstraint.activate([
            //faveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),//.isActive = true
            faveButton.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
            faveButton.widthAnchor.constraint(equalToConstant: 210),
            faveButton.heightAnchor.constraint(equalToConstant: 50)
//            faveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            faveButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
//            faveButton.widthAnchor.constraint(equalToConstant: 210),
//            faveButton.heightAnchor.constraint(equalToConstant: 50)

        ])
    }
    
    //MARK: GO TO FAVE SCREEN
    @objc func goToFaveScreen() {
        let nextScreen = ListOfFaveScreen()
        nextScreen.title = "MY FAVORITES ❤️"
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    
    //MARK: JOKES LABEL
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Loading joke..."
        label.sizeToFit()
        return label
    }()

    //MARK: REFRESH BUTTON
    private lazy var refreshButton: UIButton = {
        let button = UIButton(frame: .zero)
        //let image = UIImage(systemName: "arrow.clockwise")
        button.setTitle("Next", for: .normal)
        //button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(loadData), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemFill
        return button
    }()
    


//MARK: LABEL AND REFRESH BUTTON CONSTRAINTS
    private func setConstraints() {
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        refreshButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        refreshButton.leadingAnchor.constraint(equalTo: label.centerXAnchor).isActive = true
    }
    
    //MARK: JOKES API
    @objc private func loadData() {
        guard let url = URL(string: "https://official-joke-api.appspot.com/random_ten") else {
            return
        }
    //MARK: JOKES API CALLING
        dataTask?.cancel()
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            if let decodedData = try? JSONDecoder().decode([Joke].self, from: data) {
                DispatchQueue.main.async {
                    self.joke = decodedData
                }
            }
        }
        // Send Request
        dataTask?.resume()
    }
}

struct Joke: Decodable {
    let id: Int
    let type: String
    let setup: String
    let punchline: String
}
