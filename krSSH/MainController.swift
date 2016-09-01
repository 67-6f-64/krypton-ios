//
//  ViewController.swift
//  krSSH
//
//  Created by Alex Grinman on 8/26/16.
//  Copyright © 2016 KryptCo Inc. All rights reserved.
//

import UIKit


class MainController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setKrLogo()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.app
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        self.tabBar.tintColor = UIColor.app
        self.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // temp delete
        let res = KeyManager.destroyKeyPair()
        log("destroy result: \(res)")

        
        guard KeyManager.hasKey() else {
            if let createNav = Resources.Storyboard.Main.instantiateViewController(withIdentifier: "CreateNavigation") as? UINavigationController
            {
                self.present(createNav, animated: true, completion: nil)
            }
            
            return
        }
        
        do {
            let kp = try KeyManager.sharedInstance().keyPair
            let pk = try kp.publicKey.exportSecp()
            
            log("started with: \(pk)")
        } catch (let e) {
            log("\(e)", LogType.error)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
