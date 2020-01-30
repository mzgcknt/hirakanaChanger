//
//  ViewController.swift
//  hirakanaChanger
//
//  Created by 溝口健太 on 2020/01/29.
//  Copyright © 2020 溝口健太. All rights reserved.
//

import UIKit
import TextFieldEffects

class ViewController: UIViewController {
  @IBOutlet weak var convertedText: UITextView!
  @IBOutlet weak var convertField: KaedeTextField!
  @IBOutlet weak var errorText: UILabel!
  @IBOutlet weak var convertSwitcher: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }


}

