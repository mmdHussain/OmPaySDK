//
//  Constant.swift
//  OMPayPaymentApp
//
//  Created by mac on 11/07/23.
//

import Foundation
import Toast_Swift
import UIKit

struct CLIENT_CREDENTIALS {
    static let MERCHANT_ID = "812xy7d93v1fiz94/"
    static let CLIENT_ID = "cn1b4iyxzw8kx9fj"
    static let CLIENT_SECRET = "761rfh6w7in9nbcy"
    
    static let ApiDev_MERCHANT_ID = "w3z8dfhkzvfq0j9n"
    static let CONFIGURATION_443 = "v1/client/"
    static let CONFIGURATION_V1_MERCHANT = "/v1/merchants/"
   
}
//------------------------------------------------------
struct API_NAME {
    //Sandbox
    static let ClientToken = "client_token"
    static let CreditCardNonce = "/credit-card-nonce"
    //dev
    static let ClientTokens = "client_tokens"
    //static let TransactionGetClientToken = "transactionsgetClientToken"
    static let Transactions = "transactions"
    
    static let CONFIGURATION = "configuration"
    
    static let OperationName = "operationName"
    static let ClientConfiguration = "ClientConfiguration"
    static let Source = "source"
    static let Client = "client"
    static let SessionId = "sessionId"
    
}
//------------------------------------------------------
struct Parameters {
    static let username = "username"
    static let password = "password"
    
    
    static let GrantCredentails = "'grant_type=client_credentials'"
  
    static let Number = "number"
    static let ExpireMonth = "expire_month"
    static let ExpireYear = "expire_year"
    static let CVV2 = "cvv2"
    
    
    
}

struct SDK_HEADERS {
    static let ContentType = "Content-Type"
    static let Authorization = "Authorization"
}

struct SDK_HEADERS_VALUES {
    static let ContentTypeValue = "application/json"
    static let BasicAuthorizationValue = "Basic"
    static let BearerAuthorizationValue = "Bearer"
}

class BASE64_CONVERSION {
    func base64EncodeString(_ string: String) -> String? {
        if let data = string.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
}
class CurrentYear {
    func getCurrentYear() -> Int {
        let calendar = Calendar.current
        let currentDate = Date()
        let year = calendar.component(.year, from: currentDate)
        return year
    }
}

class ToastView: UIView {
    private let toastLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = UIColor(white: 0, alpha: 0.7)
        label.clipsToBounds = true
        label.layer.cornerRadius = 8.0
        return label
    }()

    func showToast(message: String) {
        toastLabel.text = message
        
        if let keyWindow = UIApplication.shared.keyWindow {
            keyWindow.addSubview(toastLabel)
            toastLabel.translatesAutoresizingMaskIntoConstraints = false
            let centerXConstraint = NSLayoutConstraint(item: toastLabel, attribute: .centerX, relatedBy: .equal, toItem: keyWindow, attribute: .centerX, multiplier: 1, constant: 0)
            let bottomConstraint = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: keyWindow, attribute: .bottom, multiplier: 1, constant: -30)
            let leadingConstraint = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: keyWindow, attribute: .leading, multiplier: 1, constant: 20)
            let trailingConstraint = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: keyWindow, attribute: .trailing, multiplier: 1, constant: -20)

            NSLayoutConstraint.activate([centerXConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
            
            UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
                self.toastLabel.alpha = 1.0
            }) { _ in
                UIView.animate(withDuration: 2.0, delay: 1.0, options: .curveEaseIn, animations: {
                    self.toastLabel.alpha = 0.0
                }) { _ in
                    self.toastLabel.removeFromSuperview()
                }
            }
        }
    }
}


