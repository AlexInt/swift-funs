//
//  RefreshablePost.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/11/30.
//

import Foundation

struct RefreshablePost: Identifiable, Hashable {
    var id = UUID().uuidString
    var imageURL: String
}
