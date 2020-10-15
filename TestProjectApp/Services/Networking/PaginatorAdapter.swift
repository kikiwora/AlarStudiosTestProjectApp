//
//  PaginatorAdapter.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 15.10.2020.
//

import Foundation

protocol PaginatorAdapterType {
    associatedtype PageType
    associatedtype DataElementType

    func processLoadedData(_ data: PageType)
    func getPage(_ index: Int) -> PageType?
    func getDataElement(byIndex index: Int) -> DataElementType?
}

protocol PaginatorAdapterDelegate: class {
    func loadData(page: Int)
    func willLoadData()
    func didLoadData()
}

class PaginatorAdapter<PaginatorDataType>: PaginatorAdapterType where PaginatorDataType: StatusRepresentable &
                                                                        DataListRepresentable & Decodable {
    typealias PageType = PaginatorDataType
    typealias DataElementType = PaginatorDataType.DataElementType

    weak var delegate: PaginatorAdapterDelegate!

    private var pageCache: PageCache<PageType> = .init()

    init(with delegate: PaginatorAdapterDelegate) {
        self.delegate = delegate
    }

    func processLoadedData(_ data: PaginatorDataType) {
        pageCache.updateData(data)
        delegate.didLoadData()
    }

    func getPage(_ index: Int) -> PageType? {
        if let page = pageCache.getPage(index) {
            return page
        }

        delegate.willLoadData()
        delegate.loadData(page: index)
        return nil
    }

    func getDataElement(byIndex index: Int) -> DataElementType? {
        return pageCache.getDataElement(byIndex: index)
    }
}
