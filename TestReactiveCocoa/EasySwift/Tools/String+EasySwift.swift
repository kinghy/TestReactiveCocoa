//
//  String+EasySwift.swift
//  TestReactiveCocoa
//
//  Created by  rjt on 16/1/19.
//  Copyright © 2016年 JYZD. All rights reserved.
//

import Foundation

extension String {
    func sha1() -> String {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
        var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joinWithSeparator("")
    }
    
    func trimOptinal()->String{
        if self.hasPrefix("Optional<") && self.hasSuffix(">"){
            return self.substringToIndex(self.endIndex.advancedBy(-1)).substringFromIndex(self.startIndex.advancedBy(9));
        }else{
            return String(self);
        }
    }
}