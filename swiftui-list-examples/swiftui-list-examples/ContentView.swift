//
//  ContentView.swift
//  swiftui-list-examples
//
//  Created by Matteo Vigoni on 19/11/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: InfiniteScrollingList()) {
                    Text("Infinite scrolling")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
