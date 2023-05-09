import SwiftUI
import SpriteKit




struct ContentView: View {
    
    @State var teste = false
    
    @EnvironmentObject var coordinator: ViewCordinator
    
    public func didTapShowMars(){
        coordinator.push(view: .mars)
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            ZStack {
                Image("home-screen")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    NavigationLink {
                        EarthView(didUserClickGoToMarrs: {
                            didTapShowMars()
                        })
                            .ignoresSafeArea(.all)
                            .navigationBarHidden(true)
                        
                        
                    } label: {
                        Image("start-button")
                            .resizable()
                            .frame(width: 360, height: 150)
                    }.padding(.bottom, 120)
                }
            }
        }
    }
}
