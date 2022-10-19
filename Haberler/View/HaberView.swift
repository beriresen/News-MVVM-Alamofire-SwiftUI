//
//  ContentView.swift
//  Haberler
//
//  Created by Erdinç Ayvaz on 12.08.2022.
//

import SwiftUI
import ToastSwiftUI

struct HaberView: View {
    @State private var selection = 0 //selected page
    let dataModel = Constant.baslik
    
    @StateObject var viewModel = HaberViewModel()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    //ScrollableTabView
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        ScrollViewReader { scrollReader in
                            ScrollableTabView(activeIdx: $selection,dataSet: Constant.baslik)
                                .foregroundColor(Color("project_color"))
                                .padding(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5))
                                .onChange(of: selection, perform: { value in
                                    withAnimation{
                                        scrollReader.scrollTo(value, anchor: .center)
                                    }
                                })
                        }
                    })
                    .background(Color(.white))
                    //Page View
                    LazyHStack {
                        TabView(selection:$selection) {
                            ForEach(0..<dataModel.count, id: \.self) { i in
                                ZStack {
                                    VStack {
                                        List(viewModel.haberler.articles, id:\.urlToImage){ item in
                                            ZStack{
                                                NavigationLink(destination: HaberDetayView(haber: item)){
                                                    EmptyView()
                                                }
                                                VStack(alignment:.leading, spacing:5){
                                                    HStack {
                                                        Text(item.author ?? "Default")
                                                            .fontWeight(.bold)
                                                            .foregroundColor(.gray)
                                                        Spacer()
                                                        VStack {
                                                            Button(action: {
                                                                viewModel.secilenHaber = item
                                                                viewModel.showingOptions = true
                                                            }, label: {
                                                                Image("dots")
                                                                    .renderingMode(.template)
                                                                    .resizable()
                                                                    .frame(width: 16, height: 16)
                                                                    .colorMultiply(.gray)
                                                                    .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 0))
                                                            })
                                                            .buttonStyle(PlainButtonStyle())
                                                            
                                                            .confirmationDialog("İşlem Seçiniz", isPresented: $viewModel.showingOptions, titleVisibility: .visible) {
                                                                if let secilenHaber = viewModel.secilenHaber {
                                                                    
                                                                    Button(action: {
                                                                        actionSheet(url: secilenHaber.url ?? "")
                                                                    }, label: {
                                                                        Text("Paylaş")
                                                                    })
                                                                    Button("Bağlantıyı Kopyala") {
                                                                        viewModel.isPresentingToast = true
                                                                        UIPasteboard.general.string = secilenHaber.url
                                                                        if secilenHaber.url != ""{
                                                                            viewModel.toastMessage = "Link Kopyalandı"
                                                                        }
                                                                    }
                                                                    Link("Tarayıcıda Aç", destination: URL(string: secilenHaber.url ?? "")!)
                                                                    
                                                                    Button("İptal", role: .cancel) {
                                                                        viewModel.showingOptions = false
                                                                    }
                                                                }
                                                            }
                                                        }.alert(item: $viewModel.alertItem) { alertItem in
                                                            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)}
                                                        
                                                    } //Hstack
                                                    //  NavigationLink(destination: HaberDetayView(haber: item), label: {
                                                    //  Text("BRR")
                                                    //})
                                                    
                                                    Text(item.title ?? "Default")
                                                        .fontWeight(.bold)
                                                        .font(.title2)
                                                    
                                                    ZStack {
                                                        RemoteImage(urlString: item.urlToImage ?? "Def").frame(height: 180)
                                                        VStack{
                                                            Spacer()
                                                            Shape(startColor: Color.clear, endColor: Color.black, angle: .horizontal, cornerRadius: 0, lineWidth: 0, lineColor: Color.red)
                                                                .frame(height:20)
                                                        }
                                                    }.cornerRadius(16)
                                                }
                                            }.padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                                        }
                                        .listStyle(GroupedListStyle())   //list
                                            .onAppear(perform: {
                                                UITableView.appearance().contentInset.top = -34
                                            })
                                        //.onAppear{
                                        //viewModel.getHaberler(url: .enYeni)}
                                        Spacer()
                                    }.tag(i)
                                }
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 170)
                        //give padding nav height + scrollable Tab
                        .tabViewStyle(PageTabViewStyle.init(indexDisplayMode: .never))
                        
                    }
                }
                .navigationBarTitle("Haberler", displayMode: .inline)
                .toolbar { // <2>
                    ToolbarItem(placement: .principal) { // <3>
                        VStack {
                            Text("Haberler")
                                .font(.headline)
                                .foregroundColor(Color("project_color"))
                            // Text(dataModel[selection]).font(.subheadline)
                        }
                    }
                }
            }
            .onChange(of: selection, perform: { value in
                viewModel.getHaberler(apiMethod: .topHeadLines, category: Constant.haberCategories[selection])
            })
            .onAppear{
                viewModel.getHaberler(apiMethod: .topHeadLines, category: .general)
            }
            .toast(isPresenting: $viewModel.isPresentingToast, message:viewModel.toastMessage ?? "", icon: .success, backgroundColor: .white, textColor: .orange)
            
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
            }
        }
        
    }
    func actionSheet(url:String) {
        guard let urlShare = URL(string:  url) else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}

struct HaberView_Previews: PreviewProvider {
    static var previews: some View {
        HaberView()
    }
}
