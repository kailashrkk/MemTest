//
//  SettingsViewController.swift
//  MemTest
//
//  Created by Kailash Ramaswamy on 05/10/15.
//  Copyright © 2015 NCh. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var thickvalue: UILabel!
    @IBOutlet weak var thickView: UIImageView!
    @IBOutlet weak var thickSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sliderChanged(sender: AnyObject) {
      
        
        thickvalue.text = String(CGFloat(thickSlider.value))
        
        previewImg(thickSlider.value)
       
        
    }
    
    func previewImg(slidervalue:Float){
        
        UIGraphicsBeginImageContext(view.frame.size)
        thickView.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), CGFloat(thickSlider.value))
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0/255.0, 0.0/255.0, 0.0/255.0, 1.0)
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 42,42)
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),42,42)
        CGContextStrokePath(UIGraphicsGetCurrentContext())
        self.thickView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        thickness = CGFloat(thickSlider.value)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
