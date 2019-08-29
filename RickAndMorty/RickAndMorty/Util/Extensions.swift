import UIKit

extension NSAttributedString {
    public static func join(values: [NSAttributedString], seperator: NSAttributedString) -> NSAttributedString? {
        if values.isEmpty {
            return nil
        }
        if values.count == 1 {
            return values.first
        }
        let retVal = NSMutableAttributedString()
        for index in 0..<values.count - 1 {
            retVal.append(values[index])
            retVal.append(seperator)
        }
        retVal.append(values.last!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        retVal.addAttribute(NSAttributedString.Key.paragraphStyle,
                            value: paragraphStyle,
                            range: NSRange(location: 0, length: retVal.length))
        return retVal
    }
}
