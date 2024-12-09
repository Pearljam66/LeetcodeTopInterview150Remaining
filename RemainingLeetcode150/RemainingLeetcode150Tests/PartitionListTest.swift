//
//  PartitionListTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/9/24.
//

/*
 Given the head of a linked list and a value x, partition it such that all nodes less than x come before nodes greater than or equal to x.
 You should preserve the original relative order of the nodes in each of the two partitions.

 Example 1:
 Input: head = [1,4,3,2,5,2], x = 3
 Output: [1,2,2,4,3,5]

 Example 2:
 Input: head = [2,1], x = 2
 Output: [1,2]

 Constraints:
 The number of nodes in the list is in the range [0, 200].
 -100 <= Node.val <= 100
 -200 <= x <= 200
 */

import Testing

struct PartitionListTest {

    class ListNode {
        var val: Int
        var next: ListNode?

        init() {
            self.val = 0
            self.next = nil
        }

        init(_ val: Int) {
            self.val = val
            self.next = nil
        }

        init (_ val: Int, _ next: ListNode?) {
            self.val = val
            self.next = next
        }
    }

    class Solution {
        func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
            let beforeDummy = ListNode(0)
            let afterDummy = ListNode(0)
            var before = beforeDummy
            var after = afterDummy

            var current = head
            while let node = current {
                if node.val < x {
                    before.next = node
                    before = node
                } else {
                    after.next = node
                    after = node
                }
                current = node.next
            }

            after.next = nil
            before.next = afterDummy.next

            return beforeDummy.next
        }
    }

    // Helper function to convert array to linked list
    func arrayToLinkedList(_ array: [Int]) -> ListNode? {
        guard let first = array.first else { return nil }
        let head = ListNode(first)
        var current = head
        for val in array.dropFirst() {
            let newNode = ListNode(val)
            current.next = newNode
            current = newNode
        }
        return head
    }

    // Helper function to convert linked list to array for easier assertion in tests
    func linkedListToArray(_ head: ListNode?) -> [Int] {
        var array: [Int] = []
        var current = head
        while let node = current {
            array.append(node.val)
            current = node.next
        }
        return array
    }

    @Test("Input: head = [1,4,3,2,5,2], x = 3, Output: [1,2,2,4,3,5]") func example1() {
        let solution = Solution()
        let node1 = ListNode(1)
        let node2 = ListNode(4)
        let node3 = ListNode(3)
        let node4 = ListNode(2)
        let node5 = ListNode(5)
        let node6 = ListNode(2)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        node5.next = node6
        let x = 3
        let output = [1, 2, 2, 4, 3, 5]
        let headConvertedToArray = linkedListToArray(solution.partition(node1, x))

        #expect(headConvertedToArray == output)
    }

    @Test("Input: head = [2,1], x = 2, Output: [1,2]") func example2() {
        let solution = Solution()
        let node1 = ListNode(2)
        let node2 = ListNode(1)
        node1.next = node2
        let x = 2
        let output = [1, 2]
        let headConvertedToArray = linkedListToArray(solution.partition(node1, x))

        #expect(headConvertedToArray == output)
    }

}
