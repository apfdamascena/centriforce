import SwiftUI

@main
struct MyApp: App {
//    @ObservedObject var planetManager = PlanetObserver()
    
    @ObservedObject var coordinator = ViewCordinator()
    
    var body: some Scene {
        WindowGroup {
            if #available(iOS 16.0, *){
                GeometryReader { geometry in
                    NavigationStack(path: $coordinator.path){
                        ContentView()
                            .navigationDestination(for: RouteScreen.self){ destination in
                                switch destination {
                                case .earth:
                                    EarthView()
                                        .ignoresSafeArea(.all)
                                case .mars:
                                    MarsView()
                                        .ignoresSafeArea(.all)
                                        .statusBarHidden(true)
                                }
                                
                            }
   
                    }
                    .environment(\.mainWindowSize, geometry.size)
                    
                }.environmentObject(coordinator)
               
            }
        }
    }
}
