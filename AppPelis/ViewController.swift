//
//  ViewController.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 06/01/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goTMDB(_ sender: Any) {
        
        let viewCOntroller = ContentPrincipalRouter.createModule()
        self.navigationController?.pushViewController(viewCOntroller, animated: true)
    }
    

}

