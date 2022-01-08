//
//  RequestManager.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 06/01/22.
//

import Foundation
import Alamofire
var session = AF
class RequestManager{
    typealias Metodo = HTTPMethod

    static func generic<A:Encodable, T:Decodable>(url:String,
                                                  metodo:Metodo,
                                                  contenido:A?,
                                                  parametrosMulti: [String:Data]? = nil,
                                                  headers:[String: String]? = nil,
                                                  tipoResultado:T.Type?,
                                                  delegate:RequestManagerDelegate,
                                                  tag:Int = 0){
        guard let urlForRequest = URL(string: url) else {
            delegate.onResponseFailure(data: nil ,error: .BAD_REQUEST, tag: tag)
            return
        }
        guard NetworkReachabilityManager()!.isReachable else {
            delegate.onResponseFailure(data: nil, error: .NOT_CONNECTION, tag: tag)
            return
        }
        var urlRequest:URLRequest = URLRequest(url: urlForRequest)
        urlRequest.httpMethod = metodo.rawValue
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("URL ", url)
        print("Contenido ", contenido)
        
        for header in headers ?? [:] {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        urlRequest.timeoutInterval  = 100
        
        
        let accion:((AFDataResponse<Data>) -> Void) = { (data: AFDataResponse<Data>) -> (Void)  in
            switch data.result {
            case .success:
                guard let response = data.response, let value = data.data else {
                    delegate.onResponseFailure(data: nil, error: .UNKNOW, tag: tag)
                    return
                }
                print("Error \(response.statusCode)")
                let code = CodeResponse(rawValue: response.statusCode) ?? CodeResponse.UNKNOW
                
                
                if  code == .OK200 {
                    
                    do{
                        let obj = tipoResultado == nil ? nil : try JSONDecoder().decode(tipoResultado!.self, from: value)
                        
                        if tipoResultado != nil && obj == nil && !value.isEmpty {
                            print( "Posible bad decodable \((String(data: value, encoding: .utf8)) ?? "not_string")")
                            delegate.onResponseFailure(data: nil, error: .BAD_DECODABLE, tag: tag)
                        } else {
                            delegate.onResponseSuccess(data: obj, tag: tag)
                        }
                    } catch {
                        delegate.onResponseFailure(data: nil, error: .BAD_DECODABLE, tag: tag)
                        print(error)
                    }
                    
                } else {
                    print("Some code \(response.statusCode)")
                    let errorEntity: ErrorEntity? = try? JSONDecoder().decode(ErrorEntity.self, from: data.data ?? Data())
                    delegate.onResponseFailure(data: errorEntity, error: code, tag: tag)
                }
            case .failure:
                let errorEntity: ErrorEntity? = try? JSONDecoder().decode(ErrorEntity.self, from: data.data ?? Data())
                delegate.onResponseFailure(data: errorEntity, error: .UNKNOW, tag: tag)
            }
        }
        
        let hedersObject = HTTPHeaders(headers ?? [:])
        session.request(urlForRequest,method: metodo,parameters: contenido?.dictionary ?? [:], encoding:URLEncoding.default, headers: hedersObject).responseData(completionHandler: accion)
        
        
    }
    static func generic(url:String, metodo:Metodo, headers: [String:String]? = nil,paremetrosMulti: [String:Data]? = nil, delegate:RequestManagerDelegate, tag:Int = 0) {
        let c : DummyCodable? = nil
        let t : DummyCodable.Type? = nil
        self.generic(url: url, metodo: metodo, contenido: c,parametrosMulti: paremetrosMulti,headers: headers, tipoResultado: t, delegate: delegate, tag: tag)
    }
    static func generic<A:Encodable>(url:String, metodo:Metodo, contenido:A?, headers: [String:String]? = nil, delegate:RequestManagerDelegate, tag:Int = 0){
        let t : DummyCodable.Type? = nil
        self.generic(url: url, metodo: metodo, contenido: contenido, headers: headers, tipoResultado: t, delegate: delegate, tag: tag)
    }
    static func generic<T:Decodable>(url:String, metodo:Metodo, headers: [String:String]? = nil, tipoResultado:T.Type?, delegate:RequestManagerDelegate, tag:Int = 0) {
        let c : DummyCodable? = nil
        self.generic(url: url, metodo: metodo, contenido: c, headers: headers,tipoResultado: tipoResultado, delegate: delegate, tag: tag)
    }
    
}


class DummyCodable:Codable {}
/// Delegado del Reques manager para recibir la peticiones
protocol RequestManagerDelegate {
    func onResponseSuccess(data:Decodable?,tag:Int)
    func onResponseFailure(error:CodeResponse,tag:Int)
    func onResponseFailure(data: ErrorEntity?, error: CodeResponse, tag: Int)
}


extension RequestManagerDelegate {
    func onResponseSuccess(data:Decodable?,tag:Int) {
    }
    func onResponseFailure(error:CodeResponse,tag:Int) {
    }
    
    func onResponseFailure(data: ErrorEntity?, error: CodeResponse, tag: Int){
        onResponseFailure(error: error, tag: tag)
    }
}
enum CodeResponse: Int {
    
    case BAD_REQUEST = 400
    case SERVER_ERROR = 500
    case NOT_FOUND = 404
    
    case OK200 = 200 // OK
    case SIN_CONTENIDO = 204
    
    case UNKNOW = -1
    case NOT_CONNECTION = -2
    case BAD_DECODABLE = -4
    
}


extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
