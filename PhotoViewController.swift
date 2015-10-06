//
//  PhotoViewController.swift
//  MemTest
//
//  Created by Kailash Ramaswamy on 05/10/15.
//  Copyright © 2015 NCh. All rights reserved.
//

import UIKit
import Social
import MessageUI

class PhotoViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var author: UITextField!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var titleb: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareThis(sender: AnyObject) {
        
        
        
let sharing = UIAlertController(title: "How do you want to share the drawing?", message: "Choose", preferredStyle: UIAlertControllerStyle.ActionSheet)

    let bleep = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.Default, handler:{ (action) -> Void in
                        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
                            
                            let tweeter = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                            
                            tweeter.addImage(screenshot)
                            
                            self.presentViewController(tweeter, animated: true, completion: nil)
                            
                            
                        }else {
                            self.alertALL("Twitter profile not attached", message: "Please navigate to Settings->Twitter and access profile to Share via Twitter")
                        }
                    })
        
        let mail = UIAlertAction(title: "E-mail", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            
            if MFMailComposeViewController.canSendMail() == true {
                let mailer = MFMailComposeViewController()
                mailer.mailComposeDelegate = self
                mailer.setSubject("Check out my drawing")
                
                let data = UIImagePNGRepresentation(screenshot)
                mailer.addAttachmentData(data!, mimeType: "image/png", fileName: "My drawing")
                
                self.presentViewController(mailer, animated: true, completion: nil)
            
                
        
                
            }else {
                self.alertALL("Mail failed", message: "Please try later")
            }
            
         
        })
        
      let posting =  UIAlertAction(title: "Post", style: UIAlertActionStyle.Default) { (actions) -> Void in
            
        let parameters = ["Title": self.titleb.text!, "Description": self.desc.text!, "Author":self.author.text!] as Dictionary<String,String>
            
            let url = NSURL(string: "http://jsonplaceholder.typicode.com/posts")
            
            let session = NSURLSession.sharedSession()
            
            let request = NSMutableURLRequest(URL: url!)
            
            request.HTTPMethod = "POST"
            
            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions())
        
 
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Body: \(strData)")

            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
           
                if let parseJSON = json {
                    let success = parseJSON["success"] as? Int
                    print("Success: \(success)")
                    self.alertALL("\(success)", message: "ID")
                }
                else {
                
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: \(jsonStr)")
                }

        })
    
    
        task.resume()
        
        }
    
        let cancelP = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        sharing.addAction(bleep)
        sharing.addAction(mail)
        sharing.addAction(posting)
        sharing.addAction(cancelP)
        
        presentViewController(sharing, animated: true, completion: nil)
        
        
    }
    
    
    func mailComposeController(_: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?){
        switch result.rawValue{
        case MFMailComposeResultSent.rawValue:
              print("Mail Sent")
        case MFMailComposeResultFailed.rawValue:
              print("Mail Failed")
        case MFMailComposeResultCancelled.rawValue:
            print("Mail Cancelled")
        default: break
            
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func alertALL(titles:String, message: String){
        
        let allu = UIAlertController(title: titles, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let yum = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        allu.addAction(yum)
        
        presentViewController(allu, animated: true, completion: nil)
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
