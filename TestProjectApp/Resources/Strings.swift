// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Error {
    /// Something went wrong
    internal static let genericMessage = L10n.tr("Localizable", "error.generic-message")
    /// Something went wrong, please retry
    internal static let genericRetryMessage = L10n.tr("Localizable", "error.generic-retry-message")
    /// An unknown error occured
    internal static let genericTitle = L10n.tr("Localizable", "error.generic-title")
    /// Server returned something weird, not an expected data
    internal static let incorrectRespinseMessage = L10n.tr("Localizable", "error.incorrect-respinse-message")
    /// Incorrect Server Response
    internal static let incorrectResponseTitle = L10n.tr("Localizable", "error.incorrect-response-title")
    /// It seems like username or password you provided is incorrect
    internal static let loginDeniedMessage = L10n.tr("Localizable", "error.login-denied-message")
    /// Login failed
    internal static let loginDeniedTitle = L10n.tr("Localizable", "error.login-denied-title")
  }

  internal enum Login {
    /// Login
    internal static let loginTitle = L10n.tr("Localizable", "login.login-title")
    /// Password
    internal static let passwordPlaceholder = L10n.tr("Localizable", "login.password-placeholder")
    /// Username
    internal static let usernamePlaceholder = L10n.tr("Localizable", "login.username-placeholder")
  }

  internal enum Warning {
    internal enum Search {
      /// No results has been found
      internal static let noResultsFound = L10n.tr("Localizable", "warning.search.no-results-found")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
