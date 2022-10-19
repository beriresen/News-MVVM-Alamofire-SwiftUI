//
//  Haberler.swift
//  Haberler
//
//  Created by Erdinç Ayvaz on 12.08.2022.
//

import Foundation

struct Haberler:Codable{
//    var status:String
//    var totalResults:Int
    var articles = [Articles]()
}

struct Articles:/*Identifiable,*/ Codable{
    //var id = UUID()
    var source:Source?
    var author:String?
    var title:String?
    var description:String?
    var urlToImage:String?
    var url:String?
    var content:String?
}

extension Articles: Identifiable {
  var id: UUID { return UUID() }
}

struct Source:Codable {
    var name:String?
}


struct RequestModel:Codable {
    var country:String
    var apiKey:String
}

