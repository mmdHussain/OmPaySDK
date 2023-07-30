//
//  BaseViewController.swift
//  LahaWorld
//
//  Created by mac on 15/07/19.
//  Copyright © 2019 shrinkcom. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {
    var hud = UIView()
    
    func showCustomHUD(){
        hud = UIView().getHUD(spinner: UIActivityIndicatorView())
    }
    
    func hideCustomHUD(){
        hud.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showAnnouncment(withMessage message: String, closer:(()-> Void)? = nil){
        let alertController =   UIAlertController(title: "Snaplify", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { (action:UIAlertAction!) in
            closer?()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK:Queue App
    struct MainClass {
        static let appDelegate = UIApplication.shared.delegate as! AppDelegate
        static let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        static let HomeStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
        static let EventStoryboard = UIStoryboard(name: "Events", bundle: Bundle.main)
        static let GuestStoryboard = UIStoryboard(name: "Guest", bundle: Bundle.main)
        static let DrinkStoryboard = UIStoryboard(name: "Drink", bundle: Bundle.main)
        static let MenuStoryboard = UIStoryboard(name: "Menu", bundle: Bundle.main)

    }
}

extension UIView{
    func getHUD(spinner: UIActivityIndicatorView) -> UIView {
        let window = UIApplication.shared.delegate?.window
        window??.resignFirstResponder()
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.center = (window??.rootViewController?.view.center)!
        spinner.center = view.center
        spinner.startAnimating()
        view.addSubview(spinner)
        window??.addSubview(view)
        return view
    }
}

