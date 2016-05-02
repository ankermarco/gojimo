//
//  QualificationBuilder.swift
//  Gojimo
//
//  Created by Ke Ma on 30/04/2016.
//  Copyright © 2016 Ke. All rights reserved.
//

import UIKit
import CoreData

/*
 Use this class to save the local domain JSON object into core data
 */
class QualificationBuilder: NSObject {

    var qualifications: NSArray?
    /*
     This method will save json object into core data
     And return qualifications
     */
    // Use throws to propagate the potential error from NSJSONSerialization.JSONObjectWithData()
    func qualificationsFromJSON(jsonObject: NSData) throws {
        // Parse JSON and save into Core data
        
        do{
            self.qualifications = try NSJSONSerialization.JSONObjectWithData(jsonObject, options: NSJSONReadingOptions.MutableContainers) as? NSArray
            
            // Save to core data
            self.saveJSONtoCoreData()
            
        }
        
    }
    
    private func saveJSONtoCoreData() {
        //print(self.qualifications!)
        
        let coreDataStack = CoreDataStack()
        
        for json in self.qualifications! {
            
            let qualification = NSEntityDescription.insertNewObjectForEntityForName("Qualification", inManagedObjectContext: coreDataStack.managedObjectContext) as! Qualification
            qualification.id = json["id"] as? String
            qualification.name = json["name"] as? String
            
            // Country
            let country = NSEntityDescription.insertNewObjectForEntityForName("Country", inManagedObjectContext: coreDataStack.managedObjectContext) as! Country
            if let countryNode = json["country"] as? NSDictionary {
                // countryNode is not nil
                country.code = countryNode["code"] as? String
                country.created_at = countryNode["created_at"] as? NSDate
                country.name = countryNode["name"] as? String
                country.link = countryNode["link"] as? String
                country.updated_at = countryNode["updated_at"] as? NSDate
            }
            qualification.qToCountry = country
            
            // Subjects
            
            if let eachSubjects = json["subjects"] as? NSArray {
                for eachSubject in eachSubjects
                {
                   let subject = NSEntityDescription.insertNewObjectForEntityForName("Subject", inManagedObjectContext: coreDataStack.managedObjectContext) as! Subject
                    subject.color = eachSubject["color"] as? String
                    subject.id = eachSubject["id"] as? String
                    subject.link = eachSubject["link"] as? String
                    subject.title = eachSubject["title"] as? String
                    
                    let subjects = qualification.qToSubject!.mutableCopy() as! NSMutableSet
                    subjects.addObject(subject)
                    qualification.qToSubject = subjects.copy() as? NSSet
                }
            }
            
        }
        
        coreDataStack.saveContext()
        
        var request = NSFetchRequest(entityName: "Qualification")
        let qualificationCount = coreDataStack.managedObjectContext.countForFetchRequest(request, error: nil)
        print("Total qualifications: \(qualificationCount)")
        
        request = NSFetchRequest(entityName: "Country")
        let countryCount = coreDataStack.managedObjectContext.countForFetchRequest(request, error: nil)
        print("Total contries: \(countryCount)")
        
        request = NSFetchRequest(entityName: "Subject")
        let subjectCount = coreDataStack.managedObjectContext.countForFetchRequest(request, error: nil)
        print("Total subjects: \(subjectCount)")
        
    }
    
    class func fetchAllQualificationsFromCoreData()->[Qualification]{
        let coreDataStack = CoreDataStack()
        let request = NSFetchRequest(entityName: "Qualification")
        var qualificationsFromCoreData: [Qualification] = []
        
        do {
            // Regular request
            qualificationsFromCoreData = try coreDataStack.managedObjectContext.executeFetchRequest(request) as! [Qualification]
        }
        catch {
            fatalError("Error in getting list of home by status")
        }

        return qualificationsFromCoreData
        
    }
    
    class func saveModified(modifiedAt: NSDate?) -> Bool{
        
        
        return true
    }
}
