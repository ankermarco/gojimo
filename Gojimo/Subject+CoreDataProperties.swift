//
//  Subject+CoreDataProperties.swift
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

extension Subject {

    @NSManaged var color: String?
    @NSManaged var link: String?
    @NSManaged var title: String?
    @NSManaged var id: String?
    @NSManaged var subjectToQ: Qualification?

}
