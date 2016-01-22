//
//  ESEntity.swift
//  TestReactiveCocoa
//
//  Created by  rjt on 16/1/19.
//  Copyright © 2016年 JYZD. All rights reserved.
//

import Foundation

protocol ESEntityType {
    var resultDict:Dictionary<String,AnyObject>{get set};
}

class ESEntity: NSObject,ESEntityType{
    var resultDict:Dictionary<String,AnyObject> = Dictionary<String,AnyObject>();
    
    required override init(){
        super.init();
    }
    
    
    required convenience init(json:Dictionary<String,AnyObject>) {
        self.init();
        loadFromJson(self, json:json);
        self.resultDict = json;
    }

    
    func loadFromJson(entity:ESEntity,json:Dictionary<String,AnyObject>){
        var mirror:Mirror? =  Mirror(reflecting: entity);
        while let m = mirror{
            for case let (label?, anyValue) in m.children {
                print(label);
                guard let jsonValue = json[label] else{ break;}
                guard let l = convertKeyWords(label) else{break}
                if let value = anyValue as? ESEntitiesType{
                    guard let arrayValue = jsonValue as? NSArray  else {break;}
                    guard let entities = value as? NSArray else {break;}
                    let arrayEntity = NSMutableArray.init(array:entities);
                    if value.isEntityType{
                        
                        for jsonDict in arrayValue{
                            if let e = (value.elementType as? ESEntity.Type)?.self.init() {
                                guard let dict = jsonDict as? Dictionary<String,AnyObject> else {break;};
                                
                                loadFromJson(e, json: dict);
                                arrayEntity.addObject(e);
                            }else{
                                arrayEntity.addObjectsFromArray(entities as [AnyObject]);
                            }
                        }
                        entity.setValue(arrayEntity, forKey:l);
                    }else{
                        entity.setValue(arrayValue.map{String($0)}, forKey: l);
                    }
                }else if var value = anyValue as? [String:String]{
                    guard let dictValue = jsonValue as? [String:AnyObject]  else {break;};
                    for case let (key,val) in dictValue{
                        value[key] = String(val);
                    }
                    
                    entity.setValue(value, forKey:l);
                }else{
                    let m2 = Mirror(reflecting: anyValue);
                    let className = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String + "." + String(m2.subjectType).trimOptinal()
                    if let entityType = NSClassFromString(className) as? ESEntity.Type{
                        let e = entityType.self.init() ;
                        if let dictValue = jsonValue as? Dictionary<String,AnyObject>{
                            loadFromJson(e,json:dictValue);
                        }
                        entity.setValue(e, forKey:l);
                    }
                    else{
                        entity.setValue(String(jsonValue), forKey:l);
                    }
                }
            }
            mirror = m.superclassMirror();
        }
    }
    
    
    
}

extension Array : ESEntitiesType{
    var elementType:Any{
        get{
            return Generator.Element.self;
        }
    }
    var isEntityType:Bool{
        get{
            return Generator.Element.self is ESEntityType.Type
        }
    }
}

protocol ESEntitiesType {
    var elementType:Any{get};
    var isEntityType:Bool{get};

}
