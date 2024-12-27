//
//  ConstructBinaryTreeInorderPostorderTraversalTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/27/24.
//

/*
 Given two integer arrays inorder and postorder where inorder is the inorder traversal of a binary tree and postorder is the postorder traversal of the same tree, construct and return the binary tree.

 Example 1:
 Input: inorder = [9,3,15,20,7], postorder = [9,15,7,20,3]
 Output: [3,9,20,null,null,15,7]

 Example 2:
 Input: inorder = [-1], postorder = [-1]
 Output: [-1]

 Constraints:
 1 <= inorder.length <= 3000
 postorder.length == inorder.length
 -3000 <= inorder[i], postorder[i] <= 3000
 inorder and postorder consist of unique values.
 Each value of postorder also appears in inorder.
 inorder is guaranteed to be the inorder traversal of the tree.
 postorder is guaranteed to be the postorder traversal of the tree.
 */

import Testing

struct ConstructBinaryTreeInorderPostorderTraversalTest {

    class TreeNode: Equatable {
        var val: Int
        var left: TreeNode?
        var right: TreeNode?

        init() {
            self.val = 0
            self.left = nil
            self.right = nil
        }

        init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
        }

        init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
            self.val = val
            self.left = left
            self.right = right
        }

        static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
            return isEqual(lhs, rhs)
        }

        private static func isEqual(_ node1: TreeNode?, _ node2: TreeNode?) -> Bool {
            if node1 == nil && node2 == nil {
                return true
            }
            guard let n1 = node1, let n2 = node2 else {
                return false
            }
            return n1.val == n2.val &&
            isEqual(n1.left, n2.left) &&
            isEqual(n1.right, n2.right)
        }
    }

    class Solution {
        func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
            guard !inorder.isEmpty, !postorder.isEmpty else {
                return nil
            }

            // The last element in postorder is the root
            let rootVal = postorder.last!
            let root = TreeNode(rootVal)

            // Find the position of the root in inorder array
            guard let rootIndex = inorder.firstIndex(of: rootVal) else {
                return nil
            }

            // Elements before rootIndex in inorder are left subtree
            let leftInorder = Array(inorder[0..<rootIndex])
            // Elements after rootIndex in inorder are right subtree
            let rightInorder = Array(inorder[(rootIndex + 1)...])

            // Corresponding parts in postorder
            let leftPostorder = Array(postorder[0..<leftInorder.count])
            let rightPostorder = Array(postorder[leftInorder.count..<(postorder.count - 1)])

            root.left = buildTree(leftInorder, leftPostorder)
            root.right = buildTree(rightInorder, rightPostorder)

            return root
        }
    }

    @Test func testExample1() {
        let inorder = [9, 3, 15, 20, 7]
        let postorder = [9, 15, 7, 20, 3]
        let expectedTree = TreeNode(3,
                                    TreeNode(9),
                                    TreeNode(20, TreeNode(15), TreeNode(7)))
        let resultTree = Solution().buildTree(inorder, postorder)
        #expect(resultTree == expectedTree)
    }

    @Test func testExample2() {
        let inorder = [-1]
        let postorder = [-1]
        let expectedTree = TreeNode(-1)
        let resultTree = Solution().buildTree(inorder, postorder)
        #expect(resultTree == expectedTree)
    }
}

