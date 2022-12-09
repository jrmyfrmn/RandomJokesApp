//
//  JokesDataManager.swift
//  Jokerist App
//
//  Created by jeremy.fermin on 12/9/22.
//

import Foundation
import CoreData

class JokesDataManager {

    let container: NSPersistentContainer
    @Published var jokesData: [JokeItems] = []

    init() {
        container = NSPersistentContainer(name: "JokeCatalogData")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error Loading Data \(error)")
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }

    func getAllJokes() {
        let request = NSFetchRequest<JokeItems>(entityName: "JokeItems")
        do {
            jokesData = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching joke \(error)")
        }
    }

    func addJoke(setup: String, punch: String) {
        let newJoke = JokeItems(context: container.viewContext)
        newJoke.setup = setup
        newJoke.punchline = punch
        
        saveData()
    }

    func deleteJoke(item: JokeItems) {
        container.viewContext.delete(item)
        
        saveData()
    }

    func saveData() {
        do {
            try container.viewContext.save()
            getAllJokes()
        } catch {
            
        }
    }
}
