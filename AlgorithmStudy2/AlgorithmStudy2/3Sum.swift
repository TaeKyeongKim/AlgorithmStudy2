//
//  3Sum.swift
//  AlgorithmStudy2
//
//  Created by Kai Kim on 2022/10/11.
//

import Foundation

func threeSum(_ nums: [Int]) -> [[Int]] {
  
  //  var res: Set<[Int]> = []
  //  let sortedArr = nums.sorted(by: <)
  //
  //  //Brute Force
  //  for index in 0..<sortedArr.count-1 {
  //    let target = sortedArr[index]
  //
  //    for j in index+1..<nums.count {
  //      var temp: [Int] = [target]
  //
  //      for k in j..<nums.count {
  //        if k == j {continue}
  //        let value = sortedArr[j]+sortedArr[k]
  //        if value + target == 0 && !temp.isEmpty {
  //          temp.append(sortedArr[j])
  //          temp.append(sortedArr[k])
  //          res.insert(temp)
  //          temp.removeAll()
  //     }
  //    }
  //   }
  //  }
  //  return Array(res)
  
  //Using Hash
    var res: Set<[Int]> = []
    let sortedArr = nums.sorted(by: <) //for reducing duplicate combination
    //why Am I sorting?
    //why Am I using Set for res?
  
  
    for index in 0..<sortedArr.count-1 {
      let target = sortedArr[index]
      var dict: [Int:Int] = [:]
      //why declare dict here?
  
      for j in index+1..<sortedArr.count {
        var temp: [Int] = [target]
  
  
        if let matchedValue = dict[sortedArr[j]] {
          temp.append(sortedArr[matchedValue])
          temp.append(sortedArr[j])
          res.insert(temp)
        } else {
          dict.updateValue(j, forKey: -1 * (target + sortedArr[j]))
        }
  
      }
    }
  
  return Array(res)
}
