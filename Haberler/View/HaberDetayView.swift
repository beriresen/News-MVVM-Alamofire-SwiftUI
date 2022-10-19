//
//  HaberDetayView.swift
//  Haberler
//
//  Created by Erdinç Ayvaz on 12.08.2022.
//

import SwiftUI
import Combine
import WebKit


struct HaberDetayView: View {
    var haber = Articles()
    var body: some View {

        WebView(request: URLRequest(url: URL(string: haber.url ?? "")!))
    }
}

struct HaberDetayView_Previews: PreviewProvider {
    static var previews: some View {
        
        let haber = Articles()
        
        HaberDetayView(haber: haber)
    }
}


struct WebView : UIViewRepresentable {
    
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}
