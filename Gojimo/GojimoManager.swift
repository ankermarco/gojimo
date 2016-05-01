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
    var builder: QualificationBuilder?
    
    func prepopulateData(urlPath: String) {
        
        //var lastModifiedDate = self.communicator?.isURLContentModified(urlPath)
        
        // core data exist
        //if ( (self.delegate?.checkLocalCoreDataExists() == true) &&
        //    lastModifiedDate == "the one from core data"
         //   ) {
            // do nothing
       // } else {
            // pull json from server and save to core data
            self.fetchQualifications(urlPath)
        //}
        
    }
    
    private func fetchQualifications(urlPath: String) {
        self.communicator?.fetchQualifications(urlPath)
    }
    
    
// MARK: - GojimoCommunicatorDelegate Method
    
    func receivedQualificationsJSON(jsonObject: NSData) {
        
        // Once received data from json
        // pass to QualificationBuilder
        
        do {
            self.builder = QualificationBuilder()
           try self.builder?.qualificationsFromJSON(jsonObject)
            
        } catch {
            
            let catchError = error as NSError
            
            self.delegate?.fetchingQualificationsFailedWithError(catchError)
        }
    
    }
    
    func fetchingQualificationsFailedWithError(error: NSError) {
        self.delegate?.fetchingQualificationsFailedWithError(error)
    }
}
