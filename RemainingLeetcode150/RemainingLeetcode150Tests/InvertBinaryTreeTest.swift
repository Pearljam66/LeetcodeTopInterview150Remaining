//
//  InvertBinaryTreeTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/19/24.
//

/*
 Given the root of a binary tree, invert the tree, and return its root.

 Example 1:
 Input: root = [4,2,7,1,3,6,9]
 Output: [4,7,2,9,6,3,1]

 Example 2:
 Input: root = [2,1,3]
 Output: [2,3,1]

 Example 3:
 Input: root = []
 Output: []

 Constraints:
 The number of nodes in the tree is in the range [0, 100].
 -100 <= Node.val <= 100
 */

import Testing

struct InvertBinaryTreeTest {

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
        func invertTree(_ root: TreeNode?) -> TreeNode? {
            // Base case: if the node is nil, return nil
            guard let node = root else {
                return nil
            }

            // Swap the left and right children
            let temp = node.left
            node.left = invertTree(node.right)
            node.right = invertTree(temp)

            return node
        }

        // Function to convert level order traversal to an array
        func levelOrderToArray(_ root: TreeNode?) -> [Int] {
            guard let root = root else {
                return []
            }

            var queue: [TreeNode?] = [root]
            var result: [Int] = []

            while !queue.isEmpty {
                let currentNode = queue.removeFirst()

                if let node = currentNode {
                    result.append(node.val)
                    queue.append(node.left)
                    queue.append(node.right)
                }
            }
            return result
        }

    }

    @Test("Input: root = [4,2,7,1,3,6,9], Output: [4,7,2,9,6,3,1]") func example1() {
        let solution = Solution()
        let root = TreeNode(4)
        root.left = TreeNode(2)
        root.right = TreeNode(7)
        root.left?.left = TreeNode(1)
        root.left?.right = TreeNode(3)
        root.right?.left = TreeNode(6)
        root.right?.right = TreeNode(9)
        let output = [4,7,2,9,6,3,1]
        let result = solution.invertTree(root)

        #expect(solution.levelOrderToArray(result) == output)
    }

    @Test("Input: root = [2,1,3], Output: [2,3,1]") func example2() {
        let solution = Solution()
        let root = TreeNode(2)
        root.left = TreeNode(1)
        root.right = TreeNode(3)
        let output = [2,3,1]
        let result = solution.invertTree(root)

        #expect(solution.levelOrderToArray(result) == output)
    }

    @Test("Input: root = [], Output: []") func example3() {
        let solution = Solution()
        let root: TreeNode? = nil
        let output: [Int] = []
        let result = solution.invertTree(root)

        #expect(solution.levelOrderToArray(result) == output)
    }

}
