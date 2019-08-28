import UIKit

/* I love apply, also style in kotlin,
   make code very well organized and nice looking */

protocol KotlinStyle {}

extension KotlinStyle where Self: Any {

    func with(_ closure: (inout Self) -> Void) -> Self {
        var copy = self
        closure(&copy)
        return copy
    }

    func `do`(_ closure: (Self) -> Void) {
        closure(self)
    }
}

extension KotlinStyle where Self: AnyObject {

    func apply(_ closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }

    func also(_ closure: (Self) -> Void) {
        closure(self)
    }
}

extension NSObject: KotlinStyle { }
extension CGPoint: KotlinStyle { }
extension CGRect: KotlinStyle { }
extension CGSize: KotlinStyle { }

#if os(iOS) || os(tvOS)
extension UIEdgeInsets: KotlinStyle {}
#endif
