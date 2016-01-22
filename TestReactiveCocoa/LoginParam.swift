//
//  LoginParam.swift
//  TestReactiveCocoa
//
//  Created by  rjt on 16/1/19.
//  Copyright © 2016年 JYZD. All rights reserved.
//

import Foundation

class LoginParam : AppParam {
    var logInID:String?;
    var password:String?{
        didSet{
            password = password?.sha1();
        }
    };
    var logInType:String = "2";   //2 手机
    var type:String?;   //3 注册后第一次登陆
    var security_code:String?;   //验证码
    var version_client:String?;   //客户端版本号
    
    override func getUrl() -> String {
        return "/user/loginMask";
    }
    
}

class LoginEntity : AppEntity{
    var encrypteKey:String?;
    var encryptedKey:String?;
    var failed_time:String?;
    var failed_times:String?;
    var nicknm_status:String?;
    var sessionId:String?;
    var session_id:String?;
    var type:String?;
    var uid:String?;
}