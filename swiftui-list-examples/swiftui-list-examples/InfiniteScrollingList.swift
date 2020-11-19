//
//  InfinitScrollingList.swift
//  swiftui-list-examples
//
//  Created by Matteo Vigoni on 19/11/20.
//

import SwiftUI

class InfiniteScrollingViewModel: ObservableObject {

    var currentPage = 0
    let pageLimit = 100

    @Published var contents:[String] = []

    func loadNextPage() {
        contents.append(contentsOf: (0..<pageLimit).map { _ in
            UUID().uuidString // Just a random content to present
        })
        currentPage = currentPage + 1
        print("Page loaded: \(currentPage)")
    }

    func checkLoad(index: Int) {
        // If index is the last element then load the next page
        if index == contents.count - 1 {
            loadNextPage()
        }
    }
}

struct InfiniteScrollingList: View {
    @ObservedObject var viewModel = InfiniteScrollingViewModel()

    var body: some View {
        List(viewModel.contents.indices, id: \.self) { index in
            Item(id: index, content: viewModel.contents[index])
                .onAppear {
                    print("+++ Item \(index)")
                    viewModel.checkLoad(index: index)
                }
                .onDisappear {
                    print("--- Item \(index)")
                }
        }
        .onAppear {
            viewModel.loadNextPage()
        }
    }
}

struct Item: View, Identifiable {

    var id: Int
    var content: String

    var body: some View {
        Text("\(id) - \(String(content.prefix(6)))")
    }

    init(id: Int, content: String) {
        self.id = id
        self.content = content
        print("/// Item init \(id)")
    }
}

struct InfiniteScrollingList_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteScrollingList()
    }
}
