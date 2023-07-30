//
//  AlamofireHelper.swift
//  Ziofly
//
//  Created by Apple on 19/05/21.
//

import UIKit
import Foundation
import Alamofire


//typealias voidRequestCompletionBlock = (_ response:[String:Any],_ data:Data?,_ error:Any?) -> (Void)
typealias voidRequestCompletionBlock = (_ response:NSDictionary,_ data:Data?,_ error:Any?) -> (Void)

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}

class AlamofireHelper: NSObject
{
    static let POST_METHOD = "POST"
    static let GET_METHOD = "GET"
    static let PUT_METHOD = "PUT"
    var dataBlock:voidRequestCompletionBlock={_,_,_ in};
    
    override init() {
        super.init()
    }
    func getResponseFromURL(url : String,methodName : String,paramData : [String:Any]? , block:@escaping voidRequestCompletionBlock)
    {
        
        self.dataBlock = block
       // let urlString:String = AppUrl.mainDomain + url
        let headers = ["Api-Key" : "156c4675-9608-4591-1122-3433", "User-Id":"", "Auth-Token" : "" ]
        print("URL of \(url): \(url) \n Parameters \(String(describing: paramData))")
        if (methodName == AlamofireHelper.POST_METHOD)
        {
            
            AF.request(url, method: .post, parameters: paramData, encoding:JSONEncoding.default, headers: nil).responseJSON {
                response in
                    switch(response.result)
                    {
                        
                    case .success(_):
                        if response.value != nil
                        {
                            self.dataBlock((response.value as? [String:Any])! as NSDictionary,response.data,nil)
                          //  print("Response : \(Utility.conteverDictToJson(dict: response.result.value as! [String:Any]))")
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
        
        else if(methodName == AlamofireHelper.GET_METHOD)
        {
            AF.request(url, method: .get,encoding:JSONEncoding.default, headers: nil).responseJSON
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
    }
    func getResponseFromPDFURL(url : String,methodName : String,paramData : [String:Any]? , block:@escaping voidRequestCompletionBlock)
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
            }
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
