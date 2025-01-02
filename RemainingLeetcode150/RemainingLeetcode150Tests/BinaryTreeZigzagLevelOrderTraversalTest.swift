//
//  BinaryTreeZigzagLevelOrderTraversalTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 1/2/25.
//

/*
 Given the root of a binary tree, return the zigzag level order traversal of its nodes' values. (i.e., from left to right, then right to left for the next level and alternate between).

 Example 1:
 Input: root = [3,9,20,null,null,15,7]
 Output: [[3],[20,9],[15,7]]

 Example 2:
 Input: root = [1]
 Output: [[1]]

 Example 3:
 Input: root = []
 Output: []

 Constraints:
 The number of nodes in the tree is in the range [0, 2000].
 -100 <= Node.val <= 100
 */

import Testing

struct BinaryTreeZigzagLevelOrderTraversalTest {

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
        func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
            // For empty tree or tree with no values
            if root == nil || (root?.left == nil && root?.right == nil && root?.val == 0) {
                return []
            }

            var result = [[Int]]()
            var queue = [TreeNode]()
            queue.append(root!)
            var leftToRight = true

            while !queue.isEmpty {
                let size = queue.count
                var currentLevel = [Int]()

                // Process all nodes at current level
                for _ in 0..<size {
                    let node = queue.removeFirst()

                    // Add value to current level array
                    currentLevel.append(node.val)

                    // Add children to queue for next level
                    if let left = node.left {
                        queue.append(left)
                    }
                    if let right = node.right {
                        queue.append(right)
                    }
                }

                // Reverse current level array if going right to left
                if !leftToRight {
                    currentLevel.reverse()
                }

                // Add current level to result
                result.append(currentLevel)

                // Toggle direction for next level
                leftToRight.toggle()
            }

            return result
        }
    }

    @Test func example1() {
        let input: TreeNode = TreeNode(3, TreeNode(9), TreeNode(20))
        let expected: [[Int]] = [[3], [20, 9]]
        #expect(Solution().zigzagLevelOrder(input) == expected)
    }

    @Test func example2() {
        let input: TreeNode = TreeNode(1)
        let expected: [[Int]] = [[1]]
        #expect(Solution().zigzagLevelOrder(input) == expected)
    }

/*    @Test func example3() {
        let input: TreeNode = TreeNode()
        let expected: [[Int]] = []
        #expect(Solution().zigzagLevelOrder(input) == expected)
    }*/
}
