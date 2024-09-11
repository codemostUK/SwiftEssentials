//
//  FormValidator.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.03.2023.
//

import UIKit

/// A utility structure for validating form inputs based on a set of predefined rules.
struct FormValidator {

    /// Enumeration of validation rules for various types of input fields.
    enum Rule {
        case email
        case nonWhitespace(length: Int)
        case password
        case nickname
        case profileBioLink
        case equal(to: String)
        case tckn
        case date

        /// The regular expression pattern for the validation rule, if applicable.
        var regexValue: String? {
            switch self {
                case .email:
                    return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"

                case .nonWhitespace(let length):
                    return String(format: ".{%d,}$", length)

                case .password:
                    return """
                    (?=(.*[0-9]))(?=.*[\\!@#$%^&*()\\[\\]{}\\-_+=~`|:;"'<>,./?])(?=.*[a-zçğıöşü])(?=(.*[A-ZÇĞİÖŞÜ]))(?=(.*)).{8,}
                    """

                case .nickname:
                    return """
                    ^(?=.*[a-zA-ZığüşöçĞÜŞÖÇıİ])([a-zA-ZığüşöçĞÜŞÖÇıİ0-9._]{4,15})$
                    """

                case .profileBioLink:
                    return #"""
                    ^(?:https?:\/\/)?(?:www.)?(?:facebook.com|x.com|instagram.com|twitter.com)\/\S+
                    """#

                case .tckn:
                    return """
                    ^[1-9]{1}[0-9]{9}[02468]{1}$
                    """

                default:
                    return nil
            }
        }

        /// The error message associated with a failed validation for the rule.
        var errorString: String {
            switch self {
                case .email:
                    return NSLocalizedString("Geçerli bir e-posta girin", comment: "Uyelik formu hata mesaji")

                case .nonWhitespace(let length):
                    return NSLocalizedString(String(format: "Bu alan %d veya daha fazla karakter olmalıdır.", length), comment: "Uyelik formu hata mesaji")

                case .password:
                    return NSLocalizedString("Şifre 1 küçük harf, 1 büyük harf, 1 rakam, 1 özel karakter içermeli ve en az 8 karakter uzunluğunda olmalıdır.", comment: "Uyelik formu hata mesaji")

                case .nickname:
                    return NSLocalizedString("Kullanıcı adı 4 ile 15 karakter arası olmalı ve sadece harf, rakam, alttan çizgi (_) ve noktadan (.) oluşmalıdır.", comment: "Uyelik formu hata mesaji")

                case .profileBioLink:
                    return NSLocalizedString("Girdiğiniz bağlantı sadece X.com, Facebook veya Instagram linki olabilir!", comment: "Uyelik formu hata mesaji")

                case .equal:
                    return NSLocalizedString("Tekrar edilen alan diğeriyle aynı olmalı", comment: "Uyelik formu hata mesaji")

                case .tckn:
                    return NSLocalizedString("Geçerli bir T.C. kimlik no girin", comment: "Uyelik formu hata mesaji")

                case .date:
                    return NSLocalizedString("Geçerli bir tarih girin", comment: "Uyelik formu hata mesaji")
            }
        }
    }

    /// Validates a string against a regular expression.
    /// - Parameters:
    ///   - text: The string to validate.
    ///   - regex: The regular expression to validate against.
    /// - Returns: `true` if the string matches the regular expression, `false` otherwise.
    private static func validateRegex(_ text: String, regex: String?) -> Bool {
        guard let regex, let _ = text.range(of: regex, options: .regularExpression) else {
            return false
        }
        return true
    }

    /// Validates a string based on a specific rule.
    /// - Parameters:
    ///   - text: The string to validate.
    ///   - rule: The rule to validate against.
    /// - Returns: `true` if the string passes validation, `false` otherwise.
    static func validateRule(_ text: String, rule: Rule) -> Bool {
        switch rule {
            case .email, .password, .nickname, .profileBioLink, .tckn:
                return validateRegex(text, regex: rule.regexValue)

            case .nonWhitespace:
                return validateRegex(text.filter { !$0.isWhitespace }, regex: rule.regexValue)

            case .equal(let toString):
                return text == toString

            case .date:
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"
                return dateFormatter.date(from: text) != nil
        }
    }
}
