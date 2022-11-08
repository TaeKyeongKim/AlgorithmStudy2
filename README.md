
## LeetCode 의 Top Interview Questions 에 기재되어 있는 [Medium 문제](https://leetcode.com/explore/interview/card/top-interview-questions-medium/103/array-and-strings/776/) 들을 풀어보자.

---
## Arrays and Strings

<details> 
  <summary> 1.0 3Sum </summary> 
  
  > 고민 
  - brute force 말고 다른 방법 을 찾아보자
  
  
  > 해결
  ### Intuition
<!-- Describe your first thoughts on how to solve this problem. -->
As given hint, once you designate the `Target` value that will be summed up to 0 with other two values, you can use dictionary to solve the problem. 

### Approach
<!-- Describe your approach to solving the problem. -->

1.0 Sort the given array. Once you sort the array, you won't have to deal with same sum of 3 values with different permutations. You are only interested in getting the `combination of sum`. 

Example) Given [-1,0,1,2,-1,4]

- Possible outcome = [-1,0,1], [-1,2,-1] ,[0,1,1] 
- You are `not interested` in the `sequence`, but the combination of integer, so you must only get  [-1,0,1] or [0,1,1] depending on how you sort the array.
- Sort the array in ascending order, it becomes ->  [-4,-1,-1,0,1,2]
- The following result would be = [-1,-1,2],[-1,0,1],[-1,0,1] and the duplicate combinations can be omitted using `Set`

2.0 Declare `Set<[Int]>` to prevent from getting duplicate combination of sum as shown in the example above.

3.0 Iterate through the array until `index` reaches up to right below `nums.count-1`. This way you dont have to examine the last two elements since you are only interested in sum of 3. 

4.0 Create innerloop that iterates from `index+1` until right below `nums.count`. Here you would update dictionary with `-(Target + sortedArray[j])` for key, and j as the value. 

5.0 if you find matchingValue with respect to the existing key of dictionary, record the indexes in the result. 



### Complexity
- Time complexity: `O(n^2)`
<!-- Add your time complexity here, e.g. $$O(n)$$ -->

- Space complexity: `O(n^2)`
<!-- Add your space complexity here, e.g. $$O(n)$$ -->

### Code

```swift 
class Solution {
    
  func threeSum(_ nums: [Int]) -> [[Int]] {
  
      var res: Set<[Int]> = []
      let sortedArr = nums.sorted(by: <) 
       
      for index in 0..<sortedArr.count-1 {
          let target = sortedArr[index]
          var dict: [Int:Int] = [:]
        for j in index+1..<sortedArr.count {  
          var temp: [Int] = [target]
          if let matchedValueIndex = dict[sortedArr[j]] { 
            temp.append(sortedArr[matchedValueIndex])
            temp.append(sortedArr[j])
            res.insert(temp)
          } else {
            dict.updateValue(j, forKey: -1 * (target + sortedArr[j])) 
          } 
            
        }
      }
      
    return Array(res)
   }
}
```
  
</details>

<details>
  <summary> 2.0 Set Matrix Zeros </summary>
  
  > 고민 
  - 어떤 자료구조를 사용해서 간단히 문제를 풀수있을지 고민.
  
  > 해결
  - 튜플을 이용, 요소가 0인 좌표 (x,y) 를 기록하여 문제 해결
  
  > 결과
  ```swift 
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
  ```
  - Time complexity: `O(n*m)`
<!-- Add your time complexity here, e.g. $$O(n)$$ -->

- Space complexity: `O(n+m)`
<!-- Add your space complexity here, e.g. $$O(n)$$ -->
</details>


<details>
    <summary> 3.0 Group Anagrams </summary>
    
   > 고민 
   - 어떻게 다른 글자를 가지고 있는지 확인해줄까? 
   - 어떻게 같은 요소를 포함하고 있는애들끼리만 묶어줄까? 

   > 해결 
   - 각 String 에 Sort 를 사용하면 같은 문자를 포함하고 있는 요소와 아닌요소를 나눌수 있었다. 
   - 그 후 `Dictionary` 의 키값으로 다른 순서로 섞여있는 문자들을 구별하기 위하여 sorted 된 형태의 문자를 key 값으로 두고 value 로 각기 다른 순서로 구성된 문자들을 묶어두기 위해서 `[String]` 을 할당해주었다. 
    - 주어진 `strs` 를 순회하여 각 딕셔너리를 채워준뒤에 마지막으로 각 value 를 `res` 에 `append` 해줌으로 문제를 해결할수 있었다. 
    
   > 결과 
  
  ```swift 
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

    return res
  }
  ```
  
  - Time complexity: `O(n)`
<!-- Add your time complexity here, e.g. $$O(n)$$ -->

  - Space complexity: `O(n)`
<!-- Add your space complexity here, e.g. $$O(n)$$ -->

  </details>

<details> 
  <summary> 4.0 Longest Substring Without Repeating Characters </summary>
  
 > 고민 
 - 처음엔 이번에 들어온 string 요소가 이미 array 에 있다면 array 를 다 비우고 새로 시작하는 로직으로 작성하다 `removeSubrange` 를 사용해서 문제를 해결.
  
  
### Intuition
<!-- Describe your first thoughts on how to solve this problem. -->
Iterate through the given string and if there duplicated element found, update array that keep tracks of the current substring. 



### Approach
<!-- Describe your approach to solving the problem. -->
- Keypoint is to slice array by using `removeSubrange` 
- `array` is used to keep tracks of current substring.
- `set` is used to store traces of `array` 

![image.png](https://assets.leetcode.com/users/images/9327b146-8f1d-410a-a822-dbb022bf143d_1665562097.4361033.png)

### Complexity
- Time complexity: `O(n)`
<!-- Add your time complexity here, e.g. $$O(n)$$ -->

- Space complexity: `O(n)`
<!-- Add your space complexity here, e.g. $$O(n)$$ -->

### Code
```swift 
class Solution {
    
   func lengthOfLongestSubstring(_ s: String) -> Int {
  
      var set: Set<[String]> = []
      var curr: [String] = []

      for char in s {
        if let duplicatedIndex = curr.firstIndex(of: String(char))
        {
          curr.removeSubrange(0...duplicatedIndex)
        }
        curr.append(String(char))
        set.insert(curr)
      }
      return set.max(by: {$0.count<$1.count})?.count ?? 0
    }
}
```
</details>

<details>

 - 혼자sol? -> ❌
 <summary> 5.0 Longest Palindromic Substring </summary>
 
 > 고민
 - palindrome 이면 중복된 요소가 있는 인덱스마다 string 을 slice 해서 palindrome 여부를 판별하면 되겠다는 생각을 했다.
 - 하지만 아래와 같은 문제가 생겨 해메다 문제를 해결하지 못함.
 ex) "aacab" 일때, aac 까지 확인후 그다음 요소인 a 가 왔을때 aaca 와 aca 를 비교해야하는데 이방법은 time complexity 를 O(n^3) 가 되므로 패스하지 못함. 
 
 > 해결
 - 요소하나하나를 검사할때마다, 가운데 요소부터 양끝으로 뻗어가는 pointer (left, right) 를 생성하여 요소가 같은지 확인.
 - 이때 중요한것은 palindrome 의 길이가 odd, even 일때 를 생각해야한다는것이다. 
 <img width="835" alt="image" src="https://user-images.githubusercontent.com/36659877/195517073-f1b96583-b957-49a8-8547-6fc12c8662d5.png">

 > 결과 
 
 ```swift 
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
        (resLeft,resRight) = (left,right) // 여기서 res = str[left...right] 를 할당하게되면 On^3 의 시간복잡도가 발생하므로, resLeft, resRight 에 일단 저장해둠.
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
```

- Time Complexity = `O(n^2)`

- Space Complexity = `O(1)`
 
</details>

<details> 
   <summary> 6.0 Increasing Triplet </summary> 
   
   > 고민 
   - 1부터 시작해서 왼쪽 < 가운데 < 오른쪽 이면 true 를 반환 하는 함수를 작성해봤는데, 3개가 꼭 연속으로 붙어 있어야한다는 제약조건이 없었기때문에 실패했다. 
   - 따라서 왼쪽, 오른쪽 요소를 검사하는 로직은 그대로 가져가되, lower, high bound 안에 middle 값이 존재해하는 로직을 파기 시작했다. 
   
   
   > 해결 
   
   ### 시도1
   - 1부터 요소 검사를 시작하여 left 값과 right 값이 유효할시 low, high bound 를 업데이트 시켜준다. 
   - left 와 right 가 현재 curr 값과 같은 값이 아니라면, prevMid 값을 업데이트 해준다. prevMid 는 high bound 가 업데이트 됐을시에, 이전의 middle 값을 넣어주어 유효한 triplet 인지 확인하는 용도때문에 할당해주었다. 
 
 ```swift 
   func increasingTriplet(_ nums: [Int]) -> Bool {
        
        if nums.count < 3 {return false}
        var low = nums[0]
        var high = Int.min
        var prevMid = 0

        for i in 1..<nums.count-1{ 
            let curr = nums[i]
            let left = nums[i-1]
            let right = nums[i+1]

            //Update left
            if curr > left {
                low = left
            }

            //Update right
            if curr < right {
                high = right   
            }

            if ((low < prevMid && high > prevMid) || (low < curr && high > curr)) {
                return true 
            }     
            
            if curr != right && curr != left {
                prevMid = curr    
            }

        }

       return false
    }
```  
- Time Complexity = `O(n)`

- Space Complexity = `O(n)`

  ### 시도2
  - 1.0 lower, upper 값을 max 로 잡는다. 
  - 2.0 주어진 배열을 순회 하면서 현재 값이 lower,upper 값 보다 같거나 작을시에 lower 값 upper 값을 순서대로 업데이트 시켜준다. 
  - 3.0 만약 숫자가 lower 보다 크고, upper 보다 작을시에 true 를 반환 해준다. 
  - 4.0 모든 요소를 순회 했는데도 불구하고 함수종료가 안되었다는 뜻은, lower, upper Range 사이에 값이 존재하지 않았다는 뜻이므로 false 를 반환해준다. 
   
```swift
   func increasingTriplet(_ nums: [Int]) -> Bool {
        var lower = Int.max, upper = Int.max
        for num in nums {
            if num <= lower {
                lower = num
            } else if num <= upper {
                upper = num
            } else {
                return true
            } 
        }
        return false
    }
```  
  
- Time Complexity = `O(n)`

- Space Complexity = `O(1)`

</details>

<details> 

   <summary> 7.0 Count and Say </summary>
    
   > 고민 
    
   - 문제를 보고 이해하지 못해서 힌트를 보고 해결했다. 
   - 내가 이해한 정도는 이전 수의 각자리수마다 연속으로 중복되는 요소를 카운트 하여 string 값으로 반환하는 작업을 n 번 반복하는 함수를 작성하는 것이였다. 

   > 해결
    
   ```swift 
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
  
  ```
  
  - Time Complexity = `O(n^2)`

  - Space Complexity = `O(n)`
  
</details>

---- 

## Linked List 

<details> 
  <summary> 1.0 Add Two Numbers </summary>
  
  > 고민 
  - 어떻게 새로운 노느들 리스트의 마지막 노드에 계속 이어줘야할지 고민 했다. 
  
  
  > 해결
  - 새로운 ListNode 의 마지막 노드를 tracking 하고 새로운 노드를 이어줄 변수를 만들었다. 
  - 이변수(`resNext`) 는 `res` listNode 를 참조하고 있고 `resNext = resNext.next` 를 while loop 에서 선언해주어 리스트 맨끝의 노드를 가르킬수 있도록 구현해주었다. 
  
  > 결과 
  
  ```swift 
  func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        var carry = 0 
        var curr1 = l1
        var curr2 = l2
        var res: ListNode? = ListNode()
        var resNext = res
        
        while (curr1 != nil || curr2 != nil) { 
            var sum = (curr1?.val ?? 0) + (curr2?.val ?? 0) + carry
            carry = sum/10
            
            if sum >= 10 { 
                sum = sum - 10
            }
            
            curr1 = curr1?.next
            curr2 = curr2?.next 
            resNext?.next = ListNode(sum)
            resNext = resNext?.next
        }
        
        if carry == 1 { 
            resNext?.next = ListNode(carry)
        }
            //Trim off the first 0 Listnode
            res = res?.next
        
        return res
    }
    
  ```
 
  - Time Complexity = `O(n)`

  - Space Complexity = `O(n)`

 </details>

 <details> 
    <summary> 2.0 Odd Even Linked List </summary> 
    
   > 고민 
   - 홀수번째 있는 노드와 짝수번째 있는 노드를 어떻게 분리시킬지 고민 했다. 
    
   > 해결 
   - 이전번 문제와 똑같은 방법으로, 홀수, 짝수 번째 노드를 저장시킬 변수를 만들어서 리스트 끝에 이어주는 형식으로 문제 해결 
    
  ```swift 
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
  ```
  
  ```swift 
  //더 간단히 푸는 방법 
     func oddEvenList(_ head: ListNode?) -> ListNode? {
        var odd = head
        var even = odd?.next
        
        var evenHead = even
        var oddHead = odd
        
        while even?.next != nil {
            odd?.next = even?.next
            odd = odd?.next
            
            even?.next = odd?.next
            even = even?.next
        }
        
        odd?.next = evenHead
        
        return oddHead
    }
  ```
    
  - Time Complexity = `O(n)`
  
  - Space Complexity = `O(1)`
    
 </details>


 <details> 
    <summary> 3.0 Intersection of Two Linked Lists </summary>
   
  - 혼자sol? -> ❌
  
  > 고민 
  - 각각 길이가 다른 리스트의 중 Intersect 하는 노드를 어떻게 찾을지 고민함. 
  - 리스트를 reverse 해서 풀어보려했으나 기존리스트의 순서를 바꾸면 안되므로 pass.
  
  > 해결
  - 각각 리스트의 길이를 세어 길이의 차만큼 offset 을 주어서 list 를 순회하는 방법으로 문제를 해결해도 되지만, count 하는과정의 시간이 오래걸림.
  - 각각의 리스트를 순회할때 nil 값이 오면, 다른 리스트의 첫부분으로 가서 문제를 해결하는 방법이 있었다. 
  - 이렇게해서 둘의 리스트를 한번씩 순회하면 길이의 상관없이 각각 검사되는 요소의 순서가 일치해 지므로 문제 해결!. 
  [참조](https://www.youtube.com/watch?v=D0X0BONOQhI)
   
  > 결과 
  
  ```swift
  func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        
        var head1 = headA
        var head2 = headB
        
        while head1 !== head2 {
            head1 = head1 == nil ? headB : head1?.next
            head2 = head2 == nil ? headA : head2?.next
        }

        return head1
    }
  ```
  
  - Time Complexity = `O(n+m)`
  
  - Space Complexity = `O(1)`
    
  
 </details>
 
 ----
 
 ## Trees and Graphs
 
 <details>
     <summary> 1.0 Binary Tree Inorder Traversal </summary>
     
   > 고민 
   - Binary Tree 를 Inorder Traversal 하는 방법을 한번도 풀어보지 못해서 처음에 개념을 좀 찾아보고 코드로 구현하려고 했다. 
   - Inorder Traversal 은 Tree 를 검색하는 하나의 DFS 방법으로 왼쪽 가장 깊은 노드에서부터 오른쪽 방향으로 진행되는 방법이다. 
   - 처음 개념을 파악하고 나서 왼쪽 노드로 뻗어가는과정중에 오른쪽 노드가 있는지 파악 해야하나? 라는 고민을 했었지만 결과적으로는 아니였다. (여기서 시간을 엄청 잡아먹음) 
   - 한 2시간넘게 잘못된생각으로 문제를 풀려고 했었는데 솔직히 문제를 풀면서도 확신이 들지 않았었다. 다음부터는 시간이 꽤 지나는데도 내생각에 확신이 들지 않는다면 가능한 빨리  문제를 어떻게 접근해야하는지 다시 살펴볼 필요가 있다고 생각한다. 
     
   > 해결 
   - 0.0 pointer 를 root 로 향하게 한다.
   - 1.0 pointer 의 왼쪽 Child node 가 nil 이 될때 까지 쭉 pointer 를 이동시키며 Stack 에 저장한다. 
   - 2.0 Stack 제일 위에 있는 node 를 pop 해주고 res 에 append 한다. 
   - 3.0 pointer 를 pop 된 node 의 오른쪽 요소로 향하게 하고 1.0,2.0 을 되풀이 한다. 
   - 4.0 이 과정을 Pointer 가 nil, stack 이 empty 가 될때까지 반복한다. 
     
  <img width="1599" alt="image" src="https://user-images.githubusercontent.com/36659877/196602000-89c2e9cb-ac36-42dd-a045-1c4430483fd2.png">
    
   ```swift 
   func inorderTraversal(_ root: TreeNode?) -> [Int] {
    var res: [Int] = []
    var pointer = root
    var stack: [TreeNode] = []
    
    //Pointer 가 nil, stack 이 empty 가 될때까지
    while pointer != nil || !stack.isEmpty {
      
      //LeftNode Traversal 
      while pointer != nil {
         stack.append(pointer!) 
         pointer = pointer?.next
      }
      
      let lastNode = stack.removeLast() 
      res.append(lastNode.val) 
      pointer = lastNode.right
    }
    return res
   }
   ```
      
 - Time Complexity = `O(n)`
  
 - Space Complexity = `O(n)` 
 </details>
 
 
 <details> 
   <summary> 2.0 Binary Tree Zigzag Level Order Traversal </summary> 
    
   > 고민 
   - 어떻게 하나의 level 씩 노드를 검색할수 있을까? 
   - 어떻게 방향을 제어 할수 있을까? 
    
   > 해결 
   - BFS(하나의 level 씩 검색하는 방법) 를 사용해서 문제를 해결하는 방법을 저번에 한번 구현한적이 있었는데 생각이 잘 나지 않아서 다시 보고 익히는 연습을 했다. 
   - 각 level 이 읽어지는 방향이 달라지면서 노드값 또한 결과 배열에 정리 시켜놔야하는데 이부분에서 많이 고민 했다. Stack 과 Queue 를 같이 사용할지, 아니면 다른 방법이 있을지 생각 고민했다. 
   - 그 결과 루트 에서부터 오른쪽 에서 왼쪽 방향으로 읽는다고 생각하여 읽는 방향이 왼쪽에서 오른쪽 일경우 Queue 에 들어 있던 요소들을 배열에 넣은다음 reversed 해주어 문제를 해결했다.
       
   ![image](https://user-images.githubusercontent.com/36659877/196968613-c284d1bd-0a99-4bb1-96d9-14ba2de26e19.png)

   ![image](https://user-images.githubusercontent.com/36659877/196968663-162d864f-6479-47d5-bff6-437f8df56318.png)
     
   > 결과 
   ```swift 
   class Queue { 
    
    private var queue: [TreeNode?] = []
    private var head: Int = 0

    var count: Int {
      return queue.count - head 
    } 

    var isEmpty: Bool { 
      return self.count == 0 
    }

    func enqueue(_ val: TreeNode?) {
        guard let newNode = val else {return}
        queue.append(newNode)
    }

    func dequeue() -> TreeNode? { 
        guard head < queue.count, let node = queue[head] else {return nil}
        queue[head] = nil
        head += 1
        return node
    } 

   }
    
   func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {

      var queue = Queue() 
      var res: [[Int]] = []
      var curr = root
      var leftToRight = false 
      queue.enqueue(curr)
        
      while (!queue.isEmpty) {
          var level: [Int] = [] 
          var count = queue.count - 1 

          while (count >= 0) { 
              if let node = queue.dequeue() {
                   level.append(node.val)
                   count -= 1
                   queue.enqueue(node.left)    
                   queue.enqueue(node.right)
              }
                
          }
       
          if leftToRight {
                level = level.reversed()
          }
            
          leftToRight = !leftToRight
          res.append(level)
      }

      return res
   }
   ```
    
   - Time Complexity = `O(n+E)` where E = Number of nodes per level
    
   - Space Complexity = `O(n+E)` 
 </details> 

 <details> 
   <summary> 3.0 Construct Binary Tree from Preorder and Inorder Traversal </summary> 
   
   > 고민 
   - preorder 와 inorder 리스트를 만들때 사용되었던 Binary Tree 를 생성하야하는데, 어떻게 preorder 와 inorder 리스트 들이 만들어지는지 알아봐야겠다. 

### Preorder (전위 순회) 방식 

![image](https://user-images.githubusercontent.com/36659877/197224781-95b32994-592d-48f4-88fb-3c416128e35f.png)
   
 - 순회 순서 => Root, Left, Right
 -> F > B > A > D > C > E > G > I > H 

### Preorder (전위 순회) 방식 

 ![image](https://user-images.githubusercontent.com/36659877/197229986-4f49811c-90cb-45ed-8d71-dcf4584b630b.png)

 - 순회 순서 => Left, Root, Right
 -> A > B > C > D > E > F > G > H > I
 
 - 두 방식의 공통점은 subTree 하나의 끝이 나올때까지 순회를 계속 하는 DFS 방식이다. 
 - 두방식의 다른점은 처음 2개의 요소를 탐색하는 순서인데, root/left 를 먼저 탐색하냐에 있다. 
 - 정확히 어떤 패턴을 사용해서 문제를 해결해야할지 몰라서 두개의 배열을 나열해보고 하나씩 요소를 제거 해봤고, 아래와 같은 생각을 이끌어 낼수 있었다. 

 
  > - Preorder 배열의 첫 요소는 Binary Tree 의 시작점의 값을 알려주기 때문에, preorder 배열의 요소를 하나씩 BinaryTree Node 로 생성한다음, 어떤 순서로 연결해줄지를 inorder 배열을 통해서 유출해냈다. 
  > - 또한 첫번째 요소를 기준으로 왼쪽 요소들은 Left SubTree 인것을 알수 있고, 오른쪽 요소들은 Right SubTree 인것을 유출해 낼수 있었다. 
  > 그리고 아래와 같은 방식으로 Binary Tree 를 완성해갔다. 
  
![image](https://user-images.githubusercontent.com/36659877/197249222-174d8fc4-b1ec-4ca7-9bf2-0f96634d9c38.png)
![image](https://user-images.githubusercontent.com/36659877/197250061-8a919182-59da-42ba-9d3d-65ee5f283635.png)
![image](https://user-images.githubusercontent.com/36659877/197250089-32646a4a-6651-4967-8794-09022034f90a.png)


> 해결
- 위에서 고민했던방법을 구현하는데에 있어서 어려움을 겪었다. 결국 혼자서 문제를 해결 하지는 못했고, Recursive 하게 문제를 해결하는 방법을 참조 하여 해결 하였다. 

```swift 
func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
    //baseCase
    guard let firstValue = preorder.first else {return nil}
    let root = TreeNode(firstValue)
    let midIndex = inorder.firstIndex(of:firstValue)!
    root.left = buildTree(Array(preorder[1..<(midIndex+1)]), Array(inorder[0..<midIndex]))
    root.right = buildTree(Array(preorder[(midIndex+1)...]), Array(inorder[(midIndex+1)...]))
  return root
}
```

- Time Complexity = `O(n)`
    
- Space Complexity = `O(n)` 

 </details>

<details>
  <summary> 4.0 Populating Next Right Pointers in Each Node </summary>
  
  > 고민 
  - 문제를 보고 각 레벨을 순회하면서 문제를 해결할수 있겠다고 생각함. 
  
  > 해결
  - 큐를 사용해서 BFS 를 구현하여 문제를 해결했다. 
  
  > 결과 
  
  ```swift
  class Queue {
    
    private var queue:[Node?] = [] 
    private var head = 0 
    
    subscript(index: Int) -> Node? {
        return queue[index]
    }
    
    var first: Node?{
      return queue[head]  
    } 
    
    var count: Int {
      return queue.count - head  
    } 
    
    var isEmpty: Bool {
        return self.count == 0
    }
    
    func enqueue(_ node: Node?) {
        queue.append(node)
    }
    
    func dequeue() -> Node? { 
        guard head < queue.count, let node = queue[head] else {return nil}
        queue[head] = nil
        head += 1
        return node
    }
    
  }
                                 
  func connect(_ root: Node?) -> Node? {
        guard let root = root else {return nil}
        var queue = Queue()
        queue.enqueue(root)
        
        while !queue.isEmpty {
            
            var cnt = queue.count-1
            while cnt >= 0 {

                let node = queue.dequeue()
                if cnt == 0 {
                    node?.next = nil
                }else{
                    node?.next = queue.first
                }
                if let left = node?.left {queue.enqueue(left)}
                if let right = node?.right {queue.enqueue(right)}
                cnt -= 1
            }

        }
        
        return root
    }
  ```
  
 - Time Complexity = `O(n)`
    
 - Space Complexity = `O(1)` 
  
</details>
   
<details>
  <summary> 5.0 Kth Smallest Element in a BST </summary>
  
  > 고민 
  - 트리에 주어진 값들을 어떻게 하면 sort 할수 있을까?
  
  > 해결 
  - BST 를 inorder 방식으로 순회하며 각각의 값을 배열에 넣어주면 ascending order 로 배열이 나열될것이다. 
  
  > 결과 
  
  ```swift 
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
  ```
  - Time Complexity = `O(n)`
    
  - Space Complexity = `O(1)`

</details>

<details> 
  <summary> 6.0 Number of Islands </summary>
  
  > 고민 
  - 직관적으로 생각했을때는 문제를 아래와 같이 해결할수 있을것같다고 생각했다. 
  
  ![image](https://user-images.githubusercontent.com/36659877/197436086-53feac5c-f6ee-4727-b4c2-7884a270fe0f.png)

  - 왼쪽 위 부터 시작해서 1 과 연결되어 있는 1 들의 묶음으로 island 만들고, 만들어진 island 의 가장 오른쪽 위의 index 부터 시작하여 1 이 나올때까지 배열을 순회하는것이다. 
  - 이때 0 이 아니 1을 만났을때 또 다른 island 의 묶음을 만드는 것이다. 
  - 하지만 이를 구현하는 방법에서 막혔는데 2가지 문제가 있었다. 
  - 1.0 어떻게 현재 1과 연결되어 있는 모든 1을 찾지? 
  - 2.0 어떻게 이미 방문한 요소를 표시할수 있을까? 
  
  > 해결 
  - 1과 연결되어 있는 오른쪽,아래 방향을 검사해서 1인경우 연속해서 연결되어 있는 1을 찾을수 있다. (하나의 완성된 섬을 찾기 위해서)
  - 여기서 중요한점은 연결되어 있는 1이 방문이 됐다는것을 표기해야한다. 
  - 첫번째 1과 연결된 좌표는 (0,1), (1,0) 이다. 
  - (0,1)과 (1,0) 에 연결되어 있는 1의 좌표는 (0,2),(1,1),(2,0) 인데 (1,1) 이 중복된것을 확인할수있고 두번 확인 할필요가 없어진다. 
  - 이렇게 중복된 요소의 방문을 피할수 있는 방법은 BFS 방법을 이용해서 1이 있는곳을 체크하는것이다. 
  ![image](https://user-images.githubusercontent.com/36659877/197437731-4129553a-496c-42f5-a311-fe2ade27a5a6.png)
  
  
  > 결과 
  - 실질적인 구현은 Recursive 하게 풀었다. 
  - 일단 주어진 grid 를 순회하면서 1 을 찾으면, 해당 맵에 1이 연속으로 연결되어 있는 1을 -> 0 으로 만들어준다. (위,아래,오른쪽,왼쪽 방향으로)
  - 변경된 맵을 계속 순회하게 되면 첫번째 1과 연결이 안되어 있던 또다른 1을 찾을수 있게되는데 이때 islandCount 를  +1 해준다. 
  
  ![image](https://user-images.githubusercontent.com/36659877/197448179-2f648d71-7611-4f7f-9281-c6848b25cf0a.png)

  ```swift 
  func numIslands(_ grid: [[Character]]) -> Int {
      
      let row = grid.count
      let col = grid[0].count
      var islandCount = 0
      var map = grid

      for r in 0..<row {
          for c in 0..<col{
              if map[r][c] == "1" { //배열순회중, 1을 찾으면, r,c 를 reference Point 로 사용하여 연결되어 있는 1 들을 0 으로 만들어준다
                  islandCount += 1
                  changeElement(r,c,&map)
              }
          }
      }
      return islandCount
  }



  func changeElement(_ r:Int, _ c:Int, _ map: inout [[Character]]) { //To find area of island from the reference point

    guard r >= 0, r < map.count,
          c >= 0, c < map[0].count,
          map[r][c] == "1" else {return}
    map[r][c] = "0"
    changeElement(r+1, c, &map) //Search bottom and change to 0
    changeElement(r-1, c, &map) //top
    changeElement(r, c+1, &map) //right
    changeElement(r, c-1, &map) //left
  }
  ```

  - Time Complexity = `O(n^2)`
    
  - Space Complexity = `O(n+m)`

</details>

---- 
## Back Tracking
<details> 
  <summary> 1.0 Letter Combinations of a Phone Number </summary>  
  
  > 고민 
  - 어떻게 하나의 숫자로 만들수 있는 알파벳을 빼고 다른 숫자로 만들수 있는 알파벳과 조합을 이룰수 있을까?
  
  > 해결 
  - BackTracking Tree 를 그려보면 아래와 같이 만들수 있다.   
  ![image](https://user-images.githubusercontent.com/36659877/197676152-2035e3ed-6b06-44b1-b01a-a7a5e18d5a2c.png)
  - 2의 a 로 시작했을때 3의 def 과 조합하여 string 배열을 만들어 주어야하는데, 아래와 같은 방식으로 문제를 해결했다. 
  - 함수의 인풋으로 주어진 digits 를 index 로 관리해서 2와 3이 가지고 잇는 단어를 빼낼수있다. 
  - 첫번째로 2 의 (index = 0) 모든 character 를 순회하며 recursive 한 함수를 호출한다. 
  - 이 recursive 에 (index + 1) 을 넣어주어 3 이 가지고 있는 단어들을 순회 하며 이전에 넘어온 character (a,b,c 순) 과 현재 characters (d,e,f 순) 을 합쳐 recursive 함수 호출을 basecase 에 도달할때 까지 반복한다. 
  - 이때 basecase 는 현재 합쳐친 string 의 개수가 함수 인풋으로 주어진 digits 의 개수와 같은것이다. 
  
  > 결과 
  ```swift 
  func letterCombinations(_ digits: String) -> [String] {
    let letterList: [String: String] = ["2":"abc",
                                        "3":"def",
                                        "4":"ghi",
                                        "5":"jkl",
                                        "6":"nmo",
                                        "7":"pqrs",
                                        "8":"tuv",
                                        "9":"wxyz"]
    var res: [String] = []


      func backTracking(_ index: Int, _ currStr:String) {

        //basecase 
        if currStr.count == digits.count { 
          res.append(currStr)
          return
        }

        let strIndex = digits.index(digits.startIndex, offsetBy: index)
        for char in letterList[digits[strIndex]] {
            backTrack(index+1, currStr+String(char))  
        }

      } 

    if !digits.isEmpty {
      backTrack(0,"")
    }

    return res 
  } 
  
  ```
  
  - Time Complexity = `O(n*4^n)` (worstCase)
    
  - Space Complexity = `O(n)`
  
</details>

<details> 
  <summary> 2.0 Generate Parenthesis </summary> 
  
  > 고민 
  - 문제를 아예 어떻게 접근해야할지 조차 생각이 안난다. 
  - 계속 풀어보는 수밖에 없을듯.. 
  
  > 해결 
  
  ### 문제 파악
  - 3이 주어질때 well formed parenthesis 는 ["((()))","(()())","(())()","()(())","()()()"] 와 같다. 
  - Well Formed parenthesis 의 `Key Point` 는 "(" 이전에 ")" 가 올수 없는 형식이다. `)(` 와 같은 형식 불가 
  - n * 2 만큼의 parenthesis 가 존재하고 "(" 와 ")" 가 각각 반반 을 차지한다. 
  
  ### 문제 접근 
  - 어떻게 문제를 풀수 있을까? 
  - Brute force 방법으로 접근 해보자. 
    - Valid 한 parenthesis 는 어떠한 케이스인가? 
    - n = 3 일때, 3개의 opened, 3개의 closed 괄호를 가지고 있어야한다 (base case)
    - 이들의 순서는 opened parenthesis > closed parenthesis 일때만 closed 괄호를 더할수 있다. 
    - 열린 괄호는 limit, 즉 n 개의 열린괄호 까지 더해 줄수 있다. 
    - 이런 제약사항으로 백트래킹트리 를 만든다면 아래와같은 트리를 만들수있다. 
    
![image](https://user-images.githubusercontent.com/36659877/197924954-cce0a060-a348-4ba9-ba49-6e6390796c26.png)

  - 이 과정을 recursive 하게 코드로 구현해보자 
  
  ### 코드 구현 
  - base case 는 현재 str.count 가 n*2 일때로 구성하였다. 
  - 아래와같은 2가지의 case 로 recursive 하게 backtracking 함수를 불러줄수있다.  
  - 1.0 `(` 의 개수가 n 개 미만일떄 
  - 2.0 `)` 의 개수가 `(` 의 개수보다 작을때.

  > 결과 
  
  ```swift 
    func generateParenthesis(_ n: Int) -> [String] {

    let list: [Bool:String] = [true:"(", false:")"]
    var res:[String] = []

        func backTrack(_ openCnt: Int, _ closeCnt: Int, _ currStr: String) {
          //basecase
          if currStr.count == n*2 {
            res.append(currStr)
            return
          }

          //Add open parenthesis when it does not exceeds the limit
          if openCnt < n {
            backTrack(openCnt+1, closeCnt, currStr + (list[true]!))
          }

          //Call recursivly on the case below at the same time.

          //Add closed parenthesis if the count of closed parenthesis is less then opened ones.
          if closeCnt < openCnt {
            backTrack(openCnt, closeCnt+1, currStr + (list[false]!))
          }

        }

      backTrack(0,0,"")

      return res
    }
  ```  
  - Time Complexity = `O(8^n)` (worst case 잘모르겠음..)
    
  - Space Complexity = `O(n)`

</details> 


<details> 
  <summary> 3.0 Permutations </summary> 

  > 고민 
  - 어떻게 4자리 이상의 수가 주어질때 permutation 을 구할수 있을까? 
  - 일단 3자리 이하의 수가 주어질때는 어떻게 문제를 풀어야해야하는지 알아냈다. 
  - Ex) [1,2,3] 이 주어질 경우, 
    - [1,2,3] -> [1,3,2] 
    - [2,1,3] -> [2,3,1] 
    - [3,2,1] -> [3,1,2] 
    
    위와 같은 순으로 [1,2,3] 의 첫번째 요소의 순서을 번갈아가며 3개의 reference 배열을 만들었고, 하나의 배열마다 그 내부 요소의 순서를 index 로 지정하여 1부터 2 까지 순서를 바꿔주었다. 
  - 문제는 [1,2,3,4] 와 같이 4개 이상의 요소가 포함된 배열일 경우이다. 
    - 현재 내가 생각해낸 알고리즘은 내부의 요소 인덱스가 0부터 항상 증가하기 때문에 [1,2,3,4] 일경우 [1,3,2,4] -> [1,3,4,2] 까지 밖에 계산을 하지 못한다. 
    - 인덱스가 계속 증가기만 하다보니 [1,2,4,3], [1,4,2,3], [1,4,3,2] 같은 요소들이 빠진다는 이야기다. 
    
    현재 내가 작성 한 코드는 아래와 같고 어떻게 위 문제를 해결할수 있을지 찾아보자. 
    ```swift 
    func permute(_ nums: [Int]) -> [[Int]] {
  
      var res: [[Int]] = []

      func backTrack(_ startIndex: Int, curr: [Int]) {

        res.append(curr)
        if startIndex >= nums.count-1 {
          return
        }
        var newCurr = curr
        newCurr.swapAt(startIndex, startIndex+1)
        backTrack(startIndex+1, curr: newCurr)

      }

      for i in 0..<nums.count {
        var curr = nums
        curr.swapAt(i, 0)
        backTrack(1,curr: curr)
      }


      return res
    }
    ```
    
 > 해결
 - 주어진 배열[1,2,3] 에 대해서 나는 만들수 있는 조합의 reference? 를 아래와 같이 만들었었는데. 
 
    > 내가 생각했던 방식
    > [1,2,3] -> [1,3,2] 
    
    > [2,1,3] -> [2,3,1] 
    
    > [3,2,1] -> [3,1,2] 
    
    > 정답 방식
    - 정답을 본뒤에 사람들은 요소 하나하나 씩 선택하면 그 다음 것에서 무었을 선택할수 있나? 라는 로직으로 트리를 아래와 같이 만들었다. 
    - 동그라미 안에 들어 있는 요소들의 순서 하나하나가 permuation 이 되는 방식이다. 
![image](https://user-images.githubusercontent.com/36659877/198196919-1c5e1e5e-c864-4924-a6ec-9638a00e5450.png)


    > 구현 방식
    ![image](https://user-images.githubusercontent.com/36659877/198197967-ef633b85-a7de-44ea-ba93-9c8b3e531c77.png)
    ![image](https://user-images.githubusercontent.com/36659877/198204334-ea37ae54-3b4a-4511-83bf-6926b1c758ac.png)

  > 결과 
  ```swift 
    func permute(_ nums: [Int]) -> [[Int]] {

      var res: [[Int]] = []
      //basecase
      if nums.count == 1 {return [nums]}

      var copy = nums

      for _ in 0..<copy.count { //주어진 배열의 크기만큼 반복
        let firstVal = copy.remove(at: 0) //맨 앞에 있는 값을 빼주고
        var perms = permute(copy)//1개의 요소가 남을때 까지 계속 진행 (Basecase)

        for i in 0..<perms.count {
          perms[i].append(firstVal)
        }

        res += perms
        copy.append(firstVal)
      }
       return res
    }
  ```

  - Time Complexity = `O()` 
    
  - Space Complexity = `O(n)`

</details>

<details> 
  <summary> 4.0 Subsets </summary> 
  
> 고민
- 문제의 패턴이 위 3문제와 많이 흡사한것을 느낀다. 
- Recursive 하게 문제를 해결하려고 하는데 depth 가 깊어지면서 흐름을 이해하기가 너무 어려워진다. 

> 해결 
### 시도1
- 지금까지 문제를 풀었던 경험을 살려서 해답을 비슷하게 모방해보려고 했다. 
- BackTracking Tree 를 아래와 같이 만들었는데, 주어진 배열의 요소를 순서대로 remove 해가며 res 를 업데이트 하는 방식으로 문제를 해결 했다. 
![image](https://user-images.githubusercontent.com/36659877/198554709-f2dbc736-7ab1-4558-93ad-843f8357b151.png)
- 하지만 맨 끝단의 트리를 보면 중복되어 있는 요소들이 보일것이다. 중복을 해결하기 위해서 contains 메소드를 사용했는데, extra time complexity 를 추가 하기 때문에 효율적이지 못하다. 

- 구현 
```swift 
func subsets(_ nums: [Int]) -> [[Int]] {
  
  var res: [[Int]] = [[]]
  //basecase
  if nums.isEmpty {return []}
  res.append(nums)

  for i in 0..<nums.count {
    var copy = nums
    copy.remove(at: i)
    let singleElement = subsets(copy) // [[2,3]]
    for element in singleElement {
      if !res.contains(element) {
        res.append(element)
      }
    }
  }

  return res
}
```

### 시도2: 백트래킹 
- 더할건지 더하지 않을껀지 2가지 선택에서 백트래킹 방법으로 문제를 해결할수있다.
- 여기서 2가지의 선택은 첫번째 요소부터 시작해서 이 요소를 존재하는 배열에 넣을건지 말건지에 대한 선택이다. 
![image](https://user-images.githubusercontent.com/36659877/198561557-9c360f40-0f24-433f-889e-550da2b6ef54.png)

- 구현 
```swift 
  func subsets(_ nums: [Int]) -> [[Int]] {

    var res: [[Int]] = []
    var subSet: [Int] = []
    //[1,2,3]
    func dfs(_ index: Int) {
      //baseCase would be..
      if index >= nums.count{
        res.append(subSet)
        return
      }

      //for selecting current index of element
      subSet.append(nums[index])
      dfs(index+1)

      //not selecting current index
      subSet.removeLast() //Empty Subset
      dfs(index+1)
    }

    dfs(0)
    return res
  }
```
- Time Complexity = `O(n*2^n)` where n = length of given array. 2 = selection choices of each element

</details>

<details> 

  <summary> 5.0 Word Search </summary> 

> 고민 
- Number of island 문제와 많이 흡사하다는 생각이 들었다. 
- 주어진 word 의 첫번째 단어를 찾을시 그 요소의 좌,우,하,상 방향을 탐색해서 주어진 단어를 이어갈수 있는지 확인하는 로직으로 접근했다. 

> 해결 
- 하나의 요소에 쭉연결되어 있는지 확인할수 있도록 DFS 방식으로 문제를 해결했지만, 현재 로직의 런타임 시간이 들쑥날쑥해서 leetCode 에 통과를 했다 못했다 하는 상황이 발생. 

```swift 
func exist(_ board: [[Character]], _ word: String) -> Bool {

  let reversedWord = String(word.reversed())

  for row in 0..<board.count {
    for col in 0..<board[row].count {
      if let nextWord = reversedWord.last, board[row][col] == nextWord {
        let word = search(row: row, col: col, grid: board, word: reversedWord)
        if word.isEmpty {
          return true
        }
      }
    }
  }
  return false
}

func search(row: Int, col: Int, grid: [[Character]], word: String) -> String {
  guard row >= 0, row < grid.count,
        col >= 0, col < grid[row].count,
        grid[row][col] == word.last
  else {return word}
  
  var newWord = word
  newWord.removeLast()
  var map = grid
  map[row][col] = " "
  let res = newWord
  
  //위, 아래, 오른, 왼
  if  search(row: row-1, col: col, grid: map, word: newWord).isEmpty ||
      search(row: row+1, col: col, grid: map, word: newWord).isEmpty ||
      search(row: row, col: col+1, grid: map, word: newWord).isEmpty ||
      search(row: row, col: col-1, grid: map, word: newWord).isEmpty
  {
    return ""
  }
    
  return res
}
```

- Time Complexity = `O(n*m*dfs)` , where n = number of row, m = number of col
  
</details> 

----
## Sorting and Searching 

<details> 
  <summary> 1.0 Sort Colors </summary>
  
  > 고민 
  - counting Algorithm 이 무었인지 몰라 찾아보고 문제를 품. 
  
  > 해결 
  
  ### Counting Sort Algorithm 
  
  1.0 각각의 요소의 갯수를 세어준다. 
  
  2.0 세어진 요소의 개수를 오른쪽 방향으로 축적하며 더해준다. 
  
  3.0 오른쪽으로 한칸씩 이동시킨다. 
  
 ![image](https://user-images.githubusercontent.com/36659877/198857951-fbe27d50-5113-4b11-92d8-bcfc6926c5bb.png)
  
  
  ### Implementation of Counting Sort Algorithm 
  
  - nums 와 같은 길이인 배열을 하나 더 만든다
  - counting sort 배열에 있는 인덱스 값들과 nums 요소의 값을 매칭시켜서 새로운 배열에 순서대로 정렬 시켜놓는다. 
  
  > 결과 
  ```swift 
      func sortColors(_ nums: inout [Int]) {

      var countList = Array(repeating: 0, count: 3)
      var res = Array(repeating: 0, count: nums.count)
      //Counting Algorithm
      for i in 0..<nums.count {
        countList[nums[i]] += 1
      }

      for i in 1..<countList.count {
        countList[i] += countList[i-1]
      }

      for i in 0..<countList.count-1 {
        let lastIndex = countList.count-1-i
        countList[lastIndex] = countList[lastIndex-1]
      }
      countList[0] = 0

      //Sort Nums
      for i in 0..<nums.count {
        let index = countList[nums[i]]
        let value = nums[i]
        res[index] = value
        countList[nums[i]] += 1
      }

      nums = res

    }
  ```
  
  - Time Complexity = `O(n+k)` where n = length of nums, k = range of colors 
  - Space Complexity = `O(n+k)`
  
</details> 

<details> 
  <summary> 2.0 Top K Frequent Elements </summary>
  
  > 고민 
  - max heap 을 굳이 구현해야할까? 
  - 처음 return K most frequently elements 라는 의미를 전혀 이해하지 못함. 
  - 요소가 K 만큼 있는 것을 반환하는 줄 알았는데, K 번 이상 불린게 있다면 그 요소들을, 없다면 그 이하로 불린 요소들을 반환해주는 것이였다. 
  
  > 해결 
  - 딕셔너리를 이용해서 sort 해주면 굳이 max heap 을 따로 구현해야할 필요가 없기때문에 디셔너리를 이용해서 문제를 해결. 
  - 대신 max heap 처럼 사용해야하기 때문에, desending order 로 sort 해주어야했슴.
  
  
  > 결과 
  ```swift 
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {

      var count:[Int: Int] = [:]
      var res: [Int] = []

      for num in nums {
        if count[num] == nil {
          count.updateValue(1,forKey:num)
        }else {
          count[num]! += 1
        }
      }

      let sorted = count.sorted(by: {$0.value>$1.value})

      for i in 0..<k {
        res.append(sorted[i].key)
      }

      return res
    }
  ```
  
  - Time Complexity = `O(n)`
  
  - Space Complexity = `O(n)`  
</details> 

<details> 
  <summary> 3.0 Kth Largest Element in an Array </summary> 
  
  > 고민 
  - sorting algorithm 을 따로 구현 해야하나? 
  
  > 해결 
  - 그냥 Foundation 에서 지원해주는 sorted() 메소드 사용해서 문제 해결함. 
  
  > 결과 
  
  ```swift 
     func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        let sorted = nums.sorted(by: {$0>$1})
        return sorted[k-1]
    }
  ```
  - Time Complexity = `O(n)`
  
  - Space Complexity = `O(1)`

</details> 

<details> 
  <summary> 4.0 Find Peak Element </summary>
  
  > 고민 
  - 어떻게 O(logn) 시간 복잡도로 문제를 해결할까? 
  
  > 해결 
  - 처음엔 요소하나하나씩 검사해서 전 요소보다 현재 요소가 크고, 다음요소보다 작을때 해당 인덱스를 반환하도록 접근했지만 O(n) 의 시간 복잡도를 형성하게 됨
  - Binary search 를 사용한 접근 방법을 찾아 봤고, left, right, pivot indexing 을 사용해서 문제를 해결했다. 
    - 처음 left 와 right 을 0,nums 의 마지막 인덱스로 할당해주고 (left+right)/2, 그 중앙에 있는 인덱스를 pivot 으로 설정해주었다.
    - 그후, pivot 에 위치한 요소가 그 다음 요소보다 값이 작을경우 현재 pivot 보다 오른쪽 에 더 큰값이 있는것으로 판별, left 를 pivot + 1 로 설정해준다. 
    - 만약 그 반대로 pivot 에 위치한 요소가 다음 요소의 값보다 클경우 pivot 중심으로 왼쪽에 peak 이 있다고 판별, right 를 pivot 으로 할당해준다. 
    - 이 과정을 계속 반복하면, left 와 right 가 맞물리게 되는데, 이때 while 룹을 빠져나온다. 
    - right, 혹은 left 인덱스를 마지막으로 반환해주면, 주어진 배열의 peak index 를 찾을수 있게된다. 
  ![image](https://user-images.githubusercontent.com/36659877/198945096-ffe501ba-e28f-41c4-88d6-a811b0ae7877.png)

  > 결과 
  ```swift
  func findPeakElement(_ nums: [Int]) -> Int {
  
    var right = nums.count-1
    var left = 0

    if nums.count <= 1 {return 0}

    while left < right  {
      let pivot = (left + right)/2
      let curr = nums[pivot]
      let next = nums[pivot+1]

      if curr < next {
        left = pivot+1 //3
      }else {
        right = pivot
      }
    }
    return left
  }
  ```
                    
  - Time Complexity = `O(logn)`
  
  - Space Complexity = `O(1)`  

</details>

<details> 
  <summary> 5.0 Serach Range </summary> 
  
  > 고민 
  - O(logn) 시간 복잡도록 문제 해결하기.. 
  
  > 해결 
  - 첫번째 시도는 배열의 첫번째 Target 인덱스를 구해서 left 를 미리 설정해 주는것이다. 
  - 첫번째 target 을 발견하면, 그 인덱스가 left 가 되고, right 인덱스를 binary search 를 이용해서 문제를 해결하는 방법이다. 
  
  ```swift 
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
      guard let left = nums.firstIndex(of: target) else {
        return [-1,-1]
      }

      var right = nums.count-1

      while (nums[left] != target || nums[right] != target) {
        let pivot = (left+right)/2
        let curr = nums[pivot]
        let nextVal = nums[pivot+1]

        if nextVal > curr {
          right = pivot
        }else {
          right -= 1
        }

      }
      return [left,right]
    }
  ```
  - 그런데 이방법이 O(logn) 시간복잡도를 충족시키는지에 관한 의문이 든다. 
  - 그 이유는 첫번째 target 인덱스를 찾을때까진 linear search 를 하게 되기 때문이다. 
  - 따라서 left 또한 binary serach 를 이용해서 구하는 방식을 사용해서 문제를 해결했다. 
  
  > 결과 
  
  ```swift 
  func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
    guard !nums.isEmpty else {return [-1,-1]}
    var res: [Int] = []
    res.append(findStartIndex(nums,target))
    res.append(findEndIndex(nums,target))
    return res
  }

  func findStartIndex(_ nums: [Int], _ target: Int) -> Int {
    var res = -1
    var left = 0
    var right = nums.count-1

    while left <= right {
      let pivot = (left+(right))/2
      let curr = nums[pivot]

      if (curr >= target) {
        right = pivot-1
      } else {
        left = pivot+1
      }

      if (curr == target) {
        res = pivot
      }

    }
    return res
  }

  func findEndIndex(_ nums: [Int], _ target: Int) -> Int {
    var res = -1
    var left = 0
    var right = nums.count-1

    while left <= right {
      let pivot = (left+right)/2
      let curr = nums[pivot]

      if (curr <= target) {
        left = pivot+1
      } else {
        right = pivot-1
      }

      if (curr == target) {
        res = pivot
      }

    }
    return res
  }
  ```
  
  - Time Complexity = `O(logn)` 
  
  - Space Complexity = `O(logn)` 

</details>

<details> 
  <summary> 6.0 Merge Intervals </summary> 
  
  > 고민 
  - 현재 배열의 요소와 다음 요소가 포함하고 있는관계를 어떻게 수식해야할지 고민을했다. 
  - 처음엔 주어지는 배열의 요소가 ascending 순으로 sort 되어 있는줄알아서 문제를 풀면서 해멨다. 
  
  > 해결 
  - 다음 요소의 배열의 포함관계 수식화 
  - 아래 다이어그램을 그려보면서 어떤 수식으로 표현해야하는지 알아봄
  ![image](https://user-images.githubusercontent.com/36659877/199403456-e9a8eb33-f1c2-478e-b873-93cc8e5114ed.png)
  - 첫번째로 배열의 첫번째요소 (시작점) 을 기준으로 sort 를 해준다. (이렇게 하면 첫번째 배열의 첫번째 요소는 가장 작은 값이니 어디서 부터 시작해하는지 생각할 필요가 없어진다).
  - 다음배열의 첫번째 요소가 현재 배열의 마지막요소보다 같거나 작을시, merge 되는 것을 확인할수 있다. -> merge 되는 경우는 끝나는 값을 현재 배열의 끝과 다음 배열의 끝을 비교해서 업데이트해주어야한다. 
  - 만약 다음배열의 첫번째 시작요소가 더 클경우는 (머지가 안되는경우) append() 시켜준다. 
  
  > 결과 
  ```swift 
  func merge(_ intervals: [[Int]]) -> [[Int]] {
    var sortedIntervals = intervals.sorted(by: {$0<$1}) 
    var res: [[Int]] = [] 
    
    for interval in sortedIntervals {
      if res.isEmpty || res[res.count-1][1] < interval[0] { //이전 요소의 마지막 값이 현재 시작값보다 작다면 머지 하지 않음.
        res.append(interval)
      }else {
        //머지해줘야하는데, 마지막 값을 업데이트 시켜줘야한다. 
        res[res.count-1][1] = max(res[res.count-1][1], interval[1])
      } 
     
    }
  
  }
  ```
  
  
  - Time Complexity = `O(Nlogn)` (worst case for sort)
  
  - Space Complexity = `O(n)`

  
</details> 
  
<details> 
  <summary> 7.0 Search in Rotated Sorted Array </summary> 
  
  > 고민 
  - O(logn), binary search 로 어떻게 partially sorted 한 array 를 탐색할수 있을까? 
  
  > 해결 
  - 문제는 내가 해결하지 못했다. 
  - [여기](https://www.youtube.com/watch?v=U8XENwh8Oy8) 를 참조 해서 문제를 해결했는데 너무 복잡하다는 생각이든다. 
  - 전체적인 흐름은 binary search 를 기반으로 해서 중심 pivot 기준으로 첫번째 요소와 값을 비교한다. 이렇게 하면 현재 pivot 의 기준으로 왼쪽/오른쪽 방향으로 sorted 되있는지 알수 있기 때문이다. 
  - 그 이후 Target 값과 mid, left, right 값을 비교하며 left, right 를 업데이트 시켜주고 이과정을 left <= right 될때까지 반복한다. 
  
  > 결과 
  ```swift 
  func search(_ nums: [Int], _ target: Int) -> Int {
  
    var left = 0
    var right = nums.count-1

     while left <= right {
      let pivot = (left+right)/2

      if nums[pivot] == target {
        return pivot
      }

      //Left sortPortion
      if nums[left] <= nums[pivot] {
        if nums[pivot] < target ||  target < nums[left] { //
          left = pivot+1
        }else {
          right = pivot-1
        }

      }else {
        //Right sortPortion
        if target < nums[pivot] || target > nums[right]{
          right = pivot-1
        }else {
          left = pivot+1
        }
      }
    }
    return -1
  }
  ```
  - Time Complexity = `O(logn)`
  
  - Space Complexity = `O(1)`
  
</details>
  
<details> 
  <summary> 8.0 Search a 2D Matrix II </summary>
  
  > 고민 
  - Brute Force 보다 더 빠르게 문제를 어떻게 풀어야할까? 
    - 각 row 와 col 들이 Ascending 한 순으로 sort 되있다는 힌트는 binary search 를 할수 있는 최적의 조건이고, brute force 방법보다 빠르게 문제를 해결할수 있다. 
    - 그럼 어떻게 binary search 를 적용할까? 
    
  > 해결 
  - 일단 직관적으로 어떻게 주어진 Target 을 구할수 있을지 한번 생각해 보았다. 
    - 1.0 첫번째 row 에 주어진 Target 값과 가장 근접한 값의 index 를 찾는다. (이때 Target 과 같은 값을 찾으면 true 반환) 
      -> 가장 근접하는 뜻은 그 다음 인덱스에 있는 값들과 col 의 값들은 Target 의 값보다 크다는 뜻이된다. 
      ![image](https://user-images.githubusercontent.com/36659877/199996183-373c3e2f-0bf1-40c3-b0c9-0ab4284c991a.png)

    - 2.0 찾은 index 에서 column 부터 첫번째 컬럼 까지 검사를 한다.
     ![image](https://user-images.githubusercontent.com/36659877/199996369-3c2a0fd4-9d47-4114-b4de-5d4dbdf5272f.png)

  - 이 과정을 Binary Search 알고리즘을 적용한다면 BruteForce 보다 빠르게 탐색할수 있다. 
  
  
  > 결과 
  ```swift 
   func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
      let row = 0
      var col = 0
      var left = 0
      var right = matrix[row].count-1

  
      //1.0 Search to find Starting Point from the first row
      while left <= right {
        let mid = (left+right)/2
        let curr = matrix[row][mid]

        if curr == target || matrix[row][left] == target || matrix[row][right] == target {
          return true
        }

        if curr < target {
          left = mid+1
        } else {
          right = mid-1
        }
      }


      //2.0 Search Backwards til Col == 0
      col = right
      while col >= 0 {
        left = 0
        right = matrix.count-1
        while left <= right {
          let mid = (left+right)/2
          let curr = matrix[mid][col]

          if curr == target || matrix[left][col] == target || matrix[right][col] == target {
            return true
          }

          if curr < target {
            left = mid+1
          }else {
            right = mid-1
          }
        }
        col -= 1
      }

      return false
    }
 ``` 
  
  - Time Complexity = `O(logn)`
  
  - Space Complexity = `O(1)`

</details>

----
## Dynamic Programming 

<details> 
   <summary> 1.0 Jump Game </summary> 
   
   > 고민 
   - 어떻게 DP 로 문제를 해결야하나? 
   
   > 해결 
   - 이 문제는 DP와 Greedy 방법으로 해결할수 있는데, DP을 사용한 방법은 O(n^2) 의 시간복잡도를 가지게 되고, Greedy 는 O(n) 의 시간복잡도를 가지고 해결할수 있어 Greedy 방식으로 문제를 해결
   - 로직 : 
      - 마지막 인덱스에 도달할수 있는지 알면되기 때문에 마지막 인덱스 이전의 인덱스 값 + 요소 값이 마지막 인덱스에 도달할수 있는지 확인한다. 
      - 만약 마지막 인덱스에 도달할수 있다면 이전의 인덱스(nums.count-3) 이 (nums.count-2) 에 도달할수 있는지 확인하면된다. 
      - 첫번쨰 인덱스 요소가 다음 인덱스에 도달할수 있다면 true 를 반환한다. 

   > 결과 
   
   ```swift 
   func canJump(_ nums: [Int]) -> Bool {
      var goal = nums.count-1

      for i in stride(from: nums.count-1, through:0 , by: -1){
        if (i+nums[i]) >= goal {
           goal = i
        }
      }
      return goal == 0
    }
   ```
   
  - Time Complexity = `O(N)`
  
  - Space Complexity = `O(1)`

</details>

<details> 
  <summary> 2.0 Unique Path </summary> 
  
  > 고민 
  - 처음 시작 점에서 부터 오른쪽, 왼쪽으로 가는 선택지가 있으니까 가는 선택지의 좌표를 cache 해놓고 문제를 풀면되지 않을까? 라는 만연한생각을 했다. 
  - 그리고 아래와같이 트리를 그리면서 Valid 한 path 를 어떻게 하면 기록해서 그 수를 셀수 있을지 고민 해봤지만... 어떻게 Path 를 저장해야하지? 라는 것에서 막혀버렸다. 
  
  ![image](https://user-images.githubusercontent.com/36659877/200159018-c29fa0ae-f9ed-43c3-b2ad-98391ff4cd58.png)

  > 해결 
  - 여러 길의 Path 를 저장해놓는방법을 아래와 같이 해결한다. 
    - 아래 그림은 좌표 (1,1) 까지 갈수 있는 방법을 계산하고자 한다.   
    - 문제에서 주어진것처럼 하나의 좌표에서 갈수 있는 방향은 오른쪽과 아래 방향이다. 따라서 해당좌표에서 바라보았을때 여기까지 올수있는 옵션은 왼쪽, 위 에서 오는 방향이라고 말할수 있다. 
  ![image](https://user-images.githubusercontent.com/36659877/200159473-af7fe346-454f-46df-abb1-945ced519cb6.png)
  
  - 그럼 어떤 값으로 해당좌표까지 올수 있는 path 의 개수를 나타낼수 있을까? 
    - 첫시작점에서 첫시작점까지 올수 있는 방법은 1가지 방법뿐이다. 그럼 그 좌표에서 갈수 있는 방향또한 첫번째 좌표에서 오른쪽으로 가는방법 1가지, 아래로 가는방법 1가지 뿐이다. 
    - 즉 최소 경로의 갯수는 1개라는 뜻이다. 
    - 따라서 mxn 만큼의 배열을 1로 할당해준다. 
    - 이렇게 되면, (1,1) 까지로 갈수 있는 방법은 위, 왼쪽에서 오늘 방법들을 합한게 되는데 아래 다이어그램에 표기했듯, (0,1), (1,0) 까지 가는 방법이 각각 1이여서 (1,1)까지 가는 방법은 2가지가 된다. 
    - 이 방법을 마지막 요소까지 진행하여 배열 각 좌표에 도달할수 있는 경로의 수를 업데이트 해주면된다. 
![image](https://user-images.githubusercontent.com/36659877/200159636-ce05fa64-4fb2-4d09-bbf6-d8ef6e433cdb.png)

  > 결과
  ```swift 
    func uniquePath( _ m:Int, _ n:Int) -> Int { 
      var dp = Array(repeating: Array(repeating: 1 count: n), count:m)
      
      //첫번째 열의 값은 모두1 (오른쪽 하나의 방향으로 가는 방법밖에 없으니)
      for i in 1..<m { 
        for j in 1..<n { 
          dp[i][j] = dp[i-1][j] + dp[i][j-1]
        }
      }
      
      return dp[m-1][n-1]
    }
  
  ```
  
</details>


<details> 
  <summary> 3.0 Coin Change </summary> 

> 고민 
- 큰수에서 부터 나누어서 나머지 값을 그 다음큰수로 나누어 모든 코인은 순회하고 사용된 코인 개수를 세는 방식으로 문제를 해결하려고 했으나, 최소 코인의 개수를 사용해서 amount 를 충족시키지 못하기 때문에 DP 방법을 알아봄. 
  
  
> 해결 
- dp 라는 배열을 만들었는데 amount+1 만큼의 개수와 초기요소의 값도 amount + 1 으로 설정을 한다. 
  - 각 요소는 [amount] 일때의 필요한 코인의 개수를 명시한다. amount + 1 인 이유는 이후에 값 1 부터 amount 까지 순회하며 현재 amount 에 할당되어있는 코인의 개수를 업데이트 해주기위해 (최소값) amount 에 1 을 더한 것이다. 
  - amount + 1 을 하는 이유는 amount 가 0 일때 의 케이스를 커버하기 위하여 일부로 하나 더큰 배열로 만듦
  
- 만약 Coins = [1,3,4,5] , Amount = 7 일시, dp 에는 dp[Amount] = number coin 이 저장되는데, amount 는 0 부터 주어진 amount 까지 존재하며 각 amount 에 필요한 코인의 최소 개수는 dp 에 저장된다. 

- Amount 가 0 부터 6까지 일때 dp 업데이트 현황

![image](https://user-images.githubusercontent.com/36659877/200245701-aace2498-b9a8-4451-acbe-be61e920157a.png)

  - Amount 가 7 일시, coins 을 순회하며 (7-coin) >= 0 일때 (음수일시 amount 값을 초과해버림) 현재 저장되어있던 dp 값과, 새로선택된 coin 의 dp 값중 작은 값으로 dp 를 업데이트 시킨다. 
   - 고른 코인이 1일시, 
    dp[7] = 1 + dp[7-1] = 3
    
    
  - 고른 코인이 3일시, 
    dp[7] = 1 + dp[7-3] = 2 

> 결과 

```swift 
func coinChange(_ coins: [Int], _ amount: Int) -> Int {
  
  var dp:[Int] = Array(repeating: amount+1, count: amount + 1)
  dp[0] = 0
  
  for i in 1..<dp.count {
    for coin in coins {
      if (i - coin) >= 0 {
        dp[i] = min(dp[i], 1+dp[i-coin])
      }
    }
  }
  return dp[amount] == amount+1 ? -1 : dp[amount]
}

```
- Time Complexity = `O(amount * coins.count)`
  
- Space Complexity = `O(amount)`  

</details>


<details> 
  <summary> 4.0 Longest Increasing Subsequence </summary> 
  
  > 고민 
  - 뭔가 각 요소 하나하나 선택했을때 그 다음 요소가 이전의 요소보다 작을시 카운트를 하지 않게 알고리즘을 작성하면될것같다. 
  - 하지만 이게 sequence 로 구성이 있으니 주어진 배열하나하나 에서 나올수 있는 모든 subsequence 를 찾아야하는데.. 여기서 머리가 멈췄다. 
  
  > 해결 
  - 일단 첫번째 생각은 얼추 들어 맞았다. 문제는 결국엔 DP 를 사용해서 해결하지만 거기까지 도달하는 생각의 흐름은 아래와 같다. 
  
  ### Brute Force - DFS (Generate every possible subsequence) 
  - Given array = [0,1,0,3,2,3] 
  - 각 요소 마다 subsequnce 에 추가할건지 말건지에 대한 2가지의 선택지가 주어지는데, 이렇게 문제를 해결하게되면 O(2^n) 지수시간의 시간복잡도가 형성이 된다. 
  - 따라서 DP 를 사용해 알고리즘의 효율성을 높힌다. 
  
  ### Using DP 
  - Given array = [1,2,4,3], 일때 Longest Subsequence 는 [1,2,4] 혹은 [1,2,3] 으로 3개가 된다. 
  - 문제풀이는 일단 Brute Force 접근방식부터 시작해서 어떻게 DP 를 사용해야할지 고민을 해보자. 
  
  > 1.0 Check all subsequences starting at first index to the end 
  - 이때 subsequence 는 오름순 이여야하기 때문에 이전인덱스의 값이 현재 인덱스의 값보다 작은지 확인해야한다. 
  - 아래 보이는 다이어그램은 0번째 인덱스를 선택했을때 어떻게 subsequnces 들이 구성되는지 그린것이다.
  
  ![image](https://user-images.githubusercontent.com/36659877/200486686-d67e39ca-f741-4a78-86d8-5bacfc940a4a.png)

  > 2.0 Identify Duplicated Patterns 
  - 0 번째인덱스에서 시작해 마지막 트리를 보면 [1,2,4] 에서 3번째 인덱스로 나아갈땐 다음 인덱스 요소가 3이기 때문에 더이상 나아가지 못하게된다. 
  - 마찬가지로 3번째 인덱스에서 4번째 인덱스로 가려고 하지만 주어진 배열의 크기를 벚어남으로 더이상 나아가질 못한다. 
  
  - 이런상황은 첫번째 인덱스를 [2] 또는 [3] 을 선택해서 간것과 같은 패턴을 보여준다. 
  - 인덱스 2 를 첫번째로 선택할 경우에는 [4] 가 되고, 그 다음 인덱스 3 은 [4] 보다 작기때문에 더이상 나아가질 못한다. 
  - 인덱스 3 를 첫번째로 선택할 경우에는 [3] 가 되고, 그 다음 인덱스 4 주어진 배열의 크기를 벗어남으로 더이상 나아가질 못한다.
    
  - 따라서 이런 공통적인 패턴을 cache 해두고 같은상황이 왔을때 다시 사용하도록 하면된다. 이 캐싱 과정을 그려보면 아래와같다. 
  
  ![image](https://user-images.githubusercontent.com/36659877/200487991-eb3bfa43-86e7-48b0-9396-72b23a9e9a64.png)
  
  - 그렇다면 LIS[1] 과 LIS[0] 은 어떻게 구한것인가? 
    - LIS[1] 은 `1 번째 인덱스 를 선택한 것`, `1 번째 인덱스 를 선택 + LIS[2] 선택 한 것`, `1 번째 인덱스 를 선택 + LIS[3] 선택 한 것` 중에 가장 개수가 많은 subsequnce 를 선택해주면 된다. 
    - 마찬가지로 LIS[0] 은 
      - `0 번째 인덱스 를 선택한 것`, `0 번째 인덱스 를 선택한 것 + LIS[1] 선택 한 것` `0 번째 인덱스 를 선택한 것 + LIS[2] 선택 한 것` `0 번째 인덱스 를 선택한 것 + LIS[3] 선택 한 것` 중에 가장 개수가 많은 subsequnce 를 선택해주면 된다. 
  
  > 결과 

  - 위 패턴을 본결과, 마지막 인덱스부터 subsequence 를 체크하면 가장 작은 subproblem 을 풀수 있기때문에 마지막 인덱스의 요소에서부터 만들수있는 subsequence 의 개수를 
  DP 에 업데이트 해주도록 알고리즘을 구현해준다. 
  
  ```swift 
  func lengthOfLIS(_ nums: [Int]) -> Int {
        //lowest length of subsequence = 1 
        var dp: [Int] = Array(repeating: 1, count: nums.count)
        
        //뒤에서 부터 거꾸로 인덱스를 거쳐오면서 이전의 요소값이 현재 요소값인지 작은지 확인하고 
        //dp 를 업데이트 해준다. 
        for i in stride(from: nums.count-2, through: 0, by: -1){
            for j in i+1..<nums.count { 
                if nums[i] < nums[j] {
                    dp[i] = max(dp[i], 1+dp[j])
                }
            }            
        }       
        return dp.max()! 
    }
  ```
  
  - Time Complexity = `O(n^2)` 
  
  - Space Complexity = `O(n)`

</details>
