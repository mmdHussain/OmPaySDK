//
//  CardDetailsVC.swift
//  OMPayPaymentApp
//
//  Created by mac on 13/07/23.
//

import UIKit
import SkyFloatingLabelTextField

struct CardDetails : Codable {
    let number: String?
    let expire_month: String?
    let expire_year: String?
    let cvv2: String?
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case expire_month = "expire_month"
        case expire_year = "expire_year"
        case cvv2 = "cvv2"
    }
   
}
struct Configuration : Codable {
    let operationName: String?
    let source: String?
    let sessionId: String?
    
    enum CodingKeys: String, CodingKey {
        case operationName = "operationName"
        case source = "source"
        case sessionId = "sessionId"
    }
}


class CardDetailsVC: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var htCardForm: NSLayoutConstraint!
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var txtCardNumber: SkyFloatingLabelTextField!
    @IBOutlet weak var txtExpirationDate: SkyFloatingLabelTextField!
    @IBOutlet weak var txtCVV: SkyFloatingLabelTextField!
    @IBOutlet weak var imgCardType: UIImageView!
    
    var textFields: [SkyFloatingLabelTextField] = []
    var strAccessToken: String = ""
    var strTokenType: String = ""
    var strMonth = ""
    var strYear = ""
    var strCardNumber = ""
    
    let alamoFire:NewAlamofireHelper = NewAlamofireHelper();
    var arrCardDetails = [CardDetails]()
    var strCardJSON = ""
    var strCreditCardNonce = ""
    var strLastFour = ""
    
    var arrParamerters = [Configuration]()
    var strConfigurationJSON = ""
    var strEncodedString = ""
    var strMerchantId = ""
    var strClientAPI = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CardDetailsVC ClientToken",strAccessToken)
        textFields = [txtCardNumber,txtExpirationDate,txtCVV]
        SetupTextFieldsHeading()
        SetupTextFieldHeadingColor()
        SetupTextFieldPlaceholder()
        for textField in textFields {
            textField.delegate = self
        }
        GetEncodedString()
    }
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
 
        if textField == txtCardNumber {
                let userEnteredString = textField.text!
                let textRange = Range(range, in: userEnteredString)!
                let card_number = userEnteredString.replacingOccurrences(of: " ", with: "")
                print("card_number:-", card_number)
                
                let updatedText = userEnteredString.replacingCharacters(in: textRange, with: string)
                let formattedText = formatCardNumber(cardNumber: updatedText)
                let characterLimit = 19 // Adjust the character limit according to your requirement
                
                let trimmedText = formattedText.replacingOccurrences(of: " ", with: "")
                
                if trimmedText.count > characterLimit {
                    return false
                }
                
                // Validate the formatted card number and determine the card type
                let cardType = validateCardType(cardNumber: self.strCardNumber) // Use self.strCardNumber here
                
                print("Card Type: \(cardType)")
                
                let cardImage = cardType.image ?? UIImage(named: "EmptyCard")
                imgCardType.image = cardImage
                
                // Set the formatted card number as the text of the text field
                textField.text = formattedText
               print("output",textField.text!)
            let a = textField.text!
               let str = a.replacingOccurrences(of: " ", with: "")
                print("outputoutput",str)
            self.strCardNumber = str
                return false
            }
       else  if textField == txtExpirationDate {
             guard let currentText = textField.text,
                   let textRange = Range(range, in: currentText) else {
                 return true
             }
             let updatedText = currentText.replacingCharacters(in: textRange, with: string)
             
             if updatedText.count > 5 {
                 return false
             }
             
             let newExpiryDate = updatedText.formattedExpiryDate()
             textField.text = newExpiryDate
             print("newExpiryDate \(newExpiryDate)")
             self.GetYearMonth(expiry_date: newExpiryDate)
             return false
         }else if textField == txtCVV {
             let MAX_LENGTH = 3
             let newLength: Int = textField.text!.count + string.count - range.length
             return (newLength <= MAX_LENGTH)
         }
       return true
     }
  
    @IBAction func OnClickAutofill(_ sender: UIButtonX) {
        let temp_card_num = "4005520201264821"
        let cardNum = formatCardNumber(cardNumber: temp_card_num)
        print("cardNum: \(cardNum)")
        let expiry_date = "12/24"
        let cvv = "123"
        
//        self.txtCardNumber.text! = cardNum
//        self.txtExpirationDate.text! = expiry_date
//        self.txtCVV.text! = cvv
    }
    
    @IBAction func OnClickBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func OnClickPurchase(_ sender: UIButtonX) {
        print("Purchase..")
        guard !txtCardNumber.text!.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.view.makeToast("Please enter card number")
            return
        }
        guard !txtExpirationDate.text!.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.view.makeToast("Please enter expiry date")
            return
        }
        guard !txtCVV.text!.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.view.makeToast("Please enter CVV")
            return
        }
        

        let dicObject = CardDetails(number: (self.strCardNumber), expire_month: self.strMonth, expire_year: self.strYear, cvv2: (self.txtCVV.text!))
        self.arrCardDetails.append(dicObject)
        
        CreateJSON()
        
        
   }

}
extension CardDetailsVC {
    func GetYearMonth(expiry_date: String) {
        let formattedDate = expiry_date //"08/23"
        let components = formattedDate.split(separator: "/")

        if components.count == 2 {
            let month = String(components[0]) // "08"
            let year = String(components[1])  // "23"
            print("Month: \(month)")
            print("Year: \(year)")
          
            let strCurrentYear = CurrentYear().getCurrentYear()
           
            let lastTwoDigits = strCurrentYear / 100
           
            strYear  = String(lastTwoDigits) + year
            print("strYear: \(strYear)")
            strMonth = month
        } else {
            print("Invalid formatted date.")
        }
    }
    
    //MARK: ----Set heading-----
    func SetupTextFieldsHeading() {
        txtCardNumber.selectedTitle = "Card Number"
        txtExpirationDate.selectedTitle = "Expiration Date"
        txtCVV.selectedTitle = "CVV"
    }
    
    //MARK: -----Set heading colour-----
    func SetupTextFieldHeadingColor() {
        txtCardNumber.selectedTitleColor = .gray
        txtExpirationDate.selectedTitleColor = .gray
        txtCVV.selectedTitleColor = .gray
    }
    //MARK: -----Set textfield Placeholder----
    func SetupTextFieldPlaceholder()  {
        txtCardNumber.placeholder = "Card Number"
        txtExpirationDate.placeholder = "Expiration Date"
        txtCVV.placeholder = "CVV"
    }
    
}
extension StringProtocol {
    func separateExpiry(every stride: Int = 4, from start: Int = 0, with separator: Character = "/") -> String {
        .init(enumerated().flatMap { $0 != 0 && ($0 == start || $0 % stride == start) ? [separator, $1] : [$1]})
    }
}
extension CardDetailsVC {
    
    func CreateJSON() {
       
        var card_num = ""
        var exmonth = ""
        var exYear = ""
        var cvv = ""
        var dicMain: CardDetails?
        
        for object in self.arrCardDetails {
            card_num = object.number!
            exmonth = object.expire_month!
            exYear = object.expire_year!
            cvv = object.cvv2!
            let dic = CardDetails(number: card_num, expire_month: exmonth, expire_year: exYear, cvv2: cvv)
            dicMain = dic
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        if let jsonData = try? encoder.encode(dicMain),
            let strJSON = String(data: jsonData, encoding: .utf8) {
            print("strJSON = \(strJSON)")
            self.strCardJSON = strJSON
        }
       // self.CreditCardNonceService(card_number: self.strCardNumber, expire_month: self.strMonth, expire_year: self.strYear, cvv: self.txtCVV.text!)
        self.CreditCardNonceService(card_number: self.strCardNumber, expire_month: self.strMonth, expire_year: self.strYear, cvv: self.txtCVV.text!, ClientAPIURL: self.strClientAPI, merchantID: self.strMerchantId)
    }
}

extension CardDetailsVC {
    func MakeConfigurationRequestParams() {
        let dicData = Configuration(operationName: API_NAME.ClientConfiguration, source: API_NAME.Client, sessionId:strEncodedString)
        self.arrParamerters.append(dicData)
        print("arrParameters",self.arrParamerters)
        self.CreateJSONConfiguration()
    }
    
    func showCustomToast(message: String) {
            let toastView = ToastView()
            toastView.showToast(message: message)
    }
    func GetEncodedString()  {
        let strInputString = "\(CLIENT_CREDENTIALS.CLIENT_ID):\(CLIENT_CREDENTIALS.CLIENT_SECRET)"
        print("strInputString:", strInputString)
        if let encodedString = BASE64_CONVERSION().base64EncodeString(strInputString) {
            print("encoded string: \(encodedString)")
            strEncodedString = encodedString
        } else {
            self.showCustomToast(message: "Failed to encode the string...")
            print("Failed to encode the string...")
        }
        MakeConfigurationRequestParams()
    }
     
    func CreateJSONConfiguration() {
        var operationName = ""
        var source = ""
        var sessionId = ""
        
        var dicMainData: Configuration?
        
        for i in self.arrParamerters {
            operationName = i.operationName!
            source = i.source!
            sessionId = i.sessionId!
            let dicData = Configuration(operationName: operationName, source: source, sessionId: sessionId)
            dicMainData = dicData
        }
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        if let jsonData = try? encoder.encode(dicMainData),
            let strJSON = String(data: jsonData, encoding: .utf8) {
            print("strJSON = \(strJSON)")
            self.strConfigurationJSON = strJSON
        }
        
        
        self.ConfigurationService(param: strConfigurationJSON, strAccessToken: self.strAccessToken)
    }
}
