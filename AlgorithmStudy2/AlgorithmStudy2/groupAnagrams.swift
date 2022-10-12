//
//  groupAnagrams.swift
//  AlgorithmStudy2
//
//  Created by Kai Kim on 2022/10/12.
//

import Foundation

func groupAnagrams(_ strs: [String]) -> [[String]] {
  
  var commons: [String: [String]] = [:]
  var res: [[String]] = []
  
  for string in strs {
    let sortedString = String(string.sorted())
    if var anagrams = commons[sortedString] {
      anagrams.append(string)
      commons[sortedString] = anagrams
    }else{
      commons.updateValue([string], forKey: sortedString)
    }
  }
  
  for item in commons {
    res.append(item.value)
  }
  
  var set: Set<[String]> = []
  set.max(by: {$0.count<$1.count})
  return res
}
