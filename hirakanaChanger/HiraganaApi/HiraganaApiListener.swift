//
//  HiraganaApiListener.swift
//  hirakanaChanger
//
//  Created by 溝口健太 on 2020/02/01.
//  Copyright © 2020 溝口健太. All rights reserved.
//

import Foundation

/// ひらがなAPIのイベントリスナー
protocol HiraganaApiListener: class {
  func onResponse(response: HiraganaApiResponse?, responseError: Error?)
}
