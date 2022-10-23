//
//    Kth Smallest Element in a BST  .swift
//  AlgorithmStudy2
//
//  Created by Kai Kim on 2022/10/23.
//

import Foundation

func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        
        var stack:[TreeNode?] = []
        var pointer = root
        var sortedValueList: [Int] = []
        
        while pointer != nil || !stack.isEmpty {
            
            //Traverse To deapest leftNode
            while pointer != nil {
                stack.append(pointer)
                pointer = pointer?.left
            }
            
            //PopStacks
            if let node = stack.popLast() {
                sortedValueList.append(node!.val)
                pointer = node?.right
            }
        }
        
        return sortedValueList[k-1]
    }
