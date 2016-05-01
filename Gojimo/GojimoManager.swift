//
//  GojimoManager.swift
//  Gojimo
//
//  Created by Ke Ma on 29/04/2016.
//  Copyright © 2016 Ke. All rights reserved.
//

import UIKit

class GojimoManager: NSObject, GojimoCommunicatorDelegate {
    
    var communicator: GojimoCommunicator?
    var delegate: GojimoManagerDelegate?
    
    func fetchQualifications(urlPath: String) {
        self.communicator?.fetchQualifications(urlPath)
    }
    
    
// MARK: - GojimoCommunicatorDelegate Method
    
    func receivedQualificationsJSON(jsonObject: NSData) {
        
        // Pass JSON to Qualification Builder
        
        let qualifications: AnyObject?
        
        do{
            qualifications = try NSJSONSerialization.JSONObjectWithData(jsonObject, options: [])
            
            print(qualifications!)

        } catch {
            print(error)
        }
    
    }
    
    func fetchingQualificationsFailedWithError(error: NSError) {
        self.delegate?.fetchingQualificationsFailedWithError(error)
    }
}
