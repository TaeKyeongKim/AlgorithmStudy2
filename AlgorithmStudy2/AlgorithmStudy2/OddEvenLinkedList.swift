//
//  OddEvenLinkedList.swift
//  AlgorithmStudy2
//
//  Created by Kai Kim on 2022/10/17.
//

import Foundation

// Definition for singly-linked list.
public class ListNode {
  public var val: Int
  public var next: ListNode?
  public init() { self.val = 0; self.next = nil; }
  public init(_ val: Int) { self.val = val; self.next = nil; }
  public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}


func oddEvenList(_ head: ListNode?) -> ListNode? {
  // var res = head
  
  var oddList: ListNode? = ListNode()
  var oddNext = oddList
  
  var evenList: ListNode? = ListNode()
  var evenNext = evenList
  
  var curr = head
  var cnt = 1

  while curr != nil {
    
    if cnt % 2 == 1 {
      oddNext?.next = curr
      oddNext = oddNext?.next
    } else {
      //evenCase
      evenNext?.next = curr
      evenNext = evenNext?.next
    }
    curr = curr?.next
    cnt += 1
  }
  
  if evenNext?.next?.next == nil {
    evenNext?.next = nil
  }
  
  oddList = oddList?.next
  evenList = evenList?.next
  oddNext?.next = evenList
  
  return oddList
}
