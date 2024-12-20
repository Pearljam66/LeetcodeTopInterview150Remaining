//
//  SymmetricTreeTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/20/24.
//

/*
 Given the root of a binary tree, check whether it is a mirror of itself (i.e., symmetric around its center).

 Example 1:
 Input: root = [1,2,2,3,4,4,3]
 Output: true

 Example 2:
 Input: root = [1,2,2,null,3,null,3]
 Output: false

 Constraints:
 The number of nodes in the tree is in the range [1, 1000].
 -100 <= Node.val <= 100
 */

import Testing

struct SymmetricTreeTest {

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
        func isSymmetric(_ root: TreeNode?) -> Bool {
            guard let root = root else { return true }
            return isMirror(root.left, root.right)
        }

        private func isMirror(_ left: TreeNode?, _ right: TreeNode?) -> Bool {
            // If both nodes are nil, they are symmetric
            if left == nil && right == nil {
                return true
            }

            // If only one node is nil, they are not symmetric
            if left == nil || right == nil {
                return false
            }

            return left?.val == right?.val &&
            isMirror(left?.left, right?.right) &&
            isMirror(left?.right, right?.left)
        }
    }

    @Test func example1() {
        let solution = Solution()
        let root = TreeNode(1)
        root.left = TreeNode(2)
        root.right = TreeNode(2)
        root.left?.left = TreeNode(3)
        root.left?.right = TreeNode(4)
        root.right?.left = TreeNode(4)
        root.right?.right = TreeNode(3)

        #expect(solution.isSymmetric(root) == true)
    }

    @Test func example2() {
        let solution = Solution()
        let root = TreeNode(1)
        root.left = TreeNode(2)
        root.right = TreeNode(2)
        root.left?.left = TreeNode(3)
        root.right?.left = TreeNode(3)

        #expect(solution.isSymmetric(root) == false)
    }

}
