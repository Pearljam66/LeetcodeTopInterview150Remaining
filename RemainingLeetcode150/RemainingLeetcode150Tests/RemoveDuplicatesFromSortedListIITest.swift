//
//  RemoveDuplicatesFromSortedListIITest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/5/24.
//

/*
 Given the head of a sorted linked list, delete all nodes that have duplicate numbers, leaving only distinct numbers from the original list. Return the linked list sorted as well.

 Example 1:
 Input: head = [1,2,3,3,4,4,5]
 Output: [1,2,5]

 Example 2:
 Input: head = [1,1,1,2,3]
 Output: [2,3]

 Constraints:
 The number of nodes in the list is in the range [0, 300].
 -100 <= Node.val <= 100
 The list is guaranteed to be sorted in ascending order.
 */

import Testing

struct RemoveDuplicatesFromSortedListIITest {

    class ListNode {
        var val: Int
        var next: ListNode?

        init () {
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

        func deleteDuplicates(_ head: ListNode?) -> ListNode? {
            // Dummy node to handle the case where the head itself is a duplicate.
            let dummy = ListNode(0, head)
            var previousNode = dummy
            var currentNode = head

            while currentNode != nil && currentNode?.next != nil {
                // If this node is the start of the duplicates.
                if currentNode?.val == currentNode?.next?.val {
                    // Store the value to skip all of the duplicates.
                    let valueToSkip = currentNode?.val

                    // Skip all the nodes with this value.
                    while currentNode != nil && currentNode?.val == valueToSkip {
                        currentNode = currentNode!.next
                    }

                    // Connect previous node to the current node, skipping all duplicates.
                    previousNode.next = currentNode
                } else {
                    // If no duplicates, move both pointers forward.
                    previousNode = currentNode!
                    currentNode = currentNode?.next
                }
            }
            return dummy.next
        }

    }

    // Helper function to convert ListNode to Array for comparison
    func convertListNodeToArray(_ head: ListNode?) -> [Int] {
        var result: [Int] = []
        var current = head

        while current != nil {
            result.append(current!.val)
            current = current!.next
        }

        return result
    }

    @Test func example1() {
        let head = ListNode(1, ListNode(2, ListNode(3, ListNode(3, ListNode(4, ListNode(4, ListNode(5, nil)))))))

        let solution = Solution()
        let result = solution.deleteDuplicates(head)

        let expected = ListNode(1, ListNode(2, ListNode(5, nil)))
        #expect(convertListNodeToArray(result) == convertListNodeToArray(expected))
    }

    @Test func example2() {
        let head = ListNode(1, ListNode(1, ListNode(1, ListNode(2, ListNode(3, nil)))))

        let solution = Solution()
        let result = solution.deleteDuplicates(head)

        let expected = ListNode(2, ListNode(3, nil))
        #expect(convertListNodeToArray(result) == convertListNodeToArray(expected))
    }

}
