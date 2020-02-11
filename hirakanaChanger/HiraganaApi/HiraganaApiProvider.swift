//
//  HiraganaApiProvider.swift
//  hirakanaChanger
//
//  Created by 溝口健太 on 2020/01/30.
//  Copyright © 2020 溝口健太. All rights reserved.
//

import Foundation

/// ひらがなAPIの管理クラス
class HiraganaApiProvider: HiraganaApiListener {
  private let selectedIndex: Int
  private let responseMessageListener: HiraganaApiMessageListener
  
  /// 出力種別
  enum OutputType: Int {
    case hiragana = 0
    case katakana = 1
  }
  
  init(selectedIndex: Int, listener: HiraganaApiMessageListener) {
    self.selectedIndex = selectedIndex
    self.responseMessageListener = listener
  }
  
  /// 変換する日本語がひらがなか判定処理
  private func isSelectedHiragana() -> Bool {
    return self.selectedIndex == OutputType.hiragana.rawValue
  }
  /// 出力種別の判定処理
  private func getOutputType() -> String {
    return self.isSelectedHiragana() ? "hiragana":"katakana"
  }
  /// ひらがなAPIの問合せ
  /// - Parameter sentence: テキストフィールドに入力されたテキスト
  /// - Parameter requestId: デフォルト値はnil
  func inquireRequestApi(sentence: String?, requestId: String? = nil) {
    // リクエストボディの型に合わせるためアンラップ
    guard let sentence = sentence else { return }
    if let requestId = requestId {
      HiraganaApi(apiListener: self).requestApi(request: HiraganaApiRequest(requestId: requestId, sentence: sentence, outputType: self.getOutputType()))
    } else {
      HiraganaApi(apiListener: self).requestApi(request: HiraganaApiRequest(sentence: sentence, outputType: self.getOutputType()))
    }
  }
  
  // MARK: - HiraganaApiListener
  /// ひらがなAPI実行結果の受け取り
  /// - Parameter response: レスポンス
  /// - Parameter responseError: レスポンス時のエラー内容
  func onResponse(response: HiraganaApiResponse?, responseError: Error?) {
    self.responseMessageListener.onMessageListener(responseMessage: response, responseError: responseError)
  }
}
