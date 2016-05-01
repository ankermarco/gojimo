//
//  GojimoManagerDelegate.swift
//  Gojimo
//
//  Created by Ke Ma on 28/04/2016.
//  Copyright © 2016 Ke. All rights reserved.
//

import Foundation

protocol GojimoManagerDelegate {
    func checkLocalCoreDataExists()-> Bool
    func didReceiveQualifications(qualifications: [String])
    func fetchingQualificationsFailedWithError(error: NSError)
}