//
//  ClientApi.swift
//  OMPayPaymentApp
//
//  Created by mac on 11/07/23.
//

import Foundation

class AppUrl: NSObject {
    class func AppName() -> String {
        return "OMPaySDK"
    }

 
   
    static let mainDomain_New: String = "https://api.dev.openacquiring.com/demo/payments/"
   // static let mainDomain_CreditNonce: String = "https://api.dev.openacquiring.com/v1/merchants/"
    static let BASEURL_443: String = "https://api.dev.openacquiring.com:443/"
    
    
    class func ClientTokensURL() -> String {
        return mainDomain_New +  API_NAME.ClientTokens
    }//1
    
    class func ConfigurationURL() -> String {
        return BASEURL_443 + CLIENT_CREDENTIALS.CONFIGURATION_443 + API_NAME.CONFIGURATION
    }//2
    
    class func CreditCardNonceURL() -> String {
        return API_NAME.CreditCardNonce
        //return BASEURL_443 + CLIENT_CREDENTIALS.ApiDev_MERCHANT_ID  +  API_NAME.CreditCardNonce
    }
    
    class func TransactionsGetClientToken() -> String {
        return mainDomain_New + API_NAME.Transactions //+ API_NAME.TransactionGetClientToken
    }

}












extension AppUrl {
    //static let mainDomain: String = "https://api.sandbox.ompay.com/v1/merchants/"
    
    //    class func ClientTokenURL() -> String {
    //        return mainDomain + CLIENT_CREDENTIALS.MERCHANT_ID + API_NAME.ClientToken
    //    }//Sandbox
    
    //    class func CreditCardNonceURL() -> String {
    //        return mainDomain + CLIENT_CREDENTIALS.MERCHANT_ID + API_NAME.CreditCardNonce
    //    }//Sandbox
}
