//
//  routerApp.swift
//  router
//
//  Created by dongnguyen on 14/6/24.
//

import SwiftUI

@main
struct routerApp: App {
    @ObservedObject private var router = DNRouter()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                HomeView()
                    .navigationDestination(for: DNRouter.Destination.self) { destination in
                        switch destination {
                        case .livingroom:
                            LivingroomView()
                        case .bedroom(let owner):
                            BedroomView(ownerName: owner)
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}

struct HomeView: View {
    @EnvironmentObject var router: DNRouter

    var body: some View {
        VStack {
            Image(systemName: "house.fill")
                .font(.system(size: 56))
                .foregroundColor(.accentColor)
            Text("**Home**")
                .font(.system(size: 24))
            
            Button(action: {
                router.navigate(to: .livingroom)
            }, label: {
                Text("**Go to Livingroom**")
            })
            .padding(12)
        }
        .padding()
    }
}

struct LivingroomView: View {
    @EnvironmentObject var router: DNRouter
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            VStack {
                Image(systemName: "sofa.fill")
                    .font(.system(size: 56))
                    .foregroundColor(.accentColor)
                Text("**Livingroom**")
                    .font(.system(size: 24))
                    .padding(.top, 12)
                
                Button("**Go to Duyen's Bedroom**") {
                    router.navigate(to: .bedroom(owner: "Jane"))
                }
                .padding(.top, 12)
                
                Button("**Go to Dong's Bedroom**") {
                    router.navigate(to: .bedroom(owner: "John"))
                }
                .padding(.top, 12)
                
                Button {
                    router.navigateBack()
                } label: {
                    Text("Back")
                }
                .padding(.top, 4)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct BedroomView: View {
    @EnvironmentObject var router: DNRouter
    var ownerName: String
    
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            VStack {
                Text("\(ownerName)'s Bedroom")
                    .font(.system(size: 36, weight: .bold))
                    .padding(.bottom, 12)
                Image(systemName: "bed.double.fill")
                    .font(.system(size: 56))
                    .foregroundColor(.accentColor)
                
                Button {
                    router.navigateBack()
                } label: {
                    Text("Back to **Livingroom**")
                }
                .padding(.top, 12)
                
                Button {
                    router.navigateToRoot()
                } label: {
                    Text("Pop to **Home**")
                }
                .padding(.top, 4)
            }
        }
        .navigationBarBackButtonHidden()
    }
}
