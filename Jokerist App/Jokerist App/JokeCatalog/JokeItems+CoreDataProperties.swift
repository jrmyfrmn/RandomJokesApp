//
//  JokeListItem+CoreDataProperties.swift
//  Jokerist App
//
//  Created by Created by jeremy.fermin 12/1/22.
//
//

import Foundation
import CoreData


extension JokeItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JokeItems> {
        return NSFetchRequest<JokeItems>(entityName: "JokeItems")
    }

    @NSManaged public var setup: String?
    @NSManaged public var punchline: String?

}

extension JokeItems : Identifiable {

}
