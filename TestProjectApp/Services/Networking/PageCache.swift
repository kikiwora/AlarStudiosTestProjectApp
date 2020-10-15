//
//  PageCache.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 15.10.2020.
//

import Foundation

class PageCache<PageType> where PageType: DataListRepresentable {
    private var pages: Set<PageType> = []
    private var sortedPages: [PageType] = []

    // TODO: This cache probably should offload pages to Disk and account for page life span (TTL) to reduce memory usage

    func cacheData(_ data: PageType) {
        pages.insert(data)
        sortedPages.insert(data, at: data.page)
    }

    func updateData(_ data: PageType) {
        removeData(data)
        cacheData(data)
    }

    func removeData(_ data: PageType) {
        if let toRemove = pages.first(where: { $0.hashValue == data.hashValue }) {
            pages.remove(toRemove)
            sortedPages.remove(toRemove)
        }
    }

    func getPage(_ pageNumber: Int) -> PageType? {
        return pages.first(where: { $0.page == pageNumber })
    }

    func getDataElement(byIndex index: Int) -> PageType.DataElementType? {
        let pagesElements = sortedPages.flatMap { $0.data }
        return pagesElements[safe: index]
    }
}
