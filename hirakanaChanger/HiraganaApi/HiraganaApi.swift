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
  private let requestHeader: HTTPHeaders = ["Content-Type": "application/json"]
  private let apiListener: HiraganaApiListener
  
  init(apiListener: HiraganaApiListener) {
    self.apiListener = apiListener
  }
  
  /// ひらがなAPIの実行
  /// - Parameter request: リクエスト
  func requestApi(request: HiraganaApiRequest) {
    Alamofire.request(request.Url, method: self.method, parameters: request.Request, encoding: JSONEncoding.prettyPrinted, headers: self.requestHeader)
      .responseString(encoding: .utf8) { [apiListener] response in
//      参考: https://fromatom.hatenablog.com/entry/2016/01/27/125657
//      guard let `self` = self else {
//        return
//      }
        // クロージャ内ではselfのメンバ変数を使えるが、強参照してしまうためキャプチャリストで回避する
        apiListener.onResponse(response: HiraganaApiResponse.create(jsonText: response.result.value), responseError: response.result.error)
      }
  }
}
