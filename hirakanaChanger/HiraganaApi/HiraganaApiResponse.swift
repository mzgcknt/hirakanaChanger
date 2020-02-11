//
//  HiraganaApiResponse.swift
//  hirakanaChanger
//
//  Created by 溝口健太 on 2020/02/01.
//  Copyright © 2020 溝口健太. All rights reserved.
//

import Foundation

/// ひらがなAPIのレスポンスクラス
class HiraganaApiResponse: Codable {
  private let converted: String?
  private let outputType: String?
  private let requestId: String?
  
  var Converted: String? {
    return self.converted
  }
  
  /// デコード処理の隠蔽用
  /// - Parameter jsonText: デコード対象文字列
  static func create(jsonText: String?) -> HiraganaApiResponse? {
    guard let jsonText = jsonText else { return nil }
    return fromJson(jsonText: jsonText)
  }
  /// JSONのデコード処理
  /// - Parameter jsonText: デコード対象文字列
  static func fromJson(jsonText: String) -> HiraganaApiResponse? {
    guard let jsonTextData = jsonText.data(using: .utf8) else { return nil }
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    // camelCase → snake_case
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    if let decodeJSON = try? decoder.decode(self, from: jsonTextData){
      return decodeJSON
    }
      return nil
    }
}
