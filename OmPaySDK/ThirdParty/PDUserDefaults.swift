//
//  PDUserDefaults.swift




import UIKit

class PDUserDefaults: NSObject {
    
    
    static var FCMToken = DefaultsKey<String>("FCMToken")
    static var deviceToken = DefaultsKey<String>("deviceToken")
    static var ProfileData = DefaultsKey<[String:String]?>("ProfileData")
    static var Gender = DefaultsKey<String?>("Gender")
    static var Phone = DefaultsKey<String>("Phone")
    static var country_id = DefaultsKey<String?>("country_id")
    static var city_id = DefaultsKey<String?>("city_id")
    
    
    static var userName = DefaultsKey<String>("userName")
    static var userEmail = DefaultsKey<String>("userEmail")
    static var UserID = DefaultsKey<String>("UserID")
    static var vipCharges = DefaultsKey<String>("vipCharges")
    static var CartTotal = DefaultsKey<String>("CartTotal")
    static var CartTotalAmt = DefaultsKey<String>("CartTotalAmt")
    static var BarID = DefaultsKey<String>("BarID")
    static var barID = DefaultsKey<Int>("barID")
    static var EventID = DefaultsKey<String>("EventID")
    static var EventName = DefaultsKey<String>("EventName")
    static var GroupName = DefaultsKey<String>("GroupName")
    static var ID = DefaultsKey<String>("ID")
    static var UserLastName = DefaultsKey<String>("UserLastName")
    static var DateOfBirth = DefaultsKey<String>("DateOfBirth")
    static var Promocode = DefaultsKey<String>("Promocode")
    static var UserLat = DefaultsKey<String>("UserLat")
    static var UserLng = DefaultsKey<String>("UserLng")
    static var Facebbok = DefaultsKey<String>("Facebbok")
    static var Twitter = DefaultsKey<String>("Twitter")
    static var Insta = DefaultsKey<String>("Insta")
    static var isLogin = DefaultsKey<Bool>("isLogin")
    static var currencyId = DefaultsKey<Int>("currencyId")
    static var currencySymbol = DefaultsKey<String>("currencySymbol")
    static var ImageArray = DefaultsKey<Array<Any>?>("imgArray")
    static var UserDict = DefaultsKey<NSDictionary?>("UserDict")
    static var UserImage = DefaultsKey<String>("UserImage")
    static var AccessToken = DefaultsKey<String>("AccessToken")
    static var nameImg = DefaultsKey<Data>("nameImg")
    static var addressImg = DefaultsKey<Data>("addressImg")
    static var selfieImg = DefaultsKey<Data>("selfieImg")
    static var DrinkQueCount = DefaultsKey<Int>("DrinkQueCount")
    
    static var profileImg = DefaultsKey<String>("profileImg")
    static var registerStatus = DefaultsKey<String>("registerStatus")
    static var loginStatus = DefaultsKey<String>("loginStatus")
    static var loginId = DefaultsKey<String>("loginId")
    static var loginUserName = DefaultsKey<String>("loginUserName")
    static var loginEmail = DefaultsKey<String>("loginEmail")
    static var RegisDate = DefaultsKey<String>("RegisDate")
    static var forgetStatus = DefaultsKey<String>("forgetStatus")
    static var forgetOtp = DefaultsKey<String>("forgetOtp")
    static var ModeType = DefaultsKey<String>("ModeType")
    static var UserType = DefaultsKey<String>("UserType")
    static var BarType = DefaultsKey<String>("BarType")
    static var address = DefaultsKey<String>("address")
    static var city = DefaultsKey<String>("city")
    static var state = DefaultsKey<String>("state")
    static var zip_code = DefaultsKey<String>("zip_code")
    static var state_name = DefaultsKey<String>("state_name")
    static var state_id = DefaultsKey<String?>("state_id")
    static var country = DefaultsKey<String>("country")
    static var standard_charge = DefaultsKey<String>("standard_charge")
    static var vip_charge = DefaultsKey<String>("vip_charge")
    static var PaytillNow = DefaultsKey<String>("UserID")
    static var pay_at_till = DefaultsKey<String>("pay_at_till")
    static var AcHolderName = DefaultsKey<String>("AcHolderName")
    static var AcSortCode = DefaultsKey<String>("AcSortCode")
    static var AcNumber = DefaultsKey<String>("AcNumber")
    static var AcSwift = DefaultsKey<String>("AcSwift")
    static var Payapl = DefaultsKey<String>("Payapl")
    
    static var loginType = DefaultsKey<String>("loginType")
}
