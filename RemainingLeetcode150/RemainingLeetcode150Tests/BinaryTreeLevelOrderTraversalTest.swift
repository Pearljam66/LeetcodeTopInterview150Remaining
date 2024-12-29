//
//  BinaryTreeLevelOrderTraversalTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/29/24.
//

/*
 Given the root of a binary tree, return the level order traversal of its nodes' values. (i.e., from left to right, level by level).

 Example 1:
 Input: root = [3,9,20,null,null,15,7]
 Output: [[3],[9,20],[15,7]]

 Example 2:
 Input: root = [1]
 Output: [[1]]

 Example 3:
 Input: root = []
 Output: []

 Constraints:
 The number of nodes in the tree is in the range [0, 2000].
 -1000 <= Node.val <= 1000
 */

import Testing

struct BinaryTreeLevelOrderTraversalTest {

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
        func levelOrder(_ root: TreeNode?) -> [[Int]] {
            // Check if the root is nil or has no children and value is 0 (assuming default initialization)
            if root == nil || (root?.left == nil && root?.right == nil && root?.val == 0) {
                return []
            }

            var result: [[Int]] = []
            var queue: [TreeNode] = [root!]

            while !queue.isEmpty {
                var level: [Int] = []
                let count = queue.count

                for _ in 0..<count {
                    let node = queue.removeFirst()
                    level.append(node.val)

                    if let left = node.left {
                        queue.append(left)
                    }
                    if let right = node.right {
                        queue.append(right)
                    }
                }
                result.append(level)
            }
            return result
        }
    }

    @Test func example1() {
        #expect(Solution().levelOrder(TreeNode(3, TreeNode(9), TreeNode(20))) == [[3], [9, 20]])
    }

    @Test func example2() {
        #expect(Solution().levelOrder(TreeNode(1)) == [[1]])
    }

    @Test func example3() {
        #expect(Solution().levelOrder(TreeNode()) == [])
    }

}
