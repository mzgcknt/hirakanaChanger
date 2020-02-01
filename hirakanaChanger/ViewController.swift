//
//  ViewController.swift
//  hirakanaChanger
//
//  Created by 溝口健太 on 2020/01/29.
//  Copyright © 2020 溝口健太. All rights reserved.
//

import UIKit
import TextFieldEffects

class ViewController: UIViewController, HiraganaApiMessageListener {
  @IBOutlet weak var convertedText: UITextView!
  @IBOutlet weak var convertField: KaedeTextField!
  @IBOutlet weak var errorText: UILabel!
  @IBOutlet weak var convertSwitcher: UISegmentedControl!
  // 選択中セグメント
  private var selectedIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  /// テキストフィールドの変換処理
  /// - Parameter sender: convertField
  @IBAction func convertFieldChanged(_ sender: Any) {
    // TODO: デフォルトでrequestIdは指定しないが、時間があれば設定できるようにする
    HiraganaApiProvider.initialize(selectedIndex: self.selectedIndex, listener: self).inquireRequestApi(sentence: self.convertField.text)
  }
  /// 出力種別の変更
  /// - Parameter sender: convertSwitcher
  @IBAction func segmentChanged(_ sender: Any) {
    self.selectedIndex = convertSwitcher.selectedSegmentIndex
  }
  
  // MARK: - HiraganaApiMessageListener
  /// ひらがなAPIのレスポンス値を受け取る
  /// - Parameter responseMessage: レスポンス
  /// - Parameter responseError: レスポンス時のエラー内容
  func onMessageListener(responseMessage: HiraganaApiResponse?, responseError: Error?) {
    // API側でエラーがあった場合はエラー文の表示
    if let error = responseError {
      self.errorText.text = "ネットワーク環境を確認してください"
    }
    self.convertedText.text = responseMessage?.Converted
  }
}

