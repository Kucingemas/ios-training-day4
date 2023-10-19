//
//  APIService.swift
//  day2
//
//  Created by ATM Touchpoint on 19/10/23.
//

import Foundation
import Alamofire

class APIService: NSObject {
    func fetchEmployees(
        onSuccess: @escaping ([Employee]) -> Void,
        onError: @escaping (Error?) -> Void
    ){
        guard let url = URL(string: "https://dummy.restapiexample.com/api/v1/employees") else {return}
        let urlConv :URLConvertible = url
        
        AF.request(urlConv).response { responseData in
                do{
                    let result = try JSONDecoder().decode(EmpployeeData.self, from: responseData.data!)
                    
                    DispatchQueue.main.async {
                        onSuccess(result.data)
                    }
        
                }catch let jsonErr{
                    onError(jsonErr)
                }
            }
    }
}
