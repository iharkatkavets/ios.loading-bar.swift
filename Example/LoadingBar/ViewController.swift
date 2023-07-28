//
//  ViewController.swift
//  LoadingBar
//
//  Created by Ihar Katkavets on 07/28/2023.
//  Copyright (c) 2023 Ihar Katkavets. All rights reserved.
//

import UIKit
import LoadingBar

class ViewController: UIViewController {
    @IBOutlet private var loadingBar1: LoadingBar?
    @IBOutlet private var loadingBar2: LoadingBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingBar1?.stripColor0 = UIColor.green
        loadingBar1?.stripColor1 = UIColor.blue
    }

    @IBAction func progressValueDidChange(_ button: UISlider) {
        loadingBar1?.progress = CGFloat(button.value)
        loadingBar2?.progress = CGFloat(button.value)
    }
    
    @IBAction func startAnimating(_ button: UIButton) {
        loadingBar1?.startAnimating()
        loadingBar2?.startAnimating()
    }
    
    @IBAction func stopAnimating(_ button: UIButton) {
        loadingBar1?.stopAnimating()
        loadingBar2?.stopAnimating()
    }
}

