//
//  OmPayExtension.swift
//  OmPaySDK
//
//  Created by mac on 20/07/23.
//

import Foundation
import UIKit
import Alamofire



extension HomeVC {
    //MARK: ---Get Client Token Web Service----
   /* func GetClientTokenService(param: String) {
        ERProgressHud.sharedInstance.show(withTitle: "Please Wait")
        let url =  AppUrl.ClientTokensURL()
       
        //let dictParam = "\(Parameters.GrantCredentails)"
       
       
        let dictParam = param
        print("url:- " ,url)
        print("dictParam:- " ,dictParam)
        
        alamoFire.getClientTokenResponse(url: url, methodName: AlamofireHelper.POST_METHOD, paramData: dictParam) { (response, data, error) -> (Void) in
            print("Response of get:-",response)
            if (error == nil) {
                ERProgressHud.sharedInstance.hide()
                let responseData = response
                if (responseData.value(forKey: "value") as? String) != "" || (responseData.value(forKey: "value") as? String) != nil {
                    Defaults[PDUserDefaults.ClientTokens] = (responseData.value(forKey: "value") as? String)!
                }else{
                    Defaults[PDUserDefaults.ClientTokens] = ""
                }
             
          
          }else {
                let error_responseData = response
                print("error_responseData: \(error_responseData)")
            }
        }
    }*/
   //MARK: ---New Client Token Service---
    func NewGetClientTokenService() {
        ERProgressHud.sharedInstance.show(withTitle: "Please Wait")
        let url =  AppUrl.ClientTokensURL()
        print("url of Client tokens :- " ,url)
        
        alamoFire.new_getClientTokenResponse(url: url, methodName: NewAlamofireHelper.POST_METHOD, paramData: nil) { (response, data, error) -> Void in
            print("Response of get client tokens :-",response)
            if (error == nil) {
                ERProgressHud.sharedInstance.hide()
                let responseData = response
                if (responseData.value(forKey: "value") as? String) != "" || (responseData.value(forKey: "value") as? String) != nil {
                    Defaults[PDUserDefaults.ClientTokens] = (responseData.value(forKey: "value") as? String)!
                    print("new client token:- \(Defaults[PDUserDefaults.ClientTokens])")
                }else{
                    Defaults[PDUserDefaults.ClientTokens] = ""
                }
           }else {
                let error_responseData = response
                print("error_responseData: \(error_responseData)")
            }
        }
   }
   
    
}
extension CardDetailsVC {
    //MARK: ---Configuration Service---
    func ConfigurationService(param: String, strAccessToken: String) {
        ERProgressHud.sharedInstance.show(withTitle: "Please Wait")
        let url =  AppUrl.ConfigurationURL()
        print("url of Configuration Service :- " ,url)
        
        alamoFire.new_ConfigurationResponse(url: url, methodName: NewAlamofireHelper.POST_METHOD, client_token: Defaults[PDUserDefaults.ClientTokens], paramData: param) { (response, data, error) -> Void in
            print("Response of Configuration api:-",response)
            
            if (error == nil) {
                ERProgressHud.sharedInstance.hide()
                let responseData = response
                print("responseData=\(responseData)")
                let dicData = (responseData.value(forKey: "data") as? NSDictionary)!
                let dicClientConfiguration = (dicData.value(forKey: "clientConfiguration") as? NSDictionary)!
                
                if (dicClientConfiguration.value(forKey: "merchantId") as? String) != "" || (dicClientConfiguration.value(forKey: "merchantId") as? String) != nil {
                    self.strMerchantId = (dicClientConfiguration.value(forKey: "merchantId") as? String)!
                }else{
                    self.strMerchantId = ""
                }
                
                if (dicClientConfiguration.value(forKey: "clientApiUrl") as? String) != "" || (dicClientConfiguration.value(forKey: "clientApiUrl") as? String) != nil {
                    self.strClientAPI = (dicClientConfiguration.value(forKey: "clientApiUrl") as? String)!
                }else{
                    self.strClientAPI = ""
                }
                print("MERCHANT ID :- \(self.strMerchantId)")
                print("CLIENTAPI ID :- \(self.strClientAPI)")
            }else{
                let error_responseData = response
                print("error_responseData: \(error_responseData) \(Defaults[PDUserDefaults.StatusCode])")
              if Defaults[PDUserDefaults.StatusCode] == "9999" ||  Defaults[PDUserDefaults.StatusCode] == "401"{
                  self.view.makeToast("Internal server error")
              }
            }
         }
    }
    
    func CreditCardNonceService(card_number: String , expire_month: String ,expire_year: String, cvv: String,ClientAPIURL: String,merchantID: String)  {
        ERProgressHud.sharedInstance.show(withTitle: "Please Wait")
        let baseURL = "\(ClientAPIURL + CLIENT_CREDENTIALS.CONFIGURATION_V1_MERCHANT + merchantID)"

        print("baseURL=\(baseURL)")
        let url = baseURL + AppUrl.CreditCardNonceURL()
        let dictParam = "\(strCardJSON)"
        print("url of CreditCardNonce:-",url)
        print("dictParam of CreditCardNonce:-",dictParam)
        
        alamoFire.getCreditNonceResponse(url: url, methodName: AlamofireHelper.POST_METHOD, client_token: self.strAccessToken, paramData: dictParam) { (response, data, error) -> (Void) in
            
            if (error == nil) {
                ERProgressHud.sharedInstance.hide()
                let responseData = response
                print("responseData of CreditNonce:-",responseData)
                
                
                let dicData = (responseData.value(forKey: "data") as? NSDictionary)!
                
                if dicData.value(forKey: "credit_card_nonce") as? String != nil ||  dicData.value(forKey: "credit_card_nonce") as? String != "" {
                    self.strCreditCardNonce = (dicData.value(forKey: "credit_card_nonce") as? String)!
                }else{
                    self.strCreditCardNonce =  ""
                }
                
                if dicData.value(forKey: "last4") as? String != nil || dicData
                    .value(forKey: "last4") as? String != "" {
                    self.strLastFour = (dicData.value(forKey: "last4") as? String)!
                }else{
                    self.strLastFour = ""
                }
                print("strCreditCardNonce : ",self.strCreditCardNonce , self.strLastFour)
                
                let VC = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "CreateTransactionVC") as! CreateTransactionVC
                
                VC.strCreditNonce =  self.strCreditCardNonce
                VC.strLastFourDigits = self.strLastFour
                VC.strDeviceData = "null"
                self.navigationController?.pushViewController(VC, animated: true)
           }
        }
    }
}


extension CreateTransactionVC {
    func TransactionsGetClientToken(param: String) {
        ERProgressHud.sharedInstance.show(withTitle: "Please Wait")
        let url =  AppUrl.TransactionsGetClientToken()
        let dictParam = param
        print("url:- " ,url)
        print("dictParam:- " ,dictParam)
        
        alamoFire.TransactionsGetClientToken(url: url, methodName: AlamofireHelper.POST_METHOD, paramData: dictParam) { (response, data, error) -> (Void) in
            ERProgressHud.sharedInstance.hide()
            print("Response of get:-",response)
            if (error == nil) {
                let responseData = response
                print("responseData of transaction api =\(responseData)")
                self.viewSuccessResponse.isHidden = false
               // self.lblSuccessResponse.text! = "\(responseData)"
                let dictionary: [String: Any] = responseData as! [String : Any]
                if let message = dictionary["message"] as? String {
                            // Extract the "Successful" part from the message
                            let searchString = "Successful with payload: "
                            if let successIndex = message.range(of: searchString)?.upperBound {
                                let successMessage = String(message[successIndex...])
                                self.lblSuccessResponse.text! = successMessage
                            }
                        }
                    
                
                /*
                 {
                     message = "Successful with payload: {\"id\":\"QNKJR6FYJ8UW1FUX54D1\",\"reference_id\":\"QNKJR6FYJ8UW1FUX54D1\",\"state\":\"authorised\",\"result\":{\"authorisation_code\":\"546329\",\"code\":\"0000\",\"description\":\"Approved\"},\"intent\":\"AUTH\",\"payer\":{\"payment_type\":\"CC\",\"funding_instrument\":{\"credit_card\":{\"id\":\"054ec54d-3040-48e5-b047-4b00b970e818\",\"type\":\"Visa\",\"expire_month\":12,\"expire_year\":2024,\"name\":\"Nazim Napaul\",\"cvv_check\":\"Y\",\"avs_check\":\"S\",\"last4\":\"4821\",\"bin\":\"400552\",\"bin_data\":{\"bin\":\"400552\",\"country_code\":\"MU\",\"country_name\":\"Mauritius\",\"bank_name\":\"MCB\",\"card_scheme\":\"Visa\",\"card_type\":\"Credit\",\"card_category\":\"1\"}}},\"payer_info\":{\"id\":\"fca3a969-6e54-437e-92b3-fdde944376bc\",\"email\":\"nazim@gmail.com\",\"name\":\"Nazim Napaul\",\"billing_address\":{\"phone\":{\"country_code\":\"230\",\"number\":\"87990090\"},\"line1\":\"xyz street\",\"line2\":\"bel rose\",\"city\":\"Port Louis\",\"country_code\":\"MU\",\"postal_code\":\"72101\"}}},\"transaction\":{\"amount\":{\"currency\":\"USD\",\"total\":\"1\"},\"type\":\"1\",\"mode\":\"1\",\"shipping_address\":{\"phone\":{}},\"invoice_number\":\"12345\"},\"custom\":{},\"create_time\":\"2023-07-27T11:04:53Z\",\"three_d\":{}}";
                 }
                 */
                
                
              
          }else {
                let error_responseData = response
                print("error_responseData: \(error_responseData) \(Defaults[PDUserDefaults.StatusCode])")
              if Defaults[PDUserDefaults.StatusCode] == "404" {
                   self.viewFailureResponse.isHidden = false
                   self.viewMain.isHidden = true
              }else{
                  self.viewFailureResponse.isHidden = true
                  self.viewMain.isHidden = false
              }
              
            }
        }
    }
}







/*
 func GetClientTokenService() {
     
    let url =  AppUrl.ClientTokenURL()
    
     let dictParam = "\(Parameters.GrantCredentails)"
     print("url:- " ,url)
     print("dictParam:- " ,dictParam)
     
     alamoFire.getClientTokenResponse(url: url, methodName: AlamofireHelper.POST_METHOD, paramData: dictParam) { (response, data, error) -> (Void) in
         print("Response of get:-",response)
         if (error == nil) {
             let responseData = response
             if (responseData.value(forKey: "accessToken") as? String) != "" || (responseData.value(forKey: "accessToken") as? String) != nil   {
                
                 Defaults[PDUserDefaults.ClientToken] = (responseData.value(forKey: "accessToken") as? String)!
             }else{
                
                 Defaults[PDUserDefaults.ClientToken] = ""
             }
       
       }else {
             let error_responseData = response
             print("error_responseData: \(error_responseData)")
         }
     }
 }
 */
