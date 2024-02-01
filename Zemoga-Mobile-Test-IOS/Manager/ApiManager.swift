//
//  ApiManager.swift
//  Zemoga-Mobile-Test-IOS
//
//  Created by Josue Veliz on 30/1/24.
//

import Foundation
import Alamofire

class ApiManager {
    static let shared = ApiManager()
    
    var isConnected: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
