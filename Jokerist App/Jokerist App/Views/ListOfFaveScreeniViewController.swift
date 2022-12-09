//
//  ListOfFaveScreenViewController.swift
//  Jokerist App
//
//  Created by jeremy.fermin on 11/28/22.
//

import UIKit
import CoreData

class ListOfFaveScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let jokesCoreData = JokesDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        view.addSubview(tableView)
        jokesCoreData.getAllJokes()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.register(CustomCell.self, forCellReuseIdentifier: "customCell")
        tableView.rowHeight = 100
        tableView.tableFooterView = UIView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        title = "My Favorites ❤️"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokesCoreData.jokesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = jokesCoreData.jokesData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        cell.setup.text = model.setup
        cell.punchline.text = model.punchline
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func  tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let model = jokesCoreData.jokesData[indexPath.row]
            jokesCoreData.deleteJoke(item: model)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            tableView.endUpdates()
        }
    }
}
