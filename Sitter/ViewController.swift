//
//  ViewController.swift
//  Sitter
//
//  Created by ECE Tech on 08/03/2018.
//  Copyright © 2018 ECE Tech. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DBDelegate {
    @IBOutlet var labelTitle :UILabel!

    
    let dbController = databaseController()
    
    func dataLoaded(datas:ITunesAPIResults?)
    {
        
        guard let datas = datas else
        {
            print("Erreur de Data")
            return
        }
        
        labelTitle.text = datas.title
        // OK
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbController.delegate = self
        if dbController.load() == false
        {
            print("Erreur")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
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
