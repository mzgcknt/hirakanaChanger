//
//  HiraganaApi.swift
//  hirakanaChanger
//
//  Created by 溝口健太 on 2020/01/30.
//  Copyright © 2020 溝口健太. All rights reserved.
//

import Foundation
import Alamofire

/// ひらがなAPI実行クラス
class HiraganaApi {
  // POSTしか使えないため
  private let method: HTTPMethod = .post
  private let requestUrl = "https://labs.goo.ne.jp/api/hiragana"
  private let requestHeader: HTTPHeaders = ["Content-Type": "application/json"]
  private let apiListener: HiraganaApiListener
  
  init(apiListener: HiraganaApiListener) {
    self.apiListener = apiListener
  }
  
  /// ひらがなAPIの実行
  /// - Parameter request: リクエスト
  func requestApi(request: HiraganaApiRequest) {
    Alamofire.request(self.requestUrl, method: self.method, parameters: request.Request, encoding: JSONEncoding.prettyPrinted, headers: self.requestHeader)
      .responseString(encoding: .utf8) { response in
        self.apiListener.onResponse(response: HiraganaApiResponse.create(jsonText: response.result.value), responseError: response.result.error)
      }
    }
}
