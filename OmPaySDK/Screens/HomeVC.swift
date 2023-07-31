//
//  HomeVC.swift
//  OMPayPaymentApp
//
//  Created by mac on 13/07/23.
//

import UIKit
import Alamofire


struct ClientTokens : Codable {
    let username: String?
    let password: String?
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case password = "password"
    }
}



class HomeVC: BaseViewController {
    let alamoFire:NewAlamofireHelper = NewAlamofireHelper();
    var strEncodedString: String = ""

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
       self.NewGetClientTokenService()
       
    }
   
    @IBAction func OnClickCreditOrDebitCards(_ sender: UIButtonX) {
        let VC = (MainClass.mainStoryboard.instantiateViewController(withIdentifier: "CardDetailsVC") as? CardDetailsVC)!
        
        VC.strAccessToken = Defaults[PDUserDefaults.ClientTokens]
        self.navigationController!.pushViewController(VC, animated: true)
    }
}


/* backup
 func MakeRequestParams() {
      let dic = ClientTokens(username: CLIENT_CREDENTIALS.CLIENT_ID, password: CLIENT_CREDENTIALS.ApiDev_MERCHANT_ID)
      self.arrParameters.append(dic)
      print("arrParameters",arrParameters)
      
      CreateJSONClientTokens()
  }
  
  func CreateJSONClientTokens() {
      
      var user_name = ""
      var password = ""
      var dicMainData: ClientTokens?
      
      for i in self.arrParameters {
          user_name = i.username!
          password = i.password!
          
          let dicData = ClientTokens(username: user_name, password: password)
          dicMainData = dicData
      }
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      
      if let jsonData = try? encoder.encode(dicMainData),
          let strJSON = String(data: jsonData, encoding: .utf8) {
          print("strJSON = \(strJSON)")
          self.strClientTokensJSON = strJSON
      }
      
      self.GetClientTokenService(param: self.strClientTokensJSON)
  }*/
  
