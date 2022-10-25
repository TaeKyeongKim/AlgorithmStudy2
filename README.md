
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
