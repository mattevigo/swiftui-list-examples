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
            UUID().uuidString
        })
        currentPage = currentPage + 1
        print("Page loaded: \(currentPage)")
    }
}

struct InfiniteScrollingList: View {
    @ObservedObject var viewModel = InfiniteScrollingViewModel()

    var body: some View {
        List(viewModel.contents.indices, id: \.self) { index in
            Item(id: index, content: viewModel.contents[index])
        }
    }

    init() {
        viewModel.loadNextPage()
    }
}

struct Item: View, Identifiable {

    var id: Int
    var content: String

    var body: some View {
        Text("\(id) - \(String(content.prefix(6)))")
    }
}

struct InfiniteScrollingList_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteScrollingList()
    }
}
