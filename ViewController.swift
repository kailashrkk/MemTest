//
//  ViewController.swift
//  MemTest
//
//  Created by Kailash Ramaswamy on 05/10/15.
//  Copyright © 2015 NCh. All rights reserved.
//

import UIKit



var screenshot = UIImage()
var thickness: CGFloat = 10.0

class ViewController: UIViewController {

    @IBOutlet weak var mainImg: UIImageView!
    var redm:CGFloat = 0.0/255.0
    var bluem:CGFloat = 0.0/255.0
    var greenm:CGFloat = 0.0/255.0
   
    
    var mouseMoved: Bool?
    
    var lastpoint = CGPoint()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func removeAll(sender: AnyObject) {
        
        self.mainImg.image = nil
        
    }
    @IBAction func eraser(sender: AnyObject) {
        
        redm = 255.0/255.0
        bluem = 255.0/255.0
        greenm = 255.0/255.0
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        mouseMoved = false
            if let touch = touches.first as? UITouch! {
                 lastpoint = touch.locationInView(self.view)
            }
           
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        mouseMoved = true
        
        if let touch = touches.first as? UITouch! {
            var currentPoint = touch.locationInView(self.view)
            
            UIGraphicsBeginImageContext(self.view.frame.size)
            mainImg.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastpoint.x, lastpoint.y)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), thickness)
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), redm, greenm, bluem, 1.0)
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            self.mainImg.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            lastpoint = currentPoint
        }
            
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (mouseMoved != false){
            UIGraphicsBeginImageContext(self.view.frame.size)
            mainImg.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), redm, greenm, bluem, 1.0)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), thickness)
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastpoint.x, lastpoint.y)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastpoint.x, lastpoint.y)
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            self.mainImg.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        }
    }
    
    

    @IBAction func colorSelected(sender: AnyObject) {
        
        switch sender.tag {
            
        case 1:
            redm = 0.0/255.0;
            greenm = 0.0/255.0;
            bluem = 0.0/255.0;
            break;
        case 2:
            redm = 105.0/255.0;
            greenm = 105.0/255.0;
            bluem = 105.0/255.0;
            break;
        case 3:
            redm = 119.0/255.0;
            greenm = 136.0/255.0;
            bluem = 153.0/255.0;
            break;
        case 4:
            redm = 0.0/255.0;
            greenm = 0.0/255.0;
            bluem = 255.0/255.0;
            break;
        case 5:
            redm = 255.0/255.0;
            greenm = 0.0/255.0;
            bluem = 0.0/255.0;
            break;
        case 6:
            redm = 102.0/255.0;
            greenm = 255.0/255.0;
            bluem = 0.0/255.0;
            break;
        case 7:
            redm = 255.0/255.0;
            greenm = 165.0/255.0;
            bluem = 0.0/255.0;
            break;
        case 8:
            redm = 246.0/255.0;
            greenm = 255.0/255.0;
            bluem = 11.0/255.0;
            
            break;
        default:
            redm = 0.0/255.0
            bluem = 0.0/255.0
            greenm = 0.0/255.0
        }
    }
    @IBAction func shareImage(sender: AnyObject) {
    }
    @IBAction func saveImage(sender: AnyObject) {
    }
    
    
    
    @IBAction override func unwindForSegue(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "sharePhoto" {
            
            if mainImg.image == nil {
                alertALL("No drawing found", message: "Please draw on board and then click on Share")
            }else{
            screenshot = mainImg.image!
            }
        }
    }
    
    
    func alertALL(titles:String, message: String){
        
        let allu = UIAlertController(title: titles, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let yum = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        allu.addAction(yum)
        
        presentViewController(allu, animated: true, completion: nil)
    }
}

