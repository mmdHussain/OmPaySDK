//
//  ViewController.swift
//  Ziofly
//
//  Created by Apple on 17/05/21.
//

import UIKit

/*extension UIViewController {
    
//    func parseProfileDetail(response:[String:Any])-> Bool
//    {
//        if UIViewController.isSuccess(response: response, withSuccessToast: false, andErrorToast: true)
//        {
//            let status = response["status"] as? Bool
//            if status == true
//            {
//                if let userResponse = response["data"] as? [String:Any]
//                {
//
//                }
//            }else{
//                let Message = response["message"]as? String
//
//            }
//            return true;
//        }
//        else
//        {
//            return false;
//        }
//    }
//
//
//    func parseUserProfileDetail(response:[String:Any])-> Bool
//    {
//        if UIViewController.isSuccess(response: response, withSuccessToast: false, andErrorToast: true)
//        {
//            if (response["data"] as? [String:Any]) != nil
//            {
//            }
//            return true;
//        }
//        else
//        {
//            return false;
//        }
//    }
//
   

     class func parseSignUpDetail(response:[String:Any])-> Bool
        {
            let status = response["status"] as? String
              if status == "1" {
                print("Signup response", response)
                let status = response["status"] as? Bool
    
                if status == true
                {
                  //  let token = (response["token"] as? String)!
                }
                return true;
            }
            else
            {
                return false;
            }
        }
    func parseOrderList(_ response:[String:Any],data:Data? ,toArray:NSMutableArray , completion: @escaping (_ result: Bool) -> Void)
    {
        let status = response["status"] as? String
        if status == "1" {
            let jsonDecoder = JSONDecoder()
            do{
                let product:OrderModel =  try jsonDecoder.decode(OrderModel.self, from: data!)
                toArray.removeAllObjects()
                let productlist:[OrderData] = product.data
                if productlist.count > 0
                {
                    for aircraft in productlist
                    {
                       toArray.add(aircraft)
                    }
                    completion(true)
                }
            }
            catch
            {
                completion(false)
            }
        }

    }
    func parseSearchList(_ response:[String:Any],data:Data? ,toArray:NSMutableArray ,tobarArray:NSMutableArray, completion: @escaping (_ result: Bool) -> Void)
    {
        let status = response["status"] as? String
        if status == "1" {
            let jsonDecoder = JSONDecoder()
            do{
                let product:SearchModel =  try jsonDecoder.decode(SearchModel.self, from: data!)
                toArray.removeAllObjects()
                tobarArray.removeAllObjects()
                let productlist:[Events] = (product.data?.events!)!
                let productBarlist:[Bardata] = (product.data?.bars!)!
                print(productlist, "searchproductlist")
                if productlist.count > 0
                { 
                    for aircraft in productlist
                    {
                       toArray.add(aircraft)
                    }
                    completion(true)
                }
                if productBarlist.count > 0
                {
                   
                    for aircraft in productBarlist
                    {
                       tobarArray.add(aircraft)
                    }
                    completion(true)
                }
            }
            catch
            {
                completion(false)
            }
        }

    }
    func parseHistoryOrderList(_ response:[String:Any],data:Data? ,toArray:NSMutableArray , completion: @escaping (_ result: Bool) -> Void)
    {
        let status = response["status"] as? String
        if status == "1" {
            let jsonDecoder = JSONDecoder()
            do{
                let product:OrderHModel =  try jsonDecoder.decode(OrderHModel.self, from: data!)
                toArray.removeAllObjects()
                let productlist:[OrderHData] = product.data!
                if productlist.count > 0
                {
                    for aircraft in productlist
                    {
                            toArray.add(aircraft)
                    }
                    completion(true)
                }
            }
            catch
            {
                completion(false)
            }
        }
    }
    func parseNotifiactionList(_ response:[String:Any],data:Data? ,toArray:NSMutableArray , completion: @escaping (_ result: Bool) -> Void)
    {
        let status = response["status"] as? String
        if status == "1" {
            let jsonDecoder = JSONDecoder()
            do{
                let product:NotiFicationModel =  try jsonDecoder.decode(NotiFicationModel.self, from: data!)
                toArray.removeAllObjects()
                print(product, "product")
                let Itemlist:[NotificationCategory] = product.data?.notificationCategory ?? []
                if Itemlist.count > 0
                {
                    for notifiaction in Itemlist
                    {
                        autoreleasepool {
                            toArray.add(notifiaction) }
                    }
                    completion(true)
                }
                else{
                    completion(false)
                }
            }
            catch
            {
                completion(false)
            }
        } else{
                completion(false)}

    }
    func parseEventsList(_ response:[String:Any],data:Data? ,toArray:NSMutableArray , completion: @escaping (_ result: Bool) -> Void)
    {
        let status = response["status"] as? String
        if status == "1" {
            print("status = 1")
            let jsonDecoder = JSONDecoder()
            do{
                let event:EventModel =  try jsonDecoder.decode(EventModel.self, from: data!)
                toArray.removeAllObjects()
                let Itemlist:[EventData] = event.data
                print("Itemlist=\(Itemlist)")
                if Itemlist.count > 0
                {
                    for event in Itemlist
                    {
                        autoreleasepool {
                            toArray.add(event) }
                    }
                    completion(true)
                }
                else{
                    completion(false)
                }
            }
            catch
            {
                completion(false)
            }
        } else{
                completion(false)}
    }
    func parseGuestHomeList(_ response:[String:Any],data:Data? ,toArray:NSMutableArray , completion: @escaping (_ result: Bool) -> Void)
    {
        let status = response["status"] as? String
        if status == "1" {
            let jsonDecoder = JSONDecoder()
            do{
                let event:HomeModel =  try jsonDecoder.decode(HomeModel.self, from: data!)
                toArray.removeAllObjects()
                let Itemlist:[BarDatum] = (event.data?.barData!)!
                if Itemlist.count > 0
                {
                    for event in Itemlist
                    {
                        autoreleasepool {
                            toArray.add(event) }
                    }
                    completion(true)
                }
                else{
                    completion(false)
                }
            }
            catch
            {
                completion(false)
            }
        } else{
                completion(false)}
    }
    func parseDrinksList(_ response:[String:Any],data:Data? ,toArray:NSMutableArray , completion: @escaping (_ result: Bool) -> Void)
    {
        let status = response["status"] as? String
        if status == "1" {
            let jsonDecoder = JSONDecoder()
            do{
                let event:DrinkModel =  try jsonDecoder.decode(DrinkModel.self, from: data!)
                toArray.removeAllObjects()
                let Itemlist:[DataProduct] = (event.data?.products!)!
                if Itemlist.count > 0
                {
                    for event in Itemlist
                    {
                        autoreleasepool {
                            toArray.add(event) }
                    }
                    completion(true)
                }
                else{
                    completion(false)
                }
            }
            catch
            {
                completion(false)
            }
        } else{
                completion(false)}
    }
    func parseCounterList(_ response:[String:Any],data:Data? ,toArray:NSMutableArray , completion: @escaping (_ result: Bool) -> Void)
    {
        let status = response["status"] as? String
        if status == "1" {
            let jsonDecoder = JSONDecoder()
            do{
                let Counter:CounterModel =  try jsonDecoder.decode(CounterModel.self, from: data!)
                toArray.removeAllObjects()
                let Itemlist:[CounterData] = Counter.data
                if Itemlist.count > 0
                {
                    for Counter in Itemlist
                    {
                        autoreleasepool {
                            toArray.add(Counter) }
                    }
                    completion(true)
                }
                else{
                    completion(false)
                }
            }
            catch
            {
                completion(false)
            }
        } else{
                completion(false)}
    }
    func parseBarCounterList(_ response:[String:Any],data:Data? ,toArray:NSMutableArray , completion: @escaping (_ result: Bool) -> Void)
    {
        let status = response["status"] as? String
        if status == "1" {
            let jsonDecoder = JSONDecoder()
            do{
                let Counter:BarcountersModel =  try jsonDecoder.decode(BarcountersModel.self, from: data!)
                print("Counter",Counter)
                toArray.removeAllObjects()
                let Itemlist:[Counter] = (Counter.data.counters)
                print("Itemlist",Itemlist)
                if Itemlist.count > 0
                {
                    for Counter in Itemlist
                    {
                        autoreleasepool {
                            toArray.add(Counter) }
                    }
                    completion(true)
                }
                else{
                    completion(false)
                }
            }
            catch
            {
                completion(false)
            }
        } else{
                completion(false)}
    }
    func parseBrandSizeList(_ response:[String:Any],data:Data? ,toArray:NSMutableArray , completion: @escaping (_ result: Bool) -> Void)
    {
        let status = response["status"] as? String
        if status == "1" {
            let jsonDecoder = JSONDecoder()
            do{
                let product:BrandSModel =  try jsonDecoder.decode(BrandSModel.self, from: data!)
                toArray.removeAllObjects()
                let productlist:[BrandSizedata] = product.data
                if productlist.count > 0
                {
                    for aircraft in productlist
                    {
                            toArray.add(aircraft)
                    }
                    completion(true)
                }
            }
            catch
            {
                completion(false)
            }
        } else{
                completion(false)}

    }
    func parseCategoryList(_ response:[String:Any],data:Data? ,toArray:NSMutableArray , completion: @escaping (_ result: Bool) -> Void)
    {
        let status = response["status"] as? String
        if status == "1" {
            let jsonDecoder = JSONDecoder()
            do{
                let event:CatModel =  try jsonDecoder.decode(CatModel.self, from: data!)
                toArray.removeAllObjects()
                let Itemlist:[Catdata] = event.data!
                if Itemlist.count > 0
                {
                    for event in Itemlist
                    {
                        autoreleasepool {
                            toArray.add(event) }
                    }
                    completion(true)
                }
                else{
                    completion(false)
                }
            }
            catch
            {
                completion(false)
            }
        } else{
                completion(false)}
    }
}
*/
