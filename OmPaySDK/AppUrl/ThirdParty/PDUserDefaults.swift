//
//  PDUserDefaults.swift




import UIKit

class PDUserDefaults: NSObject {
    
    
    static var ClientToken = DefaultsKey<String>("ClientToken")
    static var ClientTokens = DefaultsKey<String>("ClientTokens")
    static var StatusCode = DefaultsKey<String>("StatusCode")
   
}
