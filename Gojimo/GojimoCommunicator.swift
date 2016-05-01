//
//  GojimoCommunicator.swift
//  Gojimo
//
//  Created by Ke Ma on 30/04/2016.
//  Copyright © 2016 Ke. All rights reserved.
//

import UIKit

class GojimoCommunicator: NSObject {
    var delegate: GojimoCommunicatorDelegate?
    
    // Check Http request header to tell whether continue
    func isURLContentModified(urlPath: String) -> Bool {
        let url = NSURL(string: urlPath)
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = "HEAD"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            if let httpResp: NSHTTPURLResponse = response as? NSHTTPURLResponse {
                
                let date = httpResp.allHeaderFields["Last-Modified"] as! String //EXAMPLE:  "Mon, 19 Oct 2015 05:57:12 GMT"
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "EEEE, dd LLL yyyy hh:mm:ss zzz"
                let serverDate = dateFormatter.dateFromString(date) as NSDate?
                
                //serverDate is now: 2015-10-19 05:57:12 UTC
                print("ServerDate: \(serverDate)")
            }
        }
        
        task.resume()
        
        return true
        
    }
    
    func fetchQualifications(urlPath: String) {
        
        if (self.isURLContentModified(urlPath) == true){
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
}
