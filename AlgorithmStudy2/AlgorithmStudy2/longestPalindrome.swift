//
//  longestPalindrome.swift
//  AlgorithmStudy2
//
//  Created by Kai Kim on 2022/10/13.
//

import Foundation

func longestPalindrome(_ s: String) -> String {
  var left = 0
  var right = 0
  var resLen = 0
  let str = Array(s)
  var resLeft = 0
  var resRight = 0
  
  for i in 0..<str.count {
    (left,right) = (i,i)
    while (left >= 0 && right < str.count) && str[left] == str[right] {
      if (right - left + 1) > resLen {
        (resLeft,resRight) = (left,right)
        resLen = right - left
      }
      right += 1
      left -= 1
      
    }
    
    (left,right) = (i,i+1)
    while (left >= 0 && right < str.count) && str[left] == str[right] {
      if (right - left + 1) > resLen {
        (resLeft,resRight) = (left,right)
        resLen = right - left
      }
      right += 1
      left -= 1
    }
  }
  
  return String(str[resLeft...resRight])
}
