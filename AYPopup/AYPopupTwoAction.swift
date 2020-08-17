//
//  AYPopupTwoAction.swift
//  Souqti
//
//  Created by WDP on 13/08/20.
//  Copyright © 2020 WDP. All rights reserved.
//

import UIKit

protocol AYPopupDelegate {
    func handleAction(action: Bool)
   
}


class AYPopupTwoAction: UIViewController {
    
    var delegate: AYPopupDelegate?


    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var imgLogo: UIImageView!
    
    @IBOutlet weak var btnCloase: UIButton!
    @IBOutlet weak var btn_No: UIButton!
    @IBOutlet weak var btn_Yes: UIButton!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        btn_Yes.setButtonCornerRadious()
        btn_No.setButtonCornerRadious()
        baseView.setRadius(radius: 5.0)
        btn_No.setBorderWithColor(border: 1.0, color: UIColor.themeColor())
        btn_No.setTitleColor( UIColor.themeColor(), for: .normal)
        btn_Yes.setTitleColor( UIColor.white, for: .normal)
        btn_No.backgroundColor = .white
        btn_Yes.backgroundColor = UIColor.themeColor()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refresh(_:)), name:NSNotification.Name(rawValue: "Refresh"), object: nil)

    }
    
     @objc func refresh(_ notification:Notification) {

        if let title = notification.userInfo?["title"] as? String {
            lbl_title.text = title
        }
        if let desc = notification.userInfo?["desc"] as? String {
            lbl_description.text = desc
        }
        if let yes = notification.userInfo?["yes"] as? String {
            btn_Yes.setTitle(yes, for: .normal)
        }
        if let no = notification.userInfo?["no"] as? String {
            btn_No.setTitle(no, for: .normal)
        }
        
        if let img = notification.userInfo?["img"] as? String {
            imgLogo.image = UIImage(named: img)
        }
      
        
    }
    
    func changeLabel(Log: String) {
        lbl_title.text = Log
        print (Log)
    }
    
   func setUpTitels(title:String,description:String,yesTitle:String,noTitle:String,imgName:String){
        lbl_title.text = title
        lbl_description.text = description

        imgLogo.image = UIImage(named: imgName)

        btn_Yes.titleLabel?.text = yesTitle
        btn_No.titleLabel?.text = noTitle
    }
    
    //MARK: - Close Click
    @IBAction func close_Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: -  YES Click
    @IBAction func Yes_Click(_ sender: Any) {
         self.delegate?.handleAction(action: true)
         self.dismiss(animated: true, completion: nil)
    }
    //MARK: - No Click
    @IBAction func No_Click(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- functions for the viewController
    static func showPopup(parentVC: UIViewController,title:String){
        
        //creating a reference for the dialogView controller
        if let presentedViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AYPopupTwoAction") as? AYPopupTwoAction {
            presentedViewController.modalPresentationStyle = .custom
            presentedViewController.modalTransitionStyle = .crossDissolve
            presentedViewController.view.backgroundColor = UIColor.init(white: 0.0, alpha: 0.8)
            presentedViewController.delegate = parentVC as? AYPopupDelegate
            parentVC.present(presentedViewController, animated: true, completion: nil)
        }
        
    }
    

}
