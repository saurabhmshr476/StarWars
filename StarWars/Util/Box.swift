//
//  Box.swift
//  StarWars
//
//  Created by SaurabhMishra on 07/09/20.
//  Copyright © 2020 SaurabhMishra. All rights reserved.
//

import Foundation

final class Box<T> {
  //1
  typealias Listener = (T) -> Void
  var listener: Listener?
  //2
  var value: T {
    didSet {
      listener?(value)
    }
  }
  //3
  init(_ value: T) {
    self.value = value
  }
  //4
  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
