//
//  Post.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/10/24.
//

import Foundation

struct Post: Identifiable {
    var id = UUID().uuidString
    var user: String
    var profile: String
    var postImage: String
    var postTittle: String
    var time: String
}


var posts = [
    Post(user: "iJustine", profile: "p1", postImage: "posts1", postTittle: "iPhone 11 ...", time: "58 min ago"),
    Post(user: "AngryJulie", profile: "p2", postImage: "posts2", postTittle: "iPhone 12 ...", time: "8 min ago"),
    Post(user: "LittleLily", profile: "p3", postImage: "posts3", postTittle: "iPhone 13 ...", time: "38 min ago"),
    Post(user: "someJuicy", profile: "p4", postImage: "posts4", postTittle: "iPhone 12 Pro ...", time: "1 hour ago"),
    Post(user: "purple_Love", profile: "p5", postImage: "posts5", postTittle: "iPhone 13 Pro Max ...", time: "18 min ago"),
    
]
