//
//  SameTreeTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/11/24.
//

/*
 Given the roots of two binary trees p and q, write a function to check if they are the same or not.
 Two binary trees are considered the same if they are structurally identical, and the nodes have the same value.

 Example 1:
 Input: p = [1,2,3], q = [1,2,3]
 Output: true

 Example 2:
 Input: p = [1,2], q = [1,null,2]
 Output: false

 Example 3:
 Input: p = [1,2,1], q = [1,1,2]
 Output: false

 Constraints:
 The number of nodes in both trees is in the range [0, 100].
 -104 <= Node.val <= 104
 */

import Testing

struct SameTreeTest {

    class TreeNode {
        let val: Int
        var left: TreeNode?
        var right: TreeNode?

        init () {
         self.val = 0
         self.left = nil
         self.right = nil
        }

        init(_ val: Int) {
         self.val = val
        }

        init (_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
            self.val = val
            self.left = left
            self.right = right
        }
    }

    class Solution {
        func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
            // Base case: if one node is nil, they should both be nil to be the same
            if p == nil && q == nil {
                return true
            }
            if p == nil || q == nil {
                return false
            }

            // Check if the current nodes have the same value
            if p!.val != q!.val {
                return false
            }

            // Recursively check left and right subtrees
            return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
        }
    }

    @Test func example1() {
        let p = TreeNode(1)
        p.left = TreeNode(2)
        p.right = TreeNode(3)

        let q = TreeNode(1)
        q.left = TreeNode(2)
        q.right = TreeNode(3)

        #expect(Solution().isSameTree(p, q) == true)
    }

    @Test func example2() {
        let p = TreeNode(1)
        p.left = TreeNode(2)

        let q = TreeNode(1)
        q.right = TreeNode(2)

        #expect(Solution().isSameTree(p, q) == false)
    }

    @Test func example3() {
        let p = TreeNode(1)
        p.left = TreeNode(2)
        p.right = TreeNode(1)

        let q = TreeNode(1)
        q.left = TreeNode(1)
        q.right = TreeNode(2)

        #expect(Solution().isSameTree(p, q) == false)
    }
}
