//
//  ESUtil.swift
//  TestReactiveCocoa
//
//  Created by  rjt on 16/1/21.
//  Copyright © 2016年 JYZD. All rights reserved.
//

import Foundation

func convertKeyWords(key:String?)->String?{//过滤swift关键字
    guard let k = key else{return key}
    switch k{
    case "id":return "ID"
    case "switch":return "Switch"
    default:return key;
    }
}