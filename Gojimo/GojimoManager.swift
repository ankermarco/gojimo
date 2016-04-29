//
//  GojimoManager.swift
//  Gojimo
//
//  Created by Ke Ma on 29/04/2016.
//  Copyright © 2016 Ke. All rights reserved.
//

import UIKit

class GojimoManager: NSObject, GojimoCommunicatorDelegate {
    var delegate: GojimoCommunicatorDelegate?
    
    
// MARK: - GojimoCommunicatorDelegate Method
    
    func receivedQualificationsJSON(jsonObject: NSData) {
        
    }
    
    func fetchingQualificationsFailedWithError(error: NSError) {
        
    }
}
