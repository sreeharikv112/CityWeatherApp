//
//  ChangeCityViewController.swift
//  CityWeatherApp
//
//  Created by Hari on 16/06/19.
//  Copyright © 2019 Hari. All rights reserved.
//

import UIKit

protocol ChangedCityDelegate {
    
    func userChangedCity( name : String)
    
}

class ChangeCityViewController: UIViewController {
    
    @IBOutlet weak var changeCityTextField: UITextField!
    var changedCityDelegate : ChangedCityDelegate?
    @IBOutlet weak var getWeatherBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        drawShadow(getWeatherBtn)
    }
    
    func drawShadow(_ button: UIButton){
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        let userEnteredCity : String = changeCityTextField.text!
        changedCityDelegate?.userChangedCity(name: userEnteredCity)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
