//
//  CompaniesCollectionViewController.swift
//  EFREI_PROJECT_
//
//  Created by Nassim Guettat on 05/04/2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class CompaniesCollectionViewController: UICollectionViewController {
    
    var chosenCompany: Sponsor?
    var sponsors = [Sponsor](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()

            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

     
        Airtable.fetchSponsors(from: Airtable.sponsorsLink + Airtable.key){ data in
            
            self.sponsors = data
        }
        
        
        
        // Do any additional setup after loading the view.
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sponsors.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "companyCell", for: indexPath) as! CompanyCell
        
        // Configure the cell

        cell.nameLbl.text = sponsors[indexPath.row].fields.name
        
        if let amount = sponsors[indexPath.row].fields.amount{
            cell.amountLbl.text = amount.description + " $"
        }
        else{
            cell.amountLbl.text = "No amount for now"
        }
        
        
        if let notes = sponsors[indexPath.row].fields.notes {
            cell.notesLbl.text = notes
        }
        else{
            cell.notesLbl.text = "There is no notes for now."
        }
        
        cell.statusLbl.text = sponsors[indexPath.row].fields.status
        cell.statusLbl.layer.cornerRadius = 11
        cell.statusLbl.layer.masksToBounds = true
        
        switch sponsors[indexPath.row].fields.status {
        case "Received pledged $":
            cell.statusLbl.backgroundColor = UIColor.init(named: "receivedPledged")
        case "Pledged $":
            cell.statusLbl.backgroundColor = UIColor.init(named: "pledged")
        case "Verbal committment to sponsor":
            cell.statusLbl.backgroundColor = UIColor.init(named: "verbal")
            cell.statusLbl.text = "Verbal committment"
        default:
            cell.statusLbl.backgroundColor = UIColor.init(named: "verbal")
        }
        
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.init(named: "Slate")?.cgColor
       
    
        return cell
    }

    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
