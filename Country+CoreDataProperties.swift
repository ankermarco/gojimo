//
//  Country+CoreDataProperties.swift
//  Gojimo
//
//  Created by Ke Ma on 28/04/2016.
//  Copyright © 2016 Ke. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Country {

    @NSManaged var link: String?
    @NSManaged var updated_at: NSDate?
    @NSManaged var created_at: NSDate?
    @NSManaged var name: String?
    @NSManaged var code: String?
    @NSManaged var countryToQ: Qualification?

}
