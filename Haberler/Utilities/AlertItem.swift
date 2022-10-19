//
//  AlertItem.swift
//  Projects
//
//  Created by BRR on 7.08.2022.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text
    var dismissButton: Alert.Button?
}

enum AlertContext {
    
    //MARK: - Network Errors
    static let invalidURL       = AlertItem(title: Text("UYARI"),
                                            message: Text("Sunucuya ulaşmaya çalışırken bir hata oluştu. Lütfen daha sonra tekrar deneyiniz."),
                                            dismissButton: .default(Text("Tamam")))
    
    static let unableToComplete = AlertItem(title: Text("UYARI"),
                                            message: Text("İsteğiniz şu anda tamamlanamıyor. Lütfen internet bağlantınızı kontrol edin."),
                                            dismissButton: .default(Text("Tamam")))
    
    static let invalidResponse  = AlertItem(title: Text("UYARI"),
                                            message: Text("Sunucudan geçersiz yanıt. Lütfen tekrar deneyin veya desteğe başvurun."),
                                            dismissButton: .default(Text("Tamam")))
    
    static let invalidData      = AlertItem(title: Text("UYARI"),
                                            message: Text("Sunucudan alınan veriler geçersizdi. Lütfen tekrar deneyin veya desteğe başvurun."),
                                            dismissButton: .default(Text("Tamam")))
}

