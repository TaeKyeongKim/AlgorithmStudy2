//
//  SetMatrix.swift
//  AlgorithmStudy2
//
//  Created by Kai Kim on 2022/10/11.
//

import Foundation

func setZeroes(_ matrix: inout [[Int]]) {
  
  var pos: [(Int,Int)] = [] //x,y
  
  for x in 0..<matrix.count {
    for y in 0..<matrix[x].count{
      if matrix[x][y] == 0 {
        pos.append((x,y))
      }
    }
  }
  
  for item in pos {
    matrix[item.0] = matrix[item.0].map{$0*0}
    for row in 0..<matrix.count {
      matrix[row][item.1] = 0
    }
  }
  
}
