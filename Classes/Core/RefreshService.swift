//
//  RefreshService.swift
//  Dapi
//
//  Created by Mac on 25/2/19.
//

enum RefreshResult {
    case success
    case error
}

protocol RefreshService {
    func tryRefresh() -> RefreshResult
}
