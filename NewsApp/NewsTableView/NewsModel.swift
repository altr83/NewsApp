//
//  NewsModel.swift
//  NewsApp
//
//  Created by V on 26.11.2020.
//

import Foundation
import RealmSwift

class News: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var src: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var descr: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var urlToImage: String = ""
    @objc dynamic var publishedAt: String = ""
    
    override class func primaryKey() -> String? {
        return "title"
    }
}

