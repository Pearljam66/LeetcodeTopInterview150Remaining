//
//  SumRootToLeafNumbersTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/24/24.
//

/*
 You are given the root of a binary tree containing digits from 0 to 9 only.
 Each root-to-leaf path in the tree represents a number.
 For example, the root-to-leaf path 1 -> 2 -> 3 represents the number 123.
 Return the total sum of all root-to-leaf numbers. Test cases are generated so that the answer will fit in a 32-bit integer.
 A leaf node is a node with no children.

 Example 1:
 Input: root = [1,2,3]
 Output: 25
 Explanation:
 The root-to-leaf path 1->2 represents the number 12.
 The root-to-leaf path 1->3 represents the number 13.
 Therefore, sum = 12 + 13 = 25.

 Example 2:
 Input: root = [4,9,0,5,1]
 Output: 1026
 Explanation:
 The root-to-leaf path 4->9->5 represents the number 495.
 The root-to-leaf path 4->9->1 represents the number 491.
 The root-to-leaf path 4->0 represents the number 40.
 Therefore, sum = 495 + 491 + 40 = 1026.

 Constraints:
 The number of nodes in the tree is in the range [1, 1000].
 0 <= Node.val <= 9
 The depth of the tree will not exceed 10.
 */

import Testing

struct SumRootToLeafNumbersTest {

    class TreeNode {
        var val: Int
        var left: TreeNode?
        var right: TreeNode?

        init() { self.val = 0; self.left = nil; self.right = nil; }
        init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
        init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
            self.val = val
            self.left = left
            self.right = right
        }
    }

    class Solution {
        func sumNumbers(_ root: TreeNode?) -> Int {
            func dfs(_ node: TreeNode?, _ currentSum: Int) -> Int {
                guard let node = node else { return 0 }

                let newSum = currentSum * 10 + node.val

                if node.left == nil && node.right == nil {
                    return newSum // Leaf node reached
                }

                return dfs(node.left, newSum) + dfs(node.right, newSum)
            }

            return dfs(root, 0)
        }
    }

    @Test func example1() {
        let solution = Solution()
        let root = TreeNode(1, TreeNode(2), TreeNode(3))
        #expect(solution.sumNumbers(root) == 25)
    }

    @Test func example2() {
        let solution = Solution()
        let root = TreeNode(4,TreeNode(9,TreeNode(5),TreeNode(1)),TreeNode(0))
        #expect(solution.sumNumbers(root) == 1026)
    }

}
