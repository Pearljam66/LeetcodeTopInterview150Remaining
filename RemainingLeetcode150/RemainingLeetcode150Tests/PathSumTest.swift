//
//  PathSumTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/23/24.
//

/*
 Given the root of a binary tree and an integer targetSum, return true if the tree has a root-to-leaf path such that adding up all the values along the path equals targetSum.
 A leaf is a node with no children.

 Example 1:
 Input: root = [5,4,8,11,null,13,4,7,2,null,null,null,1], targetSum = 22
 Output: true
 Explanation: The root-to-leaf path with the target sum is shown.

 Example 2:
 Input: root = [1,2,3], targetSum = 5
 Output: false
 Explanation: There are two root-to-leaf paths in the tree:
 (1 --> 2): The sum is 3.
 (1 --> 3): The sum is 4.
 There is no root-to-leaf path with sum = 5.

 Example 3:
 Input: root = [], targetSum = 0
 Output: false
 Explanation: Since the tree is empty, there are no root-to-leaf paths.

 Constraints:
 The number of nodes in the tree is in the range [0, 5000].
 -1000 <= Node.val <= 1000
 -1000 <= targetSum <= 1000
 */

import Testing

struct PathSumTest {

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
        func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
            // Base case: if root is nil, there's no path
            guard let root = root else { return false }

            // If it's a leaf node, check if the sum matches
            if root.left == nil && root.right == nil {
                return root.val == targetSum
            }

            // Recursively check left and right subtrees
            return hasPathSum(root.left, targetSum - root.val) || hasPathSum(root.right, targetSum - root.val)
        }
    }

    @Test func example1() {
        let solution = Solution()
        let root = TreeNode(5)
        root.left = TreeNode(4)
        root.right = TreeNode(8)
        root.left?.left = TreeNode(11)
        root.left?.left?.left = TreeNode(7)
        root.left?.left?.right = TreeNode(2)
        root.right?.left = TreeNode(13)
        root.right?.right = TreeNode(4)
        root.right?.right?.right = TreeNode(1)

        #expect(solution.hasPathSum(root, 22) == true)
    }

    @Test func example2() {
        let solution = Solution()
        let root = TreeNode(1)
        root.left = TreeNode(2)
        root.right = TreeNode(3)

        #expect(solution.hasPathSum(root, 5) == false)
    }

    @Test func example3() {
        let solution = Solution()

        #expect(solution.hasPathSum(nil, 0) == false)
    }

}
