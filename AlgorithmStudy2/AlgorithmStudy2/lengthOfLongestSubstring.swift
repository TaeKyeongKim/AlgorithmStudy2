//
//  lengthOfLongestSubstring.swift
//  AlgorithmStudy2
//
//  Created by Kai Kim on 2022/10/12.
//

import Foundation

func lengthOfLongestSubstring(_ s: String) -> Int {
  
  var set: Set<[String]> = []
  var acc: [String] = []
  
  for char in s {
    if let index = acc.firstIndex(of: String(char)){
      acc.removeSubrange(0...index)
    }
    acc.append(String(char))
    set.insert(Array(Set(acc)))
  }
  return set.max(by: {$0.count<$1.count})?.count ?? 0
}
