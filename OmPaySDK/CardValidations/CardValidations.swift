//
//  CardValidations.swift
//  OMPayPaymentApp
//
//  Created by mac on 14/07/23.
//

import Foundation
import UIKit

enum CardType {
    case visa
    case mastercard
    case amex
    case discover
    case jcb
    case dinersClub
    case other
    
    var image: UIImage? {
        switch self {
        case .visa:
            return UIImage(named: "VISA")
        case .mastercard:
            return UIImage(named: "MASTERCARD")
        case .amex:
            return UIImage(named: "AMERICAN EXPRESS")
        case .discover:
            return UIImage(named: "DISCOVER")
        case .jcb: 
            return UIImage(named: "JCB")
        case .dinersClub:
            return UIImage(named: "DINERS CLUB")
        case .other:
            return nil
        }
    }
}


func validateCardType(cardNumber: String) -> CardType {
    let visaRegex = "^4[0-9]{0,15}$"
    let mastercardRegex = "^(5[1-5][0-9]{0,16}|2[2-7][0-9]{0,16})$"
    let amexRegex = "^3[47][0-9]{0,13}$"
    let discoverRegex = "^6(?:011|5[0-9]{0,14})$"
    let jcbRegex = "^(?:2131|1800|35[0-9]{3})[0-9]{11}$"
    let dinersClubRegex = "^(?:3(?:0[0-5]|[68][0-9])[0-9]{11})$"

    let trimmedCardNumber = cardNumber.replacingOccurrences(of: " ", with: "")
    
    if NSPredicate(format: "SELF MATCHES %@", visaRegex).evaluate(with: trimmedCardNumber) {
        return .visa
    } else if NSPredicate(format: "SELF MATCHES %@", mastercardRegex).evaluate(with: trimmedCardNumber) {
        return .mastercard
    } else if NSPredicate(format: "SELF MATCHES %@", amexRegex).evaluate(with: trimmedCardNumber) {
        return .amex
    } else if NSPredicate(format: "SELF MATCHES %@", discoverRegex).evaluate(with: trimmedCardNumber) {
        return .discover
    } else if NSPredicate(format: "SELF MATCHES %@", jcbRegex).evaluate(with: trimmedCardNumber) {
        return .jcb
    } else if NSPredicate(format: "SELF MATCHES %@", dinersClubRegex).evaluate(with: trimmedCardNumber) {
        return .dinersClub
    } else {
        return .other
    }
}


/*func formatCardNumber(cardNumber: String) -> String {
    let trimmedString = cardNumber.replacingOccurrences(of: " ", with: "")
    var formattedString = ""
    var index = trimmedString.startIndex
    
    while index < trimmedString.endIndex {
        let nextIndex = trimmedString.index(index, offsetBy: min(4, trimmedString.distance(from: index, to: trimmedString.endIndex)))
        let substring = trimmedString[index..<nextIndex]
        formattedString += substring + " "
        index = nextIndex
    }
    
    return formattedString.trimmingCharacters(in: .whitespacesAndNewlines)
}*/
func formatCardNumber(cardNumber: String) -> String {
    let trimmedString = cardNumber.replacingOccurrences(of: " ", with: "")
    var formattedString = ""
    var index = trimmedString.startIndex
    
    while index < trimmedString.endIndex {
        let nextIndex = trimmedString.index(index, offsetBy: min(4, trimmedString.distance(from: index, to: trimmedString.endIndex)))
        let substring = trimmedString[index..<nextIndex]
        formattedString += substring + " "
        index = nextIndex
    }
    
    // Remove the last space before returning
    if formattedString.last == " " {
        formattedString.removeLast()
    }
    
    return formattedString
}



func isCardExpired(expiryDate: String) -> Bool {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/yy"
    
    // Get the current date
    let currentDate = Date()
    
    // Convert the expiry date string to a Date object
    if let expiryDate = formatter.date(from: expiryDate) {
        // Check if the expiry date is before the current date
        if expiryDate < currentDate {
            // Card is expired
            print("Card is expired")
            return true
        } else {
            // Card is not expired
            print("Card is not expired")
            return false
        }
    } else {
        // Invalid date format or date cannot be converted
        return true // Consider it expired to be safe
    }
}




