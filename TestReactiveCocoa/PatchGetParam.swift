//
//  PatchGetParam.swift
//  TestReactiveCocoa
//
//  Created by  rjt on 16/1/20.
//  Copyright © 2016年 JYZD. All rights reserved.
//

import Foundation
import Alamofire


class PatchGetParam : AppParam {
    var name:String = "version_ios";
    
    override func getEntityClass() -> AnyClass {
        return PatchGetEntity.self;
    }
    
    override func getMethod() -> Alamofire.Method {
        return .GET;
    }
    
    override func getUrl() -> String {
        return "/update/patchGet/";
    }
    
}

class PatchGetEntity : AppEntity{
    var res_data:PatchGetResDataEntity?                                                                                                                     ;
}

class PatchGetResDataEntity : AppEntity{
    var name:String?;
    var version:String?;
    var create_time:String?;
    var flag:String?;
    var url:String?;
}
