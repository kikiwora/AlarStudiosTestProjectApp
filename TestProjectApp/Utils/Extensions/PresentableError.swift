//
//  PresentableError.swift
//  TestProjectApp
//
//  Created by Roman Suvorov on 06.10.2020.
//

import Foundation

struct PresentableError: LocalizedError {
    let localizedTitle: String
    let localizedMessage: String

    var errorDescription: String? {
        return localizedMessage
    }
}

extension PresentableError {
    init?(_ error: Error) {
        if let presentableError = error as? PresentableError {
            self = presentableError
        } else {
            self = PresentableError(localizedTitle: L10n.Error.genericTitle, localizedMessage: error.localizedDescription)
        }
    }
}

extension PresentableError {
    static let generic = PresentableError(localizedTitle: L10n.Error.genericTitle,
                                          localizedMessage: L10n.Error.genericMessage)
    static let genericRetry = PresentableError(localizedTitle: L10n.Error.genericTitle,
                                               localizedMessage: L10n.Error.genericRetryMessage)
    static let incorrectResponse = PresentableError(localizedTitle: L10n.Error.incorrectResponseTitle,
                                                    localizedMessage: L10n.Error.incorrectRespinseMessage)

    static let loginDenied = PresentableError(localizedTitle: L10n.Error.loginDeniedTitle,
                                              localizedMessage: L10n.Error.loginDeniedMessage)
}
