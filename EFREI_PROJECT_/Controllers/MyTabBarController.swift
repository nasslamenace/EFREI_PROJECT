//
//  MyTabBarController.swift
//  EFREI_PROJECT_
//
//  Created by Nassim Guettat on 07/04/2021.
//

import UIKit

class MyTabBarController: UITabBarController {
    
    var tabBarIteam = UITabBarItem()
    
    var homeIcon = UIImageView(image: UIImage(systemName:  "house.circle"))
    var companyIcon = UIImageView(image: UIImage(systemName:  "dollarsign.circle"))
    var speakersIcon = UIImageView(image: UIImage(systemName:  "person.crop.circle"))
    var mapIcon = UIImageView(image: UIImage(systemName:  "mappin.circle"))
    var barView = UIView()
    
    enum IsSelected {
        case home
        case company
        case speaker
        case map
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.frame.origin.y = self.tabBar.frame.origin.y - 15
        
        let homeView = UIView(frame: CGRect.init(x: self.tabBar.frame.minX, y: self.tabBar.frame.minY, width: tabBar.frame.width / 4, height: tabBar.frame.height))
        homeView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(homeSelected)))
        homeView.backgroundColor = UIColor.white
        
        barView = UIView(frame: CGRect.init(x: 0, y: self.tabBar.frame.maxY - 5, width: tabBar.frame.width / 4, height: 5))
        
        barView.backgroundColor = UIColor.darkGray
        homeIcon.frame =  CGRect(x: homeView.frame.width/4 , y: homeView.frame.height/8, width: homeView.frame.width/2, height: homeView.frame.width/2)
        

        
        homeView.addSubview(homeIcon)
       
        let companiesView = UIView(frame: CGRect.init(x: self.tabBar.frame.minX + tabBar.frame.width / 4 , y: self.tabBar.frame.minY, width: tabBar.frame.width / 4, height: tabBar.frame.height))
        
        companiesView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(companiesSelected)))
        companiesView.backgroundColor = UIColor.white
        
        companyIcon.frame = CGRect(x: companiesView.frame.width/4 , y: companiesView.frame.height/8, width: companiesView.frame.width/2, height: companiesView.frame.width/2)
        
        companyIcon.contentMode = .scaleToFill
        companiesView.addSubview(companyIcon)
        
        let speakersView = UIView(frame: CGRect.init(x: self.tabBar.frame.minX + (tabBar.frame.width / 4) * 2 , y: self.tabBar.frame.minY, width: tabBar.frame.width / 4, height: tabBar.frame.height))
        speakersView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(speakersSelected)))
        speakersView.backgroundColor = UIColor.white
        
        speakersIcon.frame = CGRect(x: speakersView.frame.width/4 , y: speakersView.frame.height/8, width: speakersView.frame.width/2, height: speakersView.frame.width/2)
   
        
        
        speakersView.addSubview(speakersIcon)
        
        
        let mapView = UIView(frame: CGRect.init(x: self.tabBar.frame.minX + (tabBar.frame.width / 4) * 3 , y: self.tabBar.frame.minY, width: tabBar.frame.width / 4, height: tabBar.frame.height))
        mapView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(mapSelected)))
        mapView.backgroundColor = UIColor.white
        
        mapIcon.frame = CGRect(x: mapView.frame.width/4 , y: mapView.frame.height/8, width: mapView.frame.width/2, height: mapView.frame.width/2)
        
        
        
        mapView.addSubview(mapIcon)
        
        
        
        
        homeIcon.tintColor = UIColor(named: "Slate")
        companyIcon.tintColor = UIColor(named: "Slate")
        speakersIcon.tintColor = UIColor(named: "Slate")
        mapIcon.tintColor = UIColor(named: "Slate")
        
        barView.backgroundColor = UIColor(named: "lipstick")
        
        
        
        self.view.insertSubview(homeView, belowSubview: self.view)
        self.view.insertSubview(speakersView, belowSubview: self.view)
        self.view.insertSubview(companiesView, belowSubview: self.view)
        self.view.insertSubview(mapView, belowSubview: self.view)
        self.view.insertSubview(barView, belowSubview: self.view)
        
    }
    
    func returnToNormal(icon: UIImageView){
        icon.layer.borderWidth = 0
        icon.layer.cornerRadius = 0
    }
    func selectIcon(icon: UIImageView){
        icon.layer.borderWidth = 2
        icon.layer.borderColor = UIColor(named: "Slate")?.cgColor
        icon.layer.cornerRadius = homeIcon.frame.width / 2
    }
    
    func stopOthers(isSelected: IsSelected ){
        switch(isSelected){
        case.company:
            homeIcon.tintColor = UIColor(named: "Slate")
            speakersIcon.tintColor = UIColor(named: "Slate")
            mapIcon.tintColor = UIColor(named: "Slate")
            companyIcon.tintColor = UIColor(named: "lipstick")
            
            selectIcon(icon: companyIcon)
            returnToNormal(icon: homeIcon)
            returnToNormal(icon: speakersIcon)
            returnToNormal(icon: mapIcon)

            
        case .home:
            homeIcon.tintColor = UIColor(named: "lipstick")
            companyIcon.tintColor = UIColor(named: "Slate")
            speakersIcon.tintColor = UIColor(named: "Slate")
            mapIcon.tintColor = UIColor(named: "Slate")

            selectIcon(icon: homeIcon)
            returnToNormal(icon: companyIcon)
            returnToNormal(icon: speakersIcon)
            returnToNormal(icon: mapIcon)
            
            
            
        case .speaker:
            homeIcon.tintColor = UIColor(named: "Slate")
            companyIcon.tintColor = UIColor(named: "Slate")
            speakersIcon.tintColor = UIColor(named: "lipstick")
            mapIcon.tintColor = UIColor(named: "Slate")
            
            selectIcon(icon: speakersIcon)
            returnToNormal(icon: homeIcon)
            returnToNormal(icon: companyIcon)
            returnToNormal(icon: mapIcon)
        case .map:
            homeIcon.tintColor = UIColor(named: "Slate")
            companyIcon.tintColor = UIColor(named: "Slate")
            speakersIcon.tintColor = UIColor(named: "Slate")
            mapIcon.tintColor = UIColor(named: "lipstick")
            
            selectIcon(icon: mapIcon)
            returnToNormal(icon: homeIcon)
            returnToNormal(icon: speakersIcon)
            returnToNormal(icon: companyIcon)
        }
    }
    
    @objc func homeSelected(){
        UIView.animate(withDuration: 0.3, animations: {
            
            self.barView.frame.origin.x = 0
            self.stopOthers(isSelected: .home)
        })
        self.selectedIndex = 0
    }
    @objc func companiesSelected(){
        UIView.animate(withDuration: 0.3, animations: {
            
            self.barView.frame.origin.x = self.tabBar.frame.minX + self.tabBar.frame.width / 4
            self.stopOthers(isSelected: .company)
        })
        self.selectedIndex = 1
    }
    
    @objc func speakersSelected(){
        UIView.animate(withDuration: 0.3, animations: {
            
            self.barView.frame.origin.x = self.tabBar.frame.minX + (self.tabBar.frame.width / 4) * 2
            self.stopOthers(isSelected: .speaker)
        })

        self.selectedIndex = 2
    }
    
    @objc func mapSelected(){
        UIView.animate(withDuration: 0.3, animations: {
            
            self.barView.frame.origin.x = self.tabBar.frame.minX + (self.tabBar.frame.width / 4) * 3
            self.stopOthers(isSelected: .map)
        })

        self.selectedIndex = 3
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
