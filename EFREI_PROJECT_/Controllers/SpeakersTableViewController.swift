//
//  SpeakersTableViewController.swift
//  EFREI_PROJECT_
//
//  Created by Nassim Guettat on 05/04/2021.
//

import UIKit

class SpeakersTableViewController: UITableViewController {
    
    
    var chosenSpeaker: Speaker?
    var speakers = [Speaker](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        
        Airtable.fetchSpeakers(from: Airtable.speakersLink + Airtable.key){ data in
            self.speakers = data
        }
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return speakers.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "speakerCell", for: indexPath) as! SpeakerCell
        
        cell.nameLbl.text = speakers[indexPath.section].fields.name! + " | " + speakers[indexPath.section].fields.type!
        
        cell.companyRoleLbl.text = speakers[indexPath.section].fields.role
        cell.companyRoleLbl.text? += " of "
        
        if let company = speakers[indexPath.section].fields.company?[0]{
            
            Airtable.getSponsor(from: Airtable.sponsorsLink + "/" + company + Airtable.key){ data in
                DispatchQueue.main.async {
                    cell.companyRoleLbl.text! += data.fields.name!
                }
            }
        }

        cell.layer.cornerRadius = 30
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.init(named: "Slate")?.cgColor

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 20))
        
        headerView.backgroundColor = UIColor.white
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSpeaker = speakers[indexPath.section]
        performSegue(withIdentifier: "goToSpeaker", sender: self)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let vc = segue.destination as? SpeakerDetailsController
        vc?.speaker = chosenSpeaker
        // Pass the selected object to the new view controller.
    }

}
