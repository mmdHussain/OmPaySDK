//
//  AlamofireHelper.swift
//  Ziofly
//
//  Created by Apple on 19/05/21.
//

import UIKit
import Foundation
import Alamofire
import Toast_Swift
import UIKit


//typealias voidRequestCompletionBlock = (_ response:[String:Any],_ data:Data?,_ error:Any?) -> (Void)
typealias voidRequestCompletionBlock = (_ response:NSDictionary,_ data:Data?,_ error:Any?) -> (Void)
typealias voidRequestCompletionBlock_CreditNonce = (NSDictionary, Data?, Error?) -> Void


struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}

class AlamofireHelper: NSObject  {
    static let POST_METHOD = "POST"
    static let GET_METHOD = "GET"
    static let PUT_METHOD = "PUT"
    var dataBlock:voidRequestCompletionBlock={_,_,_ in};
    var dataBlock_CreditNonce:voidRequestCompletionBlock_CreditNonce={_,_,_ in};
    
    override init() {
        super.init()
    }
    func showCustomToast(message: String) {
            let toastView = ToastView()
            toastView.showToast(message: message)
    }
   
//MARK: ---Get Client Token Response---
    func getClientTokenResponse(url: String, methodName: String, paramData: String?, block: @escaping voidRequestCompletionBlock) {
        self.dataBlock = block
        let strInputString = "\(CLIENT_CREDENTIALS.CLIENT_ID):\(CLIENT_CREDENTIALS.CLIENT_SECRET)"
        print("strInputString:", strInputString)
        var strEncodedString: String = ""
        if let encodedString = BASE64_CONVERSION().base64EncodeString(strInputString) {
            print("encoded string: \(encodedString)")
            strEncodedString = encodedString
        } else {
            showCustomToast(message: "Failed to encode the string...")
            print("Failed to encode the string...")
        }

        let headers: [String: String] = [
            SDK_HEADERS.ContentType: SDK_HEADERS_VALUES.ContentTypeValue,
            SDK_HEADERS.Authorization: "\(SDK_HEADERS_VALUES.BasicAuthorizationValue) \(strEncodedString)"
        ]
        print("Headers:- \(headers)")
        print("URL of \(url): \(url) \n Parameters \(String(describing: paramData))")
        if methodName == AlamofireHelper.POST_METHOD {
            print("Post method...")
            guard let postData = paramData?.data(using: .utf8) else {
                print("Invalid paramData for POST method.")
                return
            }

            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = AlamofireHelper.POST_METHOD
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
            request.httpBody = postData

            AF.request(request).responseJSON { response in
                switch response.result {
                case .success(_):
                    if let value = response.value as? [String: Any] {
                        self.dataBlock(value as NSDictionary, response.data, nil)
                    }
                    break

                case .failure(_):
                    if let error = response.error {
                        let dictResponse: [String: Any] = [:]
                        self.dataBlock(dictResponse as NSDictionary, response.data, error)
                    }
                    break
                }
            }
        }
    }
    
    
//MARK: ---GetCreditCardNonce Response---
    func getCreditNonceResponse(url: String, methodName: String, client_token: String ,paramData: String?, block: @escaping voidRequestCompletionBlock_CreditNonce) {
        self.dataBlock_CreditNonce = block
        let headers: [String: String] = [
            SDK_HEADERS.ContentType: SDK_HEADERS_VALUES.ContentTypeValue,
            SDK_HEADERS.Authorization: "\(SDK_HEADERS_VALUES.BearerAuthorizationValue)  \(client_token)"
        ]
        print("Headers of CreditcardNonce:- \(headers)")
        print("URL of \(url): \(url) \n Parameters \(String(describing: paramData))")
        
        if methodName == AlamofireHelper.POST_METHOD {
            print("Post method...")
            guard let postData = paramData?.data(using: .utf8) else {
                print("Invalid paramData for POST method.")
                return
            }
 
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = HTTPMethod.post.rawValue
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
            request.httpBody = postData
           
            AF.request(request).responseJSON { response in
                print("response:-",response)
                switch response.result {
                case .success(_):
                    if let value = response.value as? [String: Any] {
                        self.dataBlock_CreditNonce(value as NSDictionary  ,response.data,nil)
                    }
                case .failure(_):
                    if let error = response.error {
                        let dictResponse: [String: Any] = [:]
                        self.dataBlock_CreditNonce(dictResponse as NSDictionary ,response.data,nil)
                    }
                }
            }
        }
    }
    
    
    func TransactionsGetClientToken(url: String, methodName: String, paramData: String?, block: @escaping voidRequestCompletionBlock) {
        self.dataBlock = block
        let strInputString = "\(CLIENT_CREDENTIALS.CLIENT_ID):\(CLIENT_CREDENTIALS.CLIENT_SECRET)"
        print("strInputString:", strInputString)
        var strEncodedString: String = ""
        if let encodedString = BASE64_CONVERSION().base64EncodeString(strInputString) {
            print("encoded string: \(encodedString)")
            strEncodedString = encodedString
        } else {
            showCustomToast(message: "Failed to encode the string...")
            print("Failed to encode the string...")
        }

        let headers: [String: String] = [
            SDK_HEADERS.ContentType: SDK_HEADERS_VALUES.ContentTypeValue,
            SDK_HEADERS.Authorization: "\(SDK_HEADERS_VALUES.BasicAuthorizationValue) \(strEncodedString)"
        ]
        print("Headers:- \(headers)")
        print("URL of \(url): \(url) \n Parameters \(String(describing: paramData))")
        if methodName == AlamofireHelper.POST_METHOD {
            print("Post method...")
            guard let postData = paramData?.data(using: .utf8) else {
                print("Invalid paramData for POST method.")
                return
            }

            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = AlamofireHelper.POST_METHOD
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
            request.httpBody = postData
            
            AF.request(request).responseJSON { response in
                // Get the status code from the response
                        if let httpURLResponse = response.response {
                            let statusCode = httpURLResponse.statusCode
                            print("Status Code: \(statusCode)")
                            
                            if statusCode == 404 {
                               // self.viewFailureResponse.isHidden = false
                               // self.viewMain.isHidden = true
                                Defaults[PDUserDefaults.StatusCode] = "\(statusCode)"
                            }
                            // You can handle the status code here as needed
                        }
                switch response.result {
                case .success(_):
                    if let value = response.value as? [String: Any] {
                        self.dataBlock(value as NSDictionary, response.data, nil)
                    }
                    break

                case .failure(_):
                    if let error = response.error {
                        let dictResponse: [String: Any] = [:]
                        print("dictResponse=\(dictResponse)")
                        self.dataBlock(dictResponse as NSDictionary, response.data, error)
                    }
                    break
                }
            }
            
        }
    }

/*
 import Alamofire

 func getCreditNonceResponse(url: String, methodName: String, client_token: String, paramData: String?, block: @escaping voidRequestCompletionBlock_CreditNonce) {
     // ... Your existing code ...

     if methodName == AlamofireHelper.POST_METHOD {
         // ... Your existing code ...

         // Make the API request using Alamofire
         AF.request(url, method: .post, parameters: paramData, encoding: JSONEncoding.default, headers: [SDK_HEADERS.ContentType: SDK_HEADERS_VALUES.ContentTypeValue, SDK_HEADERS.Authorization: "\(SDK_HEADERS_VALUES.BearerAuthorizationValue)  \(client_token)"])
             .responseJSON { response in
                 switch response.result {
                 case .success(let jsonData):
                     if let jsonDict = jsonData as? [String: Any] {
                         // Access the JSON data directly as a dictionary
                         // Handle the response accordingly, calling the completion block with the data
                         self.dataBlock_CreditNonce(jsonDict as NSDictionary, response.data, nil)
                     } else if let jsonArray = jsonData as? [[String: Any]] {
                         // Access the JSON data as an array of dictionaries
                         // Handle the response accordingly, calling the completion block with the data
                         self.dataBlock_CreditNonce(jsonArray as NSArray, response.data, nil)
                     }
                 case .failure(let error):
                     let dictResponse: [String: Any] = [:]
                     self.dataBlock_CreditNonce(dictResponse as NSDictionary, response.data, error)
                 }
             }
     }
 }

 */


    
   /*func getResponseFromURL(url : String,methodName : String,paramData : [String:Any]? , block:@escaping voidRequestCompletionBlock) {
        
        self.dataBlock = block
        let strInputString = "\(CLIENT_CREDENTIALS.CLIENT_ID) : \(CLIENT_CREDENTIALS.CLIENT_SECRET)"
        print("strInputString:",strInputString)
        var strEncodedString: String = ""
        if let encodedString = BASE64_CONVERSION().base64EncodeString(strInputString) {
            print("encoded string: \(encodedString)")
            strEncodedString = encodedString
        }else{
            showCustomToast(message: "Failed to encode the string...")
            print("Failed to encode the string...")
        }
            
        let headers = [SDK_HEADERS.ContentType: SDK_HEADERS_VALUES.ContentTypeValue ,
                       SDK_HEADERS.Authorization: "\(SDK_HEADERS_VALUES.AuthorizationValue) \(strEncodedString)" ]
        print("Headers:- \(headers)")
       
        print("URL of \(url): \(url) \n Parameters \(String(describing: paramData))")
        if (methodName == AlamofireHelper.POST_METHOD)  {
            print("Post method...")
            AF.request(url, method: .post, parameters: paramData, encoding:JSONEncoding.default, headers: HTTPHeaders.init(headers)).responseJSON {
                response in
                    switch(response.result)
                    {
                        
                    case .success(_):
                        if response.value != nil  {
                            self.dataBlock((response.value as? [String:Any])! as NSDictionary,response.data,nil)
                        
                        }
                        break
                        
                    case .failure(_):
                        if response.error != nil
                        {
                            let dictResponse:[String:Any] = [:]
                            self.dataBlock(dictResponse as NSDictionary as NSDictionary,response.data,response.error!)
                        }
                        break
                    }
                }

            }
      }*/
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   /* func getResponseFromPDFURL(url : String,methodName : String,paramData : [String:Any]? , block:@escaping voidRequestCompletionBlock)
    {
        
        self.dataBlock = block
        let urlString:String = "AppUrl.Pdf_Url + url"
        
        print("URL : \(urlString) \n Parameters \(String(describing: paramData))")
       
        if (methodName == AlamofireHelper.POST_METHOD)
        {
            AF.request(urlString, method: .post, parameters: paramData, encoding:JSONEncoding.default, headers: nil).responseJSON
            {
                response in
                    switch(response.result)
                    {
                        
                    case .success(_):
                        if response.value != nil
                        {
                            self.dataBlock((response.value as? [String:Any])! as NSDictionary,response.data,nil)
                         }
                        break
                        
                    case .failure(_):
                        if response.error != nil
                        {
                            let dictResponse:[String:Any] = [:]
                            self.dataBlock(dictResponse as NSDictionary,response.data,response.error!)
                        }
                        break
                    }
                }
        }
        else if(methodName == AlamofireHelper.GET_METHOD)
        {
            AF.request(urlString, method: .get,encoding:JSONEncoding.default, headers: nil).responseJSON
                {  response in
                switch(response.result)
                    {
                        
                    case .success(_):
                        if response.value != nil
                        {
                            self.dataBlock((response.value as? [String:Any])! as NSDictionary,response.data,nil)
                        }
                        break
                        
                    case .failure(_):
                        if response.error != nil
                        {
                            let dictResponse:[String:Any] = [:]
                            self.dataBlock(dictResponse as NSDictionary,response.data,response.error!)
                        }
                        break
                    }
            }

        }
            }*/
        /*func getResponseFromURL(url : String,methodName : String,paramData : [String:Any]?,image : UIImage, block:@escaping voidRequestCompletionBlock)
        {
            if (methodName == AlamofireHelper.POST_METHOD)
            {
            self.dataBlock = block
            let urlString = AppUrl.mainDomain + url
                print("urlString",urlString)
            let api_url = urlString
                guard let url = URL(string: api_url) else {
                    return
                }

            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
             urlRequest.httpMethod = "POST"
             urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
           
            AF.upload(multipartFormData: { multipartFormData in
                autoreleasepool {
                    image.compressImageBelow(kb: 1500.0, completion: { (compressedImage, imageData) in
                        guard let imgData = imageData else {
                          return
                        }
                       multipartFormData.append(imgData, withName: "\(PARAMS.Image)", fileName: "image.jpg", mimeType: "image/jpeg")
                    })
                    
                  }
                for (key, value) in paramData!
                {
                    if let stringValue = value as? String {
                        if let data = stringValue.data(using: .utf8) {
                            multipartFormData.append(data, withName: key)
                        }
                    } else {
                        // Handle the case when the value is not a String
                        // For example, you can convert the value to a String using String interpolation or another appropriate method.
                    }
//                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                }
                
            
                
                
                
            }, with: urlRequest)
                .uploadProgress(queue: .main, closure: { progress in
                    //Current upload progress of file
                    //print("Upload Progress: \(progress.fractionCompleted)")
                })
                .responseJSON(completionHandler: { data in

                       switch data.result {

                       case .success(_):
                        do {
                            self.dataBlock((data.value as? [String:Any])!,data.data,nil)
                            print("Success!")
                       }
                       catch {
                          // catch error.
                        print("catch error") }
                        break
                        case .failure(_):
                        print("failure")

                        break
                        
                    }
                })
        }
        }*/
    /*func getResponseFromURLCounTerImg(url : String,methodName : String,paramData : [String:Any]?,image : UIImage, block:@escaping voidRequestCompletionBlock)
    {
        if (methodName == AlamofireHelper.POST_METHOD)
        {
        
        self.dataBlock = block
        let urlString = AppUrl.mainDomain + url
        let api_url = urlString
            guard let url = URL(string: api_url) else {
                return
            }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
         urlRequest.httpMethod = "POST"
         urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
       
        AF.upload(multipartFormData: { multipartFormData in
            autoreleasepool {
                image.compressImageBelow(kb: 1500.0, completion: { (compressedImage, imageData) in
                    guard let imgData = imageData else {
                      return
                    }
                   multipartFormData.append(imgData, withName: "counter_image", fileName: "image.jpg", mimeType: "image/jpeg")
                })
               
              }
            for (key, value) in paramData!
            {
                multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
            }
            
        }, with: urlRequest)
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
              //  print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseJSON(completionHandler: { data in

                   switch data.result {
                   case .success(_):
                    do {
                        self.dataBlock((data.value as? [String:Any])! as NSDictionary,data.data,nil)
                        print("Success!")
                   }
                   catch {
                    print("catch error")
                   }
                    break
                   case .failure(_):
                    print("failure")
                    break
                }
            })
    }
    }*/
  /*  func getResponseFromURLCounTerAddImg(url : String,methodName : String,paramData : [String:Any]?,image : UIImage, block:@escaping voidRequestCompletionBlock)
    {
        if (methodName == AlamofireHelper.POST_METHOD)
        {
        
        self.dataBlock = block
        let urlString = AppUrl.mainDomain + url
        let api_url = urlString
            guard let url = URL(string: api_url) else {
                return
            }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
         urlRequest.httpMethod = "POST"
         urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
       
        AF.upload(multipartFormData: { multipartFormData in
            autoreleasepool {
                image.compressImageBelow(kb: 1500.0, completion: { (compressedImage, imageData) in
                    guard let imgData = imageData else {
                      return
                    }
                   multipartFormData.append(imgData, withName: "counter_img", fileName: "image.jpg", mimeType: "image/jpeg")
                })
               
              }
            for (key, value) in paramData!
            {
                multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
            }
            
        }, with: urlRequest)
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
              //  print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseJSON(completionHandler: { data in

                   switch data.result {
                   case .success(_):
                    do {
                        self.dataBlock((data.value as? [String:Any])! as NSDictionary,data.data,nil)
                        print("Success!")
                   }
                   catch {
                    print("catch error")
                   }
                    break
                   case .failure(_):
                    print("failure")
                    break
                }
            })
    }
    }*/

}

/*extension UIImage {
func compressImageBelow(kb: Double, completion:(UIImage?, Data?) -> Void) {
    if let imageData = self.jpegData(compressionQuality: 0.5)
    {
      var resizingImage = self
      var imageSizeKB = Double(imageData.count) / 1000.0
      var imgFinalData: Data = imageData
      while imageSizeKB > kb {
            if let resizedImage = resizingImage.resized(withPercentage: 0.9),
                let imageData = resizedImage.jpegData(compressionQuality: 0.5) {
                resizingImage = resizedImage
                imageSizeKB = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB
                imgFinalData = imageData
              //  print("There were \(imageData.count) bytes")
                let bcf = ByteCountFormatter()
                bcf.allowedUnits = [.useMB] // optional: restricts the units to MB only
                bcf.countStyle = .file
                _ = bcf.string(fromByteCount: Int64(imageData.count))
            }
        }
        completion(self, imgFinalData);
    }
    completion(nil, nil);
  }

}*/
