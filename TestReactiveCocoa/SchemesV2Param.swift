//
//  SchemesV2Param.swift
//  TestReactiveCocoa
//
//  Created by  rjt on 16/1/22.
//  Copyright © 2016年 JYZD. All rights reserved.
//

import Foundation

class SchemesV2Param : AppParam{
    
    override func getUrl() -> String {
        return "/insp/schemes_v2";
    }
    override func getEntityClass() -> AnyClass {
        return SchemesV2Entity.self;
    }
}

class SchemesV2Entity : AppEntity{
    var fund = [String]();
    var schemes = [SchemesV2RecordEntity]();
}

class SchemesV2RecordEntity : AppEntity{
    var		zs	:String?
    var		zy	:String?
    var		oper_type	:String?
    var		earnest	:String?
    var		rule_type	:String?
    var		amount	:String?
    var		sub_type	:String?
    var		scheme_num	:String?
    var		scheme_name	:String?
    var		distribution:DistributionEntity?;
    var		dis_state	:String?
    var		fee	:String?
    var		trade_fee	:String?
    var		feeshow	:String?
    var		invert_fee	:String?
}

class DistributionEntity : AppEntity{
        var user_profit:String?
        var t_profit:String?
        var f_profit:String?
        var p_profit:String?
}