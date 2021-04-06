//
//  LocationAnnotationView.swift
//  EFREI_PROJECT_
//
//  Created by Nassim Guettat on 06/04/2021.
//

import UIKit
import MapKit

final class LocationAnnotationView: MKAnnotationView {
    // MARK: Initialization

    
    var myAnnotation: CustomPin?

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        frame = CGRect(x: 0, y: 0, width: 100, height: 80)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)

        myAnnotation = annotation as? CustomPin
        

        
        setupUI()
        
        canShowCallout = true
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup

    private func setupUI() {
        backgroundColor = .clear
        
        let str = myAnnotation?.location?.fields.image?[0].url
        
        let url = URL(string: str ?? "https://dl.airtable.com/HQImgZcSSkSwnuv7ir8R_rose-pavilion%202.jpeg")

        let view = UIView()
        
       
        
        /*DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                view.imageView.image = UIImage(data: data!)
            }
        }
        
        if let title = myAnnotation?.title{
            view.nameLbl.text = title
        }
        else{
            view.nameLbl.text = "error"
        }
 */
        
        
        
        
        addSubview(view)

        view.frame = bounds
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
