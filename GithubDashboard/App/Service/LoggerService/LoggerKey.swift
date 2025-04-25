//
//  LoggerKey.swift
//  GithubDashboard

import SwiftUI

private struct LoggerKey: EnvironmentKey {
    static let defaultValue: LoggerService = ConsoleLogger()
}

extension EnvironmentValues {
    var logger: LoggerService {
        get {
            self[LoggerKey.self]
        }
        set {
            self[LoggerKey.self] = newValue
        }
    }
}
