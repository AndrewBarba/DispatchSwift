//
//  ViewController.swift
//  DispatchSwift
//
//  Created by Andrew Barba on 12/2/15.
//  Copyright © 2015 abarba.me. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: dispatch_source_t!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Dispatch.main {
            print("Hello, Main")
        }
        
        Dispatch.async {
            print("Hello, Background")
        }
        
        Dispatch.main(delay: 2.0) {
            print("Hello, 2 seconds later...")
        }
        
        Dispatch.async(delay: 0.5) {
            print("Hello, 0.5 seconds later...")
        }
        
        timer = Dispatch.timerMain(interval: 0.5) {
            print("Hello, timer")
        }
        
        Dispatch.async(delay: 4.0) {
            self.timer.invalidate()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

