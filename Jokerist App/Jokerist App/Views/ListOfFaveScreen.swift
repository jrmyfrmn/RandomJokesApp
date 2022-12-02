//
//  ListOfFaveScreen.swift
//  Jokerist App
//
//  Created by jeremy.fermin on 11/28/22.
//
import UIKit
import CoreData

class ListOfFaveScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    private var models = [JokeItems]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        title = "My Favorites ❤️"
        
        view.addSubview(tableView)
        getAllJokes()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        tableView.register(CustomCell.self, forCellReuseIdentifier: "customCell")
        tableView.rowHeight = 100
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
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
            let model = models[indexPath.row]
            self.deleteJoke(item: model)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            tableView.endUpdates()
        }
    }
    
    func getAllJokes() {
        do {
            models = try context.fetch(JokeItems.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
        }
    }
    
    func addJoke(setup: String, punch: String) {
        let newJoke = JokeItems(context: context)
        newJoke.setup = setup
        newJoke.punchline = punch
        
        saveData()
    }

    func deleteJoke(item: JokeItems) {
        context.delete(item)
        
        saveData()
    }
    
    func saveData() {
        do {
            try context.save()
            getAllJokes()
        } catch {
            
        }
    }
}

//import UIKit
//import CoreData
//
//class ListOfFaveScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//    let tableView: UITableView = {
//        let table = UITableView()
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//
//        return table
//    }()
//
//    private var models = [JokeItems]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemMint
//        title = "Favorite Joke List"
//
//        view.addSubview(tableView)
//        getAllJokes()
//
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.frame = view.bounds
//
//        tableView.register(CustomCell.self, forCellReuseIdentifier: "customCell")
//        tableView.rowHeight = 100
//        tableView.tableFooterView = UIView()
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return models.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let model = models[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
//        cell.setup.text = model.setup
//        cell.puncline.text = model.punchline
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
//
//    func  tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            tableView.beginUpdates()
//            let model = models[indexPath.row]
//            self.deleteJoke(item: model)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//
//            tableView.endUpdates()
//        }
//    }
//
//    func getAllJokes() {
//        do {
//            models = try context.fetch(JokeItems.fetchRequest())
//
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        } catch {
//            //error
//        }
//    }
//
//    func addJoke(setup: String, punch: String) {
//        let newJoke = JokeItems(context: context)
//        newJoke.setup = setup
//        newJoke.punchline = punch
//
//        saveData()
//    }
//
//    func deleteJoke(item: JokeItems) {
//        context.delete(item)
//
//        saveData()
//    }
//
//    func saveData() {
//        do {
//            try context.save()
//            getAllJokes()
//        } catch {
//
//        }
//    }
//}
//
//
////class ListOfFaveScreen: UIViewController {
////
////    var tableView = UITableView()
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        view.backgroundColor = .systemMint
////        configureTableView()
////
////    }
////
////    //MARK: - Configure Table View
////    func configureTableView() {
////        view.addSubview(tableView)
////        setTableViewDelegate()
////        tableView.rowHeight = 100
////        //tableView.pin(to: view)
////    }
////    //MARK: - Table View Delegate
////    func setTableViewDelegate() {
////        tableView.delegate = self
////        tableView.dataSource = self
////    }
////}
////    extension ListOfFaveScreen: UITableViewDelegate, UITableViewDataSource {
////
////        func tableView(_ tableView: UITableView, numberOfRowsInSection indexPath: Int) -> Int {
////            return 10
////        }
////        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////            return UITableViewCell()
////        }
////    }
//
