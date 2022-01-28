//
//  FavoriteArticles+CoreDataProperties.swift
//  swift_pro
//
//  Created by Daniel on 27/01/2022.
//
//

import Foundation
import CoreData


extension FavoriteArticles {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteArticles> {
        return NSFetchRequest<FavoriteArticles>(entityName: "FavoriteArticles")
    }

    @NSManaged public var id: Int16
    @NSManaged public var imageUrl: String?
    @NSManaged public var newsSite: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var summary: String?
    @NSManaged public var title: String?

}

extension FavoriteArticles : Identifiable {

}
