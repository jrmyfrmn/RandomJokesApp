//
//  ListOfFaveScreen.swift
//  Jokerist App
//
//  Created by jeremy.fermin on 11/28/22.
//

import UIKit

class ListOfFaveScreen: UIViewController {
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        configureTableView()
        
    }
    
    //MARK: - Configure Table View
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegate()
        tableView.rowHeight = 100
        //tableView.pin(to: view)
    }
    //MARK: - Table View Delegate
    func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
    extension ListOfFaveScreen: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection indexPath: Int) -> Int {
            return 10
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }

