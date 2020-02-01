//
//  HiraganaApiRequest.swift
//  hirakanaChanger
//
//  Created by 溝口健太 on 2020/01/30.
//  Copyright © 2020 溝口健太. All rights reserved.
//

import Foundation

/// ひらがなAPIのリクエストクラス
class HiraganaApiRequest {
  // アプリケーションID
  private let appId = "cd937bcbd35f1440033fab1ea9fcda79daca8d87801a4f2c6887e2b6b0504f10"
  private var requestId = ""
  private let sentence: String
  private let outputType: String
  // リクエストパラメータ
  private let requestParameter: [String:String]
  
  init(sentence: String, outputType: String) {
    self.sentence = sentence
    self.outputType = outputType
    self.requestParameter = [
      "app_id": self.appId,
      "sentence": self.sentence,
      "output_type": self.outputType
    ]
  }
  
  /// リクエストパラメータ群
  var Request: [String: String] {
    return self.requestParameter
  }
  
  /// リクエストIDを指定した場合のイニシャライザ
  /// - Parameters:
  ///   - requestId: リクエストID
  ///   - sentence: 解析対象テキスト
  ///   - outputType: 出力種別
  init(requestId: String, sentence: String, outputType: String) {
    self.requestId = requestId
    self.sentence = sentence
    self.outputType = outputType
    self.requestParameter = [
      "app_id": self.appId,
      "request_id": self.requestId,
      "sentence": self.sentence,
      "output_type": self.outputType
    ]
  }
}
