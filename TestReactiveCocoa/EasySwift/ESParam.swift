//
//  ESParam.swift
//  TestReactiveCocoa
//
//  Created by  rjt on 16/1/18.
//  Copyright © 2016年 JYZD. All rights reserved.
//

import Foundation
import Alamofire

protocol ESParamType{
    var dictParam:Dictionary<String,AnyObject>{get};
    var headerParam:Dictionary<String,String>{get};
    var urlParam:String{get};
    var methodParam:Alamofire.Method{get};
    var encodingParam:Alamofire.ParameterEncoding{get};

    var entityClassParam:AnyClass{get}

    var method:Alamofire.Method?{get set};
    var url:String?{get set};
    var dict:Dictionary<String,AnyObject>?{get set};//用于设置快速参数列表
    var header:Dictionary<String,String>?{get set};//用于设置快速参数列表
    var entityClass:AnyClass?{get set};//用于设置快速参数列表
    
    func getUrl()->String;
    func getTranslateUrl()->String;
    func getMethod()-> Alamofire.Method;
    func getEntityClass()-> AnyClass;
    
    func catchErrors(error:NSError?, entity:ESEntity?)->Bool;
    
}


extension ESParamType{
    var dictParam:Dictionary<String,AnyObject>{
        get{
            if let _ = dict{
                return dict!;
            }else{
                return self.getDictFromParam(NSObject.classForCoder());
            }
        }
    };
    var headerParam:Dictionary<String,String>{
        get{
            if let _ = header{
                return header!;
            }else{
                return Dictionary<String,String>();
            }
            
        }
    };
    
    var urlParam:String{
        get{
            if let _ = url {
                return url!;
            }else{
                return getTranslateUrl();
            }
        }
    }
    
    var methodParam:Alamofire.Method{
        get{
            if let _ = method {
                return method!;
            }else{
                return getMethod();
            }
        }
    }
    
    var entityClassParam:AnyClass{
        get{
            if let _ = entityClass {
                return entityClass!;
            }else{
                return getEntityClass();
            }
        }
    }
    
    var encodingParam:Alamofire.ParameterEncoding{
        switch methodParam{
        case .POST : return .JSON;
        default    : return .URL;
        }
    }
    
    func getDictFromParam(ignorCls:AnyClass)->Dictionary<String,AnyObject>{
        var d = Dictionary<String,AnyObject>();
        var mirror:Mirror? =  Mirror(reflecting: self);
        while let m = mirror where m.subjectType != ignorCls{
            for case let (label?, anyValue) in m.children {
                guard let l = convertKeyWords(label) else{break}
                if let value = anyValue as? AnyObject {
                    d[l] = value;
                }
                let a = Mirror(reflecting:anyValue);
                
                let list = a.children.filter{ (label2: String?, value: Any) -> Bool in
                    if(label2 == "Some"){//Optional
                        return true;
                    }
                    return false;
                }
                if list.count > 0 {
                    d[l] = list[0].value as? AnyObject;
                }
            }
            mirror = m.superclassMirror();
        }
        
        return d;
    }
    
}



class ESParam:NSObject,ESParamType {
    
    var method:Alamofire.Method?;
    var url:String?;
    var dict:Dictionary<String,AnyObject>?;//用于设置快速参数列表
    var header:Dictionary<String,String>?;
    var entityClass:AnyClass?;//用于设置快速参数列表
    
    func getEntityClass() -> AnyClass {//子类实现
        return ESEntity.classForCoder()
    }
    
    func getUrl()->String{//子类实现
        return "";
    }
    
    func getTranslateUrl()->String{//子类实现
        return "";
    }
    
    func getMethod()-> Alamofire.Method{
        return .POST;
    }
    
    func catchErrors(error: NSError?, entity: ESEntity?)->Bool {//子类实现
        return true;
    }
    
    var dictParam:Dictionary<String,AnyObject>{
        get{
            if let _ = dict{
                return dict!;
            }else{
                return self.getDictFromParam(ESParam.classForCoder());
            }
        }
    };
    
    
    
    
    
}

