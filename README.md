
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

