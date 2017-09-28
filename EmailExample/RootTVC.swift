//
//  RootTVC.swift
//  EmailExample
//
//  Created by Emily Byrne on 9/18/17.
//  Copyright © 2017 Byrne. All rights reserved.
//

import UIKit

protocol CellSelectedDelegate {
    func read(email: Email)
}

protocol DataUpdateDelegate {
    func update(action: String, context: String, email: Email, indexPath: IndexPath)
    func addEmail(email: Email)
}


class RootTVC: UITableViewController {
    
    var emails = [Email]()
    // Gives access to the protocol as a variable
    var delegate: CellSelectedDelegate?
    var dataUpdateDelegate: DataUpdateDelegate?
    var menuDelegate : ViewController? = nil
    var inboxConditional = false
    var sentConditional = false
    var selectedEmailKey = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Display in the root TVC if the user is looking at the inbox, sent, or trash.
        navigationItem.title = selectedEmailKey
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // The following conditional occurs when the inbox row is selected in the MenuRVC
        if inboxConditional == true
        {
            // Adds an edit button.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
            self.editButtonItem.title = "Edit"
        }
        
        // Layout for adjusting the button layout when the sent tab is selected.
        else if sentConditional == true
        {
            // This plus button goes away after the first run. Need to have a way of making this of style .insert
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(sendEmail))
            self.editButtonItem.title = "+"

            
            // Add a button which will append an email to emails when pressed. I cant figure out how to get a button to add, using Bar Button Item type, without it messing up my edit button.
    
        }
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emails.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        // Sets a variable equal to the current email that the user is looking at so that it can later be displayed.
        let selectedEmail = emails[indexPath.row]
        // Read the email in the current row that was selected
        menuDelegate?.read(email: selectedEmail)
       
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let currentEmail = emails[indexPath.row]
        cell.textLabel?.text = currentEmail.subject
        cell.detailTextLabel?.text = currentEmail.sender

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // First we need to move the selected row to the trash section of datadictionary. Call a protocol? I need to create a variable that calls the calls the Menu VC. Then do that variable.IndexPath// Delete the row from the data source
            
            // Delete the row from the data source
            
            // This line allows for the row selected to be deleted from our email file.
             let deletedEmail = emails.remove(at: indexPath.row)
            dataUpdateDelegate?.update(action: "delete", context: selectedEmailKey, email: deletedEmail, indexPath: indexPath)
            // This line then deletes the row from the table viewer
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            tableView.insertRows(at: [indexPath], with: .fade)
            // This is how I would attempt to append emails to the sent folder. 
                        let test = Email(sender: "From: asu@asu.edu", recipient: "To:JoeSmoe@asu.edu", subject: "Spam", contents: "Spam")
                        emails.append(test)

        }
    }
    
    func sendEmail() {
        let NewEmail = Email(sender: "Sender", recipient: "Recipient", subject: "Subject", contents: "contents")
        dataUpdateDelegate?.addEmail(email: NewEmail)
        tableView.reloadData()
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
