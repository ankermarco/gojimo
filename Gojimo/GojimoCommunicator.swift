//
//  GojimoCommunicator.swift
//  Gojimo
//
//  Created by Ke Ma on 30/04/2016.
//  Copyright © 2016 Ke. All rights reserved.
//

import UIKit

/*
 This class is used to manage the network communication with server
 and delegate tasks to communicatorDelegate to deal with the JSON object 
 fetched from the server
 */
class GojimoCommunicator: NSObject {
    var delegate: GojimoCommunicatorDelegate?
    var lastModifiedDateFromServer: NSDate?
    
    // Check Http request header to tell whether continue synchronously
    func urlContentModifiedAt(urlPath: String) -> NSDate? {
        let url = NSURL(string: urlPath)
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url!)
        var serverDate: NSDate?
        let semaphore = dispatch_semaphore_create(0)
        request.HTTPMethod = "HEAD"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            if let httpResp: NSHTTPURLResponse = response as? NSHTTPURLResponse {
                
                let date = httpResp.allHeaderFields["Last-Modified"] as! String //EXAMPLE:  "Mon, 19 Oct 2015 05:57:12 GMT"
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "EEEE, dd LLL yyyy hh:mm:ss zzz"
                serverDate = dateFormatter.dateFromString(date) as NSDate?
                dispatch_semaphore_signal(semaphore)
                
                //serverDate is now: 2015-10-19 05:57:12 UTC
                //print("ServerDate: \(serverDate)")
                
            }
        }
        
        task.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        self.lastModifiedDateFromServer = serverDate
        return serverDate
    }
    
    func fetchQualifications(urlPath: String) {
            
        let url = NSURL(string: urlPath)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { ( data, response, error) in
            
            if error != nil {
                self.delegate?.fetchingQualificationsFailedWithError(error!)
            } else {
                self.delegate?.receivedQualificationsJSON(data!)
            }
        }
        
        task.resume()
       
    }
}
