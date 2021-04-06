//
//  ScheduleTableViewController.swift
//  EFREI_PROJECT_
//
//  Created by Nassim Guettat on 24/03/2021.
//

import UIKit

class ScheduleTableViewController: UITableViewController {
    
    var chosenActivity: Schedule?
    
    var speaker: Speaker?
    
    var activities = [Schedule](){
        didSet{
            DispatchQueue.main.async {
                
                if self.speaker == nil{
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    
                    let date = dateFormatter.date(from: self.activities[0].fields.start ?? "2017-01-09T11:00:00.000Z")!
                    let calanderDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
                    
                    
                    
                    for activity in self.activities{
                        
                        let date2 = dateFormatter.date(from: activity.fields.start ?? "2017-01-09T11:00:00.000Z")!
                        let calanderDate2 = Calendar.current.dateComponents([.day, .year, .month], from: date2)
                        
                        if(calanderDate != calanderDate2){
                            self.activities.remove(at: self.activities.firstIndex(of: activity)!)
                        }
                        
                    }
  
                }
                
                self.tableView.reloadData()
                
            }
        
        }
    }
    
    var locationIds = [String]()
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetchSchedules(from: Airtable.scheduleLink + Airtable.key)
        
        if let valueExist = speaker{
            
            var events = [Schedule]()
            
            if let speakingEvents = valueExist.fields.speakingEvents{
                for s in speakingEvents{
                    
                    Airtable.getActivity(from: Airtable.scheduleLink + "/" + s + Airtable.key){ data in
                        
                        events.append(data)
                        
                    }
                    
                }
                activities = events
            }
            

        }
        else{
            Airtable.fetchSchedule(from: Airtable.scheduleLink + Airtable.key){data in
                self.activities = data
            }
        }
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")

        self.tableView.backgroundColor = UIColor.clear
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return activities.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenActivity = activities[indexPath.section]
        performSegue(withIdentifier: "goToDetails", sender: self)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleCell
        
        cell.dateView.layer.cornerRadius = 10
        cell.dateLbl.layer.cornerRadius = 10
        cell.dateLbl.layer.masksToBounds = true
        cell.dateLbl.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cell.activityLbl.text = self.activities[indexPath.section].fields.activity
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: activities[indexPath.section].fields.start ?? "2017-01-09T11:00:00.000Z")!
        let calanderDate = Calendar.current.dateComponents([.minute,.hour,.day, .year, .month], from: date)
        let dateEnd = dateFormatter.date(from: activities[indexPath.section].fields.end ?? "2017-01-09T11:00:00.000Z")!
        let calanderDateEnd = Calendar.current.dateComponents([.minute,.hour,.day, .year, .month], from: dateEnd)
        cell.dateLbl.text = calanderDate.day!.description + "/" + calanderDate.month!.description + "/" + calanderDate.year!.description
        
        cell.startLbl.text = calanderDate.hour!.description + "h" + calanderDate.minute!.description
        
        if(calanderDate.minute == 0){
            cell.startLbl.text! += "0"
        }
        if(calanderDateEnd.minute == 0){
            cell.endLbl.text! += "0"
        }
        
        cell.endLbl.text = calanderDateEnd.hour!.description + "h" + calanderDateEnd.hour!.description
        cell.typeLbl.text = activities[indexPath.section].fields.type
        print(locationIds.count)
        //cell.locationLbl.text = locationIds[indexPath.row]
        
        cell.layer.cornerRadius = 30
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.init(named: "Slate")?.cgColor
        //cell.backgroundColor = UIColor.white
        
        
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let vc = segue.destination as? DetailViewController
        vc?.schedule = chosenActivity
        // Pass the selected object to the new view controller.
    }

}
