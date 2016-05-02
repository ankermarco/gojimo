//
//  QualificationTableViewController.swift
//  Gojimo
//
//  Created by Ke Ma on 28/04/2016.
//  Copyright © 2016 Ke. All rights reserved.
//

import UIKit
import CoreData

class QualificationTableViewController: UITableViewController, GojimoManagerDelegate {
    
    let gojimoUrl = "https://api.gojimo.net/api/v4/qualifications"
    
    var qualifications:[Qualification] = []
    var moc: NSManagedObjectContext!
    
    var manager: GojimoManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = GojimoManager()
        manager?.communicator = GojimoCommunicator()
        manager?.communicator?.delegate = manager
        manager?.delegate = self
        
        self.prepopulateData()
    }
    
    // MARK - GojimoManagerDelegate Methods
    
    func checkLocalCoreDataExists()->Bool {
        print("Check if core data exists...")
        return true
    }
    
    func fetchingQualificationsFailedWithError(error: NSError) {
        print("Error: \(error)")
    }
    
    func didReceiveQualifications(qualifications1: [Qualification]) {
        print("didReceivedQualifications")
        self.qualifications = qualifications1
        print("here--> \(self.qualifications[0].name)")
        // Pass qualification to view
        self.tableView.reloadData()
        
    }
    
    // MARK - start prepopulateData
    // Use prepopulate data to determine whether add new json into core data
    func prepopulateData() {
        
        print("Prepopulating Data...")
        self.manager?.prepopulateData(self.gojimoUrl)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("qualifications count-->: \(qualifications.count)")
        return self.qualifications.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("QualificationCell", forIndexPath: indexPath)

        // Configure the cell...
        let cellQualification = self.qualifications[indexPath.row]
        print("indexPath.row ---> \(indexPath.row)")
        print("cellqualification------>> \(cellQualification)");
        print("cellqualification name------>> \(cellQualification.name)");
        cell.textLabel?.text = cellQualification.name
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
