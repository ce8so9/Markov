//
//  ViewController.swift
//  Markov
//
//  Created by elias on 10/3/15.
//  Copyright (c) 2015 nus.cs3217. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var derp = Markov()
        print(derp.generate(200))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

