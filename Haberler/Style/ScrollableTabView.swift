//
//  ScrollableTabView.swift
//  Projects
//
//  Created by BRR on 9.08.2022.
//

import SwiftUI
import ToastSwiftUI

struct ScrollableTabView : View {
    
    @Binding var activeIdx: Int
    @State private var w: [CGFloat]
    private let dataSet: [String]
    init(activeIdx: Binding<Int>, dataSet: [String]) {
        self._activeIdx = activeIdx
        self.dataSet = dataSet
        _w = State.init(initialValue: [CGFloat](repeating: 0, count: dataSet.count))
        
    }
    
    var body: some View {
        VStack(alignment: .underlineLeading) {
            HStack {
                ForEach(0..<dataSet.count, id: \.self) { i in
                    Text(dataSet[i])
                        .font(.system(size: 16))
                        .modifier(ScrollableTabViewModifier(activeIdx: $activeIdx, idx: i))
                        .background(TextGeometry())
                        .onPreferenceChange(WidthPreferenceKey.self, perform: { self.w[i] = $0 })
                        .id(i)
                    Spacer().frame(width: 20)
                }
            }
            .padding(.horizontal, 5)
            Rectangle()
                .alignmentGuide(.underlineLeading) { d in d[.leading]  }
                .frame(width: w[activeIdx],  height: 4)
                .animation(.linear)
        }
    }
}

struct TextGeometry: View {
    var body: some View {
        GeometryReader { geometry in
            return Rectangle().fill(Color.clear).preference(key: WidthPreferenceKey.self, value: geometry.size.width)
        }
    }
}

struct ScrollableTabViewModifier: ViewModifier {
    @Binding var activeIdx: Int
    let idx: Int
    
    func body(content: Content) -> some View {
        Group {
            if activeIdx == idx {
                content.alignmentGuide(.underlineLeading) { d in
                    return d[.leading]
                }.onTapGesture {
                    withAnimation{
                        self.activeIdx = self.idx
                    }
                }
                
            } else {
                content.onTapGesture {
                    withAnimation{
                        self.activeIdx = self.idx
                    }
                }
            }
        }
    }
}
//Tab bar
extension HorizontalAlignment {
    private enum UnderlineLeading: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.leading]
        }
    }
    
    static let underlineLeading = HorizontalAlignment(UnderlineLeading.self)
}

struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue = CGFloat(0)
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
    
    typealias Value = CGFloat
}
//page view
//struct PageView: View {
//    
//    @Binding var selection: Int
//    public let dataModel: [String]
//  
//    @StateObject var viewModel = HaberView.HaberViewModel()
//    
//    
//    var body: some View {
//        TabView(selection:$selection) {
//            ForEach(0..<dataModel.count) { i in
//                ZStack {
//                    VStack {
//                        
//                        List(viewModel.haberler.articles, id:\.urlToImage){ item in
//                            VStack(alignment:.leading, spacing:10){
//                                HStack {
//                                    Text(item.author ?? "Default")
//                                        .fontWeight(.bold)
//                                        .foregroundColor(.gray)
//                                    Spacer()
//                                    VStack {
//                                        Button(action: {
//                                            viewModel.showingOptions = true
//                                        }, label: {
//                                            Image("dots")
//                                                .resizable()
//                                                .aspectRatio(contentMode: .fit)
//                                                .frame(width: 20, height:20)
//                                        })
//                                        .buttonStyle(PlainButtonStyle())
//                                        
//                                        .confirmationDialog("İşlem Seçiniz", isPresented: $viewModel.showingOptions, titleVisibility: .visible) {
//                                            Button(action: {
//                                                actionSheet(url: item.url ?? "")
//                                            }, label: {
//                                                Text("Paylaş")
//                                                    .foregroundColor(.gray)
//                                            })
//                                            Button("Bağlantıyı Kopyala") {
//                                                viewModel.isPresentingToast = true
//                                                UIPasteboard.general.string = item.url
//                                                if item.url != ""{
//                                                    viewModel.toastMessage = "Link Kopyalandı"
//                                                }
//                                            }
//                                            Link("Tarayıcıda Aç", destination: URL(string: item.url ?? "")!).foregroundColor(.gray)
//                                        }
//                                    }
//                                } //Hstack
//                                Text(item.title ?? "Default")
//                                    .fontWeight(.bold)
//                                    .font(.title2)
//                                ZStack {
//                                    RemoteImage(urlString: item.urlToImage ?? "Def")
//                                        .frame(height: 180)
//                                    VStack{
//                                        Spacer()
//                                        Shape(startColor: Color.clear, endColor: Color.black, angle: .horizontal, cornerRadius: 0, lineWidth: 0, lineColor: Color.red)
//                                            .frame(height:20)
//                                    }
//                                }.cornerRadius(16)
//                            }.padding(EdgeInsets(top: 10, leading: 0, bottom: 25, trailing: 5)) //Vstack
//                        } .listStyle(GroupedListStyle())
//                            .onAppear(perform: {
//                                UITableView.appearance().contentInset.top = -34
//                            })
//                        Spacer()
//                    }
//                    Spacer()
//                        .alert(item: $viewModel.alertItem) { alertItem in
//                            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)}
//                }.tag(i)
//                    .toast(isPresenting: $viewModel.isPresentingToast, message:viewModel.toastMessage ?? "", icon: .success, backgroundColor: .white, textColor: .orange)
//            }
//            .onAppear{
//                //viewModel.getHaberler(url: .enYeni)
//                viewModel.getHaberler(url: Constant.haberCategories[selection])
//            }
//        }
//        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 170)
//        //give padding nav height + scrollable Tab
//        .tabViewStyle(PageTabViewStyle.init(indexDisplayMode: .never))
//        
//    }
//    func actionSheet(url:String) {
//        guard let urlShare = URL(string:  url) else { return }
//        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
//        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
//    }
//}




struct PageView2: View {
    @Binding var selection: Int
    let dataModel: [String]
    
    var body: some View {
        TabView(selection:$selection) {
            ForEach(0..<dataModel.count, id: \.self) { i in
                VStack {
                    HStack {
                        Text(dataModel[i])
                            .foregroundColor(Color.red)
                            .padding()
                        Spacer()
                        
                    }
                    Spacer()
                }.tag(i)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 170)
        //give padding nav height + scrollable Tab
        .tabViewStyle(PageTabViewStyle.init(indexDisplayMode: .never))
        
    }
}
