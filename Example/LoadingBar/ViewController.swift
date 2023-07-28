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

    @IBAction func progressValueDidChange(_ button: UISlider) {
        loadingBar1?.progress = CGFloat(button.value)
        loadingBar2?.progress = CGFloat(button.value)
    }
}

