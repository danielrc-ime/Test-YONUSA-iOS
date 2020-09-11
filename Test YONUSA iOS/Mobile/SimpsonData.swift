//
//  SimpsonData.swift
//  Test YONUSA iOS
//
//  Created by MacInnovacion on 11/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation

// MARK: - WelcomeElement
struct SimpsonData: Codable {
    let quote, character: String
    let image: String
    let characterDirection: CharacterDirection
}

enum CharacterDirection: String, Codable {
    case characterDirectionLeft = "Left"
    case characterDirectionRight = "Right"
}

typealias Simpson = [SimpsonData]

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

