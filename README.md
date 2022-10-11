
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
