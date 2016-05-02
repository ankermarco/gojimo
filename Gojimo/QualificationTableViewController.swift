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
    
    var qualifications:[Qualification] = []
    var manager: GojimoManager?
    let gojimoUrl = "https://api.gojimo.net/api/v4/qualifications"


    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = GojimoManager()
        manager?.communicator = GojimoCommunicator()
        manager?.communicator?.delegate = manager
        manager?.delegate = self
        
        self.prepopulateData()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - start prepopulateData
    // Use prepopulate data to determine whether add new json into core data
    func prepopulateData() {
        //print("Prepopulating Data...")
        
        self.manager?.prepopulateData(self.gojimoUrl)
    }
    
    func fetchingQualificationsFailedWithError(error: NSError) {
        print("Error: \(error)")
    }
    
    func didReceiveQualifications() {
        print("didReceivedQualifications")
        
        dispatch_async(dispatch_get_main_queue()) {
            self.qualifications = QualificationBuilder.fetchAllQualificationsFromCoreData()
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.qualifications.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("QualificationCell", forIndexPath: indexPath)

        // Configure the cell...
        let cellQualification = self.qualifications[indexPath.row]
        cell.textLabel?.text = cellQualification.name
        
        let subjects = cellQualification.qToSubject
        let count: Int = (subjects?.count)!
        cell.detailTextLabel!.text? = String(count)
        
        if subjects?.count == 0 {
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.userInteractionEnabled = false
            cell.contentView.alpha = 0.5
        }
        
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "qToSubjects" {
            
            let subjectTableViewController = segue.destinationViewController as! SubjectTableViewController
            
            // Pass moc over to subjectTableViewController
            subjectTableViewController.moc = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
            // Get the cell that generated this segue.
            if let selectedEventCell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(selectedEventCell)!
                let selectedQ = qualifications[indexPath.row]
                subjectTableViewController.qualification = selectedQ
            }
            
        }
        
    }
    

}
