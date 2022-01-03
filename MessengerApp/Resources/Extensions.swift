//
//  Extensions.swift
//  MessengerApp
//
//  Created by administrator on 03/01/2022.
//

import Foundation
import UIKit


extension UIView{
    
    public var width: CGFloat{
        return self.frame.size.width
    }
    public var height: CGFloat{
        return self.frame.size.height
    }
    public var top: CGFloat{
        return self.frame.origin.y
    }
    
    public var bottom: CGFloat{
        return self.frame.size.height + self.frame.origin.y
    }
    
    public var left: CGFloat{
        return self.frame.origin.x
    }
    public var right: CGFloat{
        return self.frame.size.width + self.frame.origin.x
        
    }
}

class otherfunctions{
    
//    class func  alertErrorLogin(_ title: String,_ Msesage: String){
//        let alert = UIAlertController (title: title, message: Msesage, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
//        present(alert, animated: true)
//        
//    }
}
