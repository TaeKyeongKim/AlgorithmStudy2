
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


