//
//  OpenAIAPIQueryResponses.swift
//
//  Created by Nico Tranquilli on 05/02/23.
//

import Foundation

// Completions
@objc
public class OpenAIAPICompletionResponse:NSObject, Codable {
    public let id: String
    public let object: String
    public let created: TimeInterval
    public let model: String
    public let choices: [OpenAIAPICompletionChoice]
    public let usage: OpenAIAPIUsage
}
@objc
public class OpenAIAPICompletionChoice: NSObject,Codable {
    public let text: String
    public let index: Int
    //public let logprobs: ..
    public let finish_reason: String
}

@objc
public class OpenAIAPIUsage: NSObject,Codable {
    public let prompt_tokens: Int
    public let completion_tokens: Int
    public let total_tokens: Int
    public static func < (lhs: OpenAIAPIUsage, rhs: OpenAIAPIUsage) -> Bool {
        lhs.total_tokens < rhs.total_tokens
    }
}

// Edits
@objc
public class OpenAIAPIEditChoice: NSObject,Codable {
    public let text: String
    public let index: Int
    //public let logprobs: ..
}
@objc
public class OpenAIAPIEditResponse: NSObject,Codable {
    public let object: String
    public let created: TimeInterval
    public let choices: [OpenAIAPIEditChoice]
    public let usage: OpenAIAPIUsage
}


// Models
@objc
public class OpenAIAPIModelsResponse:NSObject, Codable {
    public let data: [OpenAIAPIModelResponse]
    public let object: String
}
@objc
public class OpenAIAPIModelResponse: NSObject,Codable {
    public let id: String
    public let object: String
    public let owned_by: String
    public let permission: [OpenAIAPIPermission]
    public let root: String?
    public let parent: String?
}
@objc
public class OpenAIAPIPermission: NSObject,Codable {
    public let id: String
    public let object: String
    public let created: TimeInterval
    public let allow_create_engine: Bool
    public let allow_sampling: Bool
    public let allow_logprobs: Bool
    public let allow_search_indices: Bool
    public let allow_view: Bool
    public let allow_fine_tuning: Bool
    public let organization: String
    public let group: String?
    public let is_blocking: Bool
}

// Audio
@objc
public class OpenAIAPIAudioResponse:NSObject, Codable {
    public let text: String
}

// Errors
// https://platform.openai.com/docs/guides/error-codes/api-errors
@objc
public class OpenAIAPIErrorResponse: NSObject,Codable {
    public let error: OpenAIAPIError
    
    public struct OpenAIAPIError: Codable {
        public let message: String
        public let type: String
        public let param: String?
        public let code: String?
    }
}

// response formats
@objc
public enum OpenAIAPIResponseFormat : Int {
    case json
    case text
    case srt
    case verbose_json
    case vtt
    public var name: String {
        switch self {
        case .json:
            return String(describing: "json")
        case .srt:
            return String(describing: "srt")
        case .text:
            return String(describing: "text")
        case .verbose_json:
            return String(describing: "verbose_json")
        case .vtt:
            return String(describing: "vtt")

        }
        
    }
}
