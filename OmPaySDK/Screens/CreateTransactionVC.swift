//
//  CreateTransactionVC.swift
//  OmPaySDK
//
//  Created by mac on 22/07/23.
//

import UIKit
import Alamofire


/*
 {"amount":"1.00","paymentMethodNonce":"0eb9fe0a-40ad-48eb-83ed-ffab563b0e93"}
 */

struct TransactionGetToken : Codable {
    
    let amount: String?
    let paymentMethodNonce: String?
    
    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case paymentMethodNonce = "paymentMethodNonce"
    }
}

class CreateTransactionVC: BaseViewController {
    
    @IBOutlet weak var lblCreditNonce: UILabel!
    @IBOutlet weak var lblCardLastFour: UILabel!
    @IBOutlet weak var lblDeviceData: UILabel!
    @IBOutlet weak var viewFailureResponse: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewSuccessResponse: UIView!
    @IBOutlet weak var lblSuccessResponse: UILabel!
    
    var strCreditNonce = ""
    var strLastFourDigits = ""
    var strDeviceData = ""
    
    var arrTransactionGetToken = [TransactionGetToken]()
    var strTransactionJSON = ""
    let alamoFire:AlamofireHelper = AlamofireHelper();

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewFailureResponse.isHidden = true
        self.viewSuccessResponse.isHidden = true
        self.ShowData()
        self.MakeRequestParams()
    }
    
    
    func ShowData() {
        self.lblCreditNonce.text! = "Nonce: \(strCreditNonce)"
        self.lblCardLastFour.text! = "Card Last four: \(strLastFourDigits)"
        self.lblDeviceData.text! = "Device Data: \(strDeviceData)"
    }
    func MakeRequestParams() {
        let dic = TransactionGetToken(amount: "1.00", paymentMethodNonce: self.strCreditNonce)
        self.arrTransactionGetToken.append(dic)
        print("arrTransactionGetToken",arrTransactionGetToken)
        
        
        
    }
    
    func CreateJSONTransactionClientTokens() {
        
        var amount = ""
        var payment_nonce = ""
        var dicMainData: TransactionGetToken?
        
        for i in self.arrTransactionGetToken {
            amount = i.amount!
            payment_nonce = i.paymentMethodNonce!
            
            let dicData = TransactionGetToken(amount: amount, paymentMethodNonce: payment_nonce)
            dicMainData = dicData
        }
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        if let jsonData = try? encoder.encode(dicMainData),
            let strTransactionJSON = String(data: jsonData, encoding: .utf8) {
            print("strTransactionJSON = \(strTransactionJSON)")
            self.strTransactionJSON = strTransactionJSON
        }
        
        self.TransactionsGetClientToken(param: self.strTransactionJSON)
    }
    
    
    
    @IBAction func OnClickBack(_ sender: UIButton) {
        //self.navigationController?.popViewController(animated: true)
        let VC = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func OnClickCreateTransaction(_ sender: UIButtonX) {
        print("Create Transaction.")
        CreateJSONTransactionClientTokens()
    }

}

