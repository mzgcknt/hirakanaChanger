//
//  ViewController.swift
//  hirakanaChanger
//
//  Created by 溝口健太 on 2020/01/29.
//  Copyright © 2020 溝口健太. All rights reserved.
//

import UIKit
import TextFieldEffects
import LTMorphingLabel

class ViewController: UIViewController, HiraganaApiMessageListener, UITextFieldDelegate {
  @IBOutlet weak var convertedText: UITextView!
  @IBOutlet weak var convertField: KaedeTextField!
  @IBOutlet weak var errorText: LTMorphingLabel!
  @IBOutlet weak var convertSwitcher: UISegmentedControl!
  @IBOutlet weak var clearTextButton: UIButton!
  
  // 選択中セグメント
  private var selectedIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.convertField.delegate = self
    self.errorText.morphingEffect = .fall
    self.customizeTextView()
  }
  
  /// エラー文の消去
  private func clearErrorText() {
    self.errorText.text = ""
  }
  /// IBで変更できなかった項目のカスタマイズ
  private func customizeTextView() {
    self.convertedText.layer.borderColor = UIColor.green.cgColor
    self.convertedText.layer.borderWidth = 1
    self.convertedText.layer.cornerRadius = 10
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
    HiraganaApiProvider.initialize(selectedIndex: self.selectedIndex, listener: self).inquireRequestApi(sentence: self.convertField.text)
  }
  /// 入力値の全消し処理
  /// - Parameter sender: clearTextButton
  @IBAction func clearAllTextView(_ sender: Any) {
    self.convertedText.text = ""
    self.convertField.text = ""
  }
  
  // MARK: - UITextFieldDelegate
  /// キーボードの決定ボタン押下時に、閉じる
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  /// テキストフィールド以外をタッチした際にキーボードを閉じる
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
  }
  // MARK: - HiraganaApiMessageListener
  /// ひらがなAPIのレスポンス値を受け取る
  /// - Parameter responseMessage: レスポンス
  /// - Parameter responseError: レスポンス時のエラー内容
  func onMessageListener(responseMessage: HiraganaApiResponse?, responseError: Error?) {
    // API側でエラーがあった場合はエラー文の表示
    if let _ = responseError {
      self.errorText.text = "ネットワーク環境を確認してください。"
    } else {
      self.clearErrorText()
    }
    self.convertedText.text = responseMessage?.Converted
  }
}

