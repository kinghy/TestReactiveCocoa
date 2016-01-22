//
//  ESConnector.swift
//  TestReactiveCocoa
//
//  Created by  rjt on 16/1/18.
//  Copyright © 2016年 JYZD. All rights reserved.
//
import Foundation
import ReactiveCocoa
import Alamofire

class ESConnector : NSObject{
    func run(param:ESParamType)->SignalProducer<(Bool,ESEntity), NSError>{
//        print(param.dictParam);
//        print(param.headerParam);
        let producer = SignalProducer<(Bool,ESEntity), NSError> { (observer, _) in
            Alamofire.request(param.methodParam, param.urlParam, parameters: param.dictParam, encoding:param.encodingParam, headers: param.headerParam)
                .responseJSON(){ response in
                    if let JSON = response.result.value {
                        let entity = (param.getEntityClass() as! ESEntity.Type).self.init(json: JSON as! Dictionary<String, AnyObject>);
                        let flg = param.catchErrors(nil, entity:entity);
//                        print("JSON: \(JSON)");
                        observer.sendNext((flg,entity));
                        observer.sendCompleted();
                    }else if let error = response.result.error{
                        param.catchErrors(error, entity: nil)
                        observer.sendFailed(error);
                    }
            };
        }
        return producer;
    }
}