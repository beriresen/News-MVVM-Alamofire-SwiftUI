//
//  Constant.swift
//  Projects
//
//  Created by BRR on 7.08.2022.
//

import Foundation

public class Constant {
    
    public static let baseURL = "https://newsapi.org/v2/"
    public static let apiKey = "6aef9a4f801041db8f6cf22896620e8f"
    
    public static let baslik = ["En Yeni", "Sağlık", "Spor", "Magazin", "İş Dünyası", "Bilim"]
    static let haberCategories:[Categories] = [.general,.health,.sports,.entertainment,.business,.science]
}

enum Methods:String{
    case topHeadLines = "top-headlines"
}

enum Categories:String{
    case general = "general"
    case health = "health"
    case sports = "sports"
    case entertainment = "entertainment"
    case business = "business"
    case science = "science"
}
