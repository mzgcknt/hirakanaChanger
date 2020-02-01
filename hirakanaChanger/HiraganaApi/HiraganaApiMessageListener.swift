//
//  HiraganaApiMessageListener.swift
//  hirakanaChanger
//
//  Created by 溝口健太 on 2020/02/01.
//  Copyright © 2020 溝口健太. All rights reserved.
//

import Foundation

/// ひらがなAPIのメッセージイベントリスナー
protocol HiraganaApiMessageListener: class {
  func onMessageListener(responseMessage: HiraganaApiResponse?, responseError: Error?)
}
