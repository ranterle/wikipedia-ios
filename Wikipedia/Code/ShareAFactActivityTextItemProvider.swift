import UIKit

class ShareAFactActivityTextItemProvider: UIActivityItemProvider {
    let text: String
    let articleTitle: String
    let articleURL: URL
    
    required init(text: String, articleTitle: String, articleURL: URL) {
        self.text = text
        self.articleTitle = articleTitle
        self.articleURL = articleURL
        super.init(placeholderItem: defaultRepresentation)
    }
    
    override var item: Any {
        let type = activityType ?? .message
        switch type {
        case .message:
            return messageRepresentation
        case .postToFacebook:
            return socialRepresentation
        case .postToTwitter:
            return socialMentionRepresentation
        case .mail:
            return emailRepresentation
        default:
             return defaultRepresentation
        }
    }
    
    override func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivityType?) -> String {
        return articleTitle
    }
    
    var emailRepresentation: String {
        let format = WMFLocalizedString("share-email-format", value: "“%1$@”\n\nfrom “%2$@”\n\n%3$@", comment: "Share string format for email. %1$@ is replaced with the selected text, %2$@ is replaced with the article title, %3$@ is replaced with the articleURL.")
        return String.localizedStringWithFormat(format, text, articleTitle, articleURL.absoluteString)
    }
    
    var defaultRepresentation: String {
        let format = WMFLocalizedString("share-default-format", value: "“%1$@” from “%2$@”: %3$@", comment: "Default share format string. %1$@ is replaced with the selected text, %2$@ is replaced with the article title, %3$@ is replaced with the articleURL.")
        return String.localizedStringWithFormat(format, text, articleTitle, articleURL.absoluteString)
    }
    
    var messageRepresentation: String {
        let format = WMFLocalizedString("share-message-format", value: "“%1$@” %2$@", comment: "Share string format for messages. %1$@ is replaced with the article title, %2$@ is replaced with the article URL.")
        return String.localizedStringWithFormat(format, articleTitle, articleURL.absoluteString)
    }
    
    var socialRepresentation: String {
        let format = WMFLocalizedString("share-social-format", value: "“%1$@” via Wikipedia: %2$@", comment: "Share string format for social platforms. %1$@ is replaced with the article title, %2$@ is replaced with the article URL.")
        return String.localizedStringWithFormat(format, articleTitle, articleURL.absoluteString)
    }

    var socialMentionRepresentation: String {
        let format = WMFLocalizedString("share-social-mention-format", value: "“%1$@” via @Wikipedia: %2$@", comment: "Share string format for social platforms with an @mention. %1$@ is replaced with the article title, %2$@ is replaced with the article URL.")
        return String.localizedStringWithFormat(format, articleTitle, articleURL.absoluteString)
    }
}