//
//  MainScreenViewController.swift
//  Jokerist App
//
//  Created by jeremy.fermin on 11/24/22.
//

import UIKit
import Combine
import CoreData

class MainScreenViewController: UIViewController {

    private let viewModel = JokeristVM()
    private let jokesCoreData = JokesDataManager()
    private let input: PassthroughSubject<JokeristVM.Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    var customButton = CustomButton()

    
        private let label: UILabel = {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.text = "Loading joke..."
            label.sizeToFit()
    
            return label
    }()

        private let punchLine: UILabel = {
            let punchLine = UILabel(frame: .zero)
            punchLine.translatesAutoresizingMaskIntoConstraints = false
            punchLine.numberOfLines = 0
            punchLine.text = " "
            punchLine.sizeToFit()
    
            return punchLine
        }()

        private let refreshButton: UIButton = {
            let button = UIButton(frame: .zero)
            let image = UIImage(systemName: "arrow.clockwise")
    
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(loadData), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
    
            return button
        }()

        private let faveButton: UIButton = {
            let faveButton = CustomButton()
            faveButton.configure(with: CustomButtonVM(text: "Add to Favorites",
                                                  image: UIImage(systemName: "heart.fill"),
                                                  backgroundColor: .systemFill))
            faveButton.addTarget(self, action: #selector(tapFavorite), for: .touchUpInside)
            faveButton.translatesAutoresizingMaskIntoConstraints = false
    
            return faveButton
        }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 25.0
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private func navigationJokesItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(tapList))
    }
    
    let loader: UIActivityIndicatorView = {
        var loader = UIActivityIndicatorView(frame: .zero)
        loader.style = .medium
        return loader
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Jokerist 🤪"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(label)
        view.addSubview(refreshButton)
        view.addSubview(faveButton)

        addConstraints()
        navigationJokesItem()
        setupBinders()
    }

    private func setupBinders(){
        let output = viewModel.getTransFormJokes(input: input.eraseToAnyPublisher())
        output.sink { [weak self] event in
            switch event{
            case .fetchJokeSucceed(let joke):
                guard let joke = joke.randomElement() else {return}
                self?.label.text = joke.setup
                self?.punchLine.text = joke.punchline
            case .fetchJokeDidFail(let error):
                self?.label.text = error.localizedDescription
                self?.punchLine.text = error.localizedDescription
            case .toggleButton(let isEnabled):
                self?.refreshButton.isEnabled = isEnabled
                self?.refreshButton.backgroundColor = isEnabled ? .systemBlue : .systemGray5
            case .toggleLoading(let loading):
                loading ? self?.loader.startAnimating() : self?.loader.stopAnimating()
                if(loading == false){
                    self?.label.isHidden = false
                    self?.punchLine.isHidden = false
                    self?.loader.isHidden = true
                }
                
            }
        }
        .store(in: &cancellables)
    }

    private func addConstraints() {
   
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
                faveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
                faveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        

    }

    @objc func showAlertMessage() {

        let alert = UIAlertController(title: "Save Favorite Joke", message: "Sucessfuly Saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
            print("tapped Dismiss")
        }))
        present(alert, animated: true)
    }

    @objc func loadData() {
        input.send(.refreshButtonTap)
    }

    @objc func tapFavorite() {
        jokesCoreData.addJoke(setup: label.text!, punch: punchLine.text!)
        debugPrint("Added Favorites Joke")
    }

    @objc func tapList() {
        let listVC = ListOfFaveScreenViewController()
        navigationController?.pushViewController(listVC, animated: true)
    }

    override func loadView() {
        super.loadView()
        [stackView,label,punchLine,loader,faveButton,refreshButton].forEach { item in
            self.view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        input.send(.viewDidAppear)
    }

}
