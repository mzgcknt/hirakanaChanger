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
  private let outputType: String
  private let responseMessageListener: HiraganaApiMessageListener
  
  private init(outputType: String, listener: HiraganaApiMessageListener) {
    self.outputType = outputType
    self.responseMessageListener = listener
  }
  
  /// インスタンス作成前に出力種別の判定処理
  /// - Parameter selectedIndex: 選択中インデックス
  /// - Parameter listener: メッセージイベントリスナー
  static func initialize(selectedIndex: Int, listener: HiraganaApiMessageListener) -> HiraganaApiProvider {
    let outputType = (selectedIndex == 0) ? "hiragana":"katakana"
    return HiraganaApiProvider(outputType: outputType, listener:listener)
  }
  /// ひらがなAPIの問合せ
  /// - Parameter sentence: テキストフィールドに入力されたテキスト
  /// - Parameter requestId: デフォルト値はnil
  func inquireRequestApi(sentence: String?, requestId: String? = nil) {
    // リクエストボディの型に合わせるためアンラップ
    guard let sentence = sentence else { return }
    if let requestId = requestId {
      HiraganaApi(apiListener: self).requestApi(request: HiraganaApiRequest(requestId: requestId, sentence: sentence, outputType: self.outputType))
    } else {
      HiraganaApi(apiListener: self).requestApi(request: HiraganaApiRequest(sentence: sentence, outputType: self.outputType))
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
