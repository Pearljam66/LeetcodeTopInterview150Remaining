//
//  AverageLevelsBinaryTreeTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/28/24.
//

/*
 Given the root of a binary tree, return the average value of the nodes on each level in the form of an array. Answers within 10-5 of the actual answer will be accepted.

 Example 1:
 Input: root = [3,9,20,null,null,15,7]
 Output: [3.00000,14.50000,11.00000]
 Explanation: The average value of nodes on level 0 is 3, on level 1 is 14.5, and on level 2 is 11.
 Hence return [3, 14.5, 11].

 Example 2:
 Input: root = [3,9,20,15,7]
 Output: [3.00000,14.50000,11.00000]

 Constraints:
 The number of nodes in the tree is in the range [1, 104].
 -231 <= Node.val <= 231 - 1
 */

import Testing

struct AverageLevelsBinaryTreeTest {

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
        func averageOfLevels(_ root: TreeNode?) -> [Double] {
            guard let root = root else { return [] }

            var result: [Double] = []
            var queue: [TreeNode] = [root]

            while !queue.isEmpty {
                let size = queue.count
                var sum: Double = 0

                // Process all nodes at current level
                for _ in 0..<size {
                    let node = queue.removeFirst()
                    sum += Double(node.val)

                    // Add children to queue
                    if let left = node.left {
                        queue.append(left)
                    }
                    if let right = node.right {
                        queue.append(right)
                    }
                }

                // Calculate average for current level
                result.append(sum / Double(size))
            }

            return result
        }
    }

    @Test func example1() {
        let solution = Solution()
        let root = TreeNode(3, TreeNode(9), TreeNode(20, TreeNode(15), TreeNode(7)))
        #expect(solution.averageOfLevels(root) == [3.0, 14.5, 11.0])
    }

    @Test func example2() {
        let solution = Solution()
        let root = TreeNode(3, TreeNode(9), TreeNode(20, TreeNode(15), TreeNode(7)))
        #expect(solution.averageOfLevels(root) == [3.0, 14.5, 11.0])
    }

}
