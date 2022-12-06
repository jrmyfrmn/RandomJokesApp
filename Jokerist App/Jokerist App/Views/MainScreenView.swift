//
//  ViewController.swift
//  Jokerist App
//
//  Created by jeremy.fermin on 11/24/22.
//

import UIKit
import CoreData

class MainScreenView: UIViewController {
    
    private let viewModel = JokeristVM()
    
    var jokes: Jokes!
 
    //MARK: JOKES LABEL
    private let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Loading joke..."
        label.sizeToFit()
        
        return label
    }()
    
    //MARK: PUNCH LINE LABEL
    private let punchLine: UILabel = {
        let punchLine = UILabel(frame: .zero)
        punchLine.translatesAutoresizingMaskIntoConstraints = false
        punchLine.numberOfLines = 0
        punchLine.text = " "
        punchLine.sizeToFit()
        
        return punchLine
    }()
    
    //MARK: REFRESH BUTTON
    private let refreshButton: UIButton = {
        let button = UIButton(frame: .zero)
        let image = UIImage(systemName: "arrow.clockwise")
        
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(loadData), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    //MARK: FAVE BUTTON
    private let faveButton: UIButton = {
        let faveButton = CustomButton()
        faveButton.configure(with: CustomButtonVM(text: "Add to Favorites",
                                              image: UIImage(systemName: "heart.fill"),
                                              backgroundColor: .systemFill))
        faveButton.addTarget(self, action: #selector(tapFavorite), for: .touchUpInside)
        faveButton.translatesAutoresizingMaskIntoConstraints = false
        
        return faveButton
    }()
    
    private func navigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(tapList))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemYellow
        title = "J🤪KES"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(label)
        view.addSubview(punchLine)
        view.addSubview(refreshButton)
        view.addSubview(faveButton)
        
        navigationItems()
        setConstraints()
        
        Task {
            await loadData()
        }
    }
    
    private func loadData() async {
        await viewModel.getAJoke(url: Constants.Urls.randomJokes)
        guard let joke = viewModel.joke.randomElement() else {return}
        label.text = joke.setup
        punchLine.text = joke.punchline
        label.sizeToFit()
        punchLine.sizeToFit()
    }
    
    @objc func tapList() {
        let listVC = ListOfFaveScreen()
        navigationController?.pushViewController(listVC, animated: true)
    }
    
    @objc func tapFavorite() {
        let faveList = ListOfFaveScreen()
        faveList.addJoke(setup: label.text!, punch: punchLine.text!)
    }
    
    @objc func loadData() {
        Task {
            await loadData()
        }
    }
    
    private func setConstraints() {
        
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        punchLine.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
        punchLine.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
        
        refreshButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        refreshButton.topAnchor.constraint(equalTo: punchLine.bottomAnchor, constant: 10).isActive = true
        refreshButton.leadingAnchor.constraint(equalTo: punchLine.leadingAnchor).isActive = true
        
        faveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250).isActive = true
        faveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100).isActive = true
        faveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100).isActive = true
        faveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
