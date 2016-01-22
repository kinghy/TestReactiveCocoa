//
//  MenuParam.swift
//  TestReactiveCocoa
//
//  Created by  rjt on 16/1/21.
//  Copyright © 2016年 JYZD. All rights reserved.
//

import Foundation
import Alamofire

class MenuParam : AppParam{
    var type:String = "a50_discovery"
    
    override func getUrl() -> String {
        return "/newestinfo/getmenu";
    }
    override func getEntityClass() -> AnyClass {
        return MenuEntity.self;
    }
}

class MenuEntity : AppEntity{
    var menu = [MenuRecordsEntity]();
}

class MenuRecordsEntity : AppEntity{
    var name:String?;
    var url:String?;
    var icon:String?;
    var Switch:String?;
    var type:String?;
    var key:String?;
}