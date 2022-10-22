//
//  CountandSay.swift
//  AlgorithmStudy2
//
//  Created by Kai Kim on 2022/10/15.
//

import Foundation

func countAndSay(_ n: Int) -> String {
  
  var str: String = ""
  //base case
  if n == 1 {
    return "1"
  }else {
    str += countAndSay(n-1)
    let count = counter(str)
    return stringConverter(count)
  }
}

func counter(_ str: String) -> [[Int]] {
  let first = str.index(str.startIndex, offsetBy: 0)
  var cnt = 1
  var res: [[Int]] = [[Int(String(str[first]))!,cnt]]
  
  for i in 0..<str.count-1 {
    let currIndex = str.index(str.startIndex, offsetBy: i)
    let nextIndex = str.index(str.startIndex, offsetBy: i+1)
    let element = String(str[currIndex])
    let nextElement = String(str[nextIndex])
    
    if res[res.count-1][0] != Int(nextElement)! {
      res.append([Int(nextElement)!,1])
    }
     if element == nextElement {
      cnt += 1
      res[res.count-1][1] = cnt
    }else{
      cnt = 1
    }

  }
   return res
}

func stringConverter(_ nums: [[Int]]) -> String {
  var str = ""
  for num in nums {
    for element in num.reversed() {
      str += String(element)
    }
  }
  return str
}
