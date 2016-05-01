//
//  QualificationBuilder.swift
//  Gojimo
//
//  Created by Ke Ma on 30/04/2016.
//  Copyright © 2016 Ke. All rights reserved.
//

import UIKit

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
            print(json["country"])
        }
        
        
        
        
        
    }
}
