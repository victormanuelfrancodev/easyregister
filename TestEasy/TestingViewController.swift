//
//  TestingViewController.swift
//  TestEasy
//
//  Created by Victor on 7/26/17.
//  Copyright © 2017 Azcatl. All rights reserved.
//

import UIKit

class TestingViewController: UIViewController, TextFieldFormEasyDelegate {

    @IBOutlet weak var nombre: TextFieldFormEasy!
    override func viewDidLoad() {
        super.viewDidLoad()
        nombre.delegate = self
        nombre.mode = TextFieldFormEasyType.name.rawValue
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
