//
//  HistoryViewModel.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 21.01.2022.
//

import Foundation

protocol HistoryViewModelProtocol {
    var responses:  [BitLyResponse] { get }
    var numberOfRows: Int { get }
    func fetchResponses(completion: () -> Void)
    func deleteResponse(at rowIndex: Int, completion: () -> Void)
}

class HistoryViewModel: HistoryViewModelProtocol {
    
    var responses: [BitLyResponse] = []
    var numberOfRows: Int {
        responses.count
    }
    
    func fetchResponses(completion: () -> Void) {
        responses = StorageManager.shared.fetchUrlList()
        completion()
    }
    
    func deleteResponse(at rowIndex: Int, completion: () -> Void) {
        StorageManager.shared.deleteResponse(at: rowIndex)
        responses.remove(at: rowIndex)
        completion()
    }
}
