//
//  Construct Binary Tree from Preorder and Inorder Traversal  .swift
//  AlgorithmStudy2
//
//  Created by Kai Kim on 2022/10/22.
//

import Foundation

public class TreeNode {
  public var val: Int
  public var left: TreeNode?
  public var right: TreeNode?
  public init() { self.val = 0; self.left = nil; self.right = nil; }
  public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
  public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
    self.val = val
    self.left = left
    self.right = right
  }
}


func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
    //baseCase
    guard let firstValue = preorder.first else {return nil}
    let root = TreeNode(firstValue)
    let midIndex = inorder.firstIndex(of:firstValue)!
    root.left = buildTree(Array(preorder[1..<(midIndex+1)]), Array(inorder[0..<midIndex]))
    root.right = buildTree(Array(preorder[(midIndex+1)...]), Array(inorder[(midIndex+1)...]))
  return root
}
