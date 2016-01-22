//
//  AppParam.swift
//  TestReactiveCocoa
//
//  Created by  rjt on 16/1/19.
//  Copyright © 2016年 JYZD. All rights reserved.
//

import Foundation

class AppParam: ESParam {
    
    override init() {
        super.init();
        self.header = ["x-qfgj-did":"i968372f38a4370626b76eba3722bc8ef79696527","x-qfgj-sid":"0CE035A7B0CEB79CF8C0F03D3E6A17D8","x-qfgj-uid":"769"];
    }
    
    override func getTranslateUrl() -> String {
        return "http://192.168.6.103:8116"+self.getUrl();
    }
    
}