//
//  RotateListTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/6/24.
//

/*
 Given the head of a linked list, rotate the list to the right by k places.

 Example 1:
 Input: head = [1,2,3,4,5], k = 2
 Output: [4,5,1,2,3]

 Example 2:
 Input: head = [0,1,2], k = 4
 Output: [2,0,1]

 Constraints:
 The number of nodes in the list is in the range [0, 500].
 -100 <= Node.val <= 100
 0 <= k <= 2 * 109
 */

import Testing

struct RotateListTest {

    class ListNode {
        var val: Int
        var next: ListNode?

        init() {
            self.val = 0
            self.next = nil
        }

        init (_ val: Int) {
            self.val = val
            self.next = nil
        }

        init (_ val: Int, _ next: ListNode?) {
            self.val = val
            self.next = next
        }
    }

    class Solution {
        func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
            // Handle edge cases
            if head == nil || head?.next == nil || k == 0 {
                return head
            }

            // Calculate length of the list
            var length = 1
            var tail = head
            while tail?.next != nil {
                length += 1
                tail = tail?.next
            }

            // Calculate effective rotation
            let effectiveRotation = k % length
            if effectiveRotation == 0 {
                return head
            }

            // Find new tail position
            var newTail = head
            for _ in 0..<(length - effectiveRotation - 1) {
                newTail = newTail?.next
            }

            // Perform rotation
            let newHead = newTail?.next
            newTail?.next = nil
            tail?.next = head

            return newHead
        }
    }

    // Helper function to create linked list from array
    func createLinkedList(_ arr: [Int]) -> ListNode? {
        guard !arr.isEmpty else { return nil }

        let head = ListNode(arr[0])
        var current = head

        for i in 1..<arr.count {
            current.next = ListNode(arr[i])
            current = current.next!
        }

        return head
    }

    // Helper function to convert linked list to array
    func linkedListToArray(_ head: ListNode?) -> [Int] {
        var result: [Int] = []
        var current = head

        while current != nil {
            result.append(current!.val)
            current = current?.next
        }

        return result
    }

    @Test func example1() {
        let solution = Solution()
        let input = createLinkedList([1, 2, 3, 4, 5])
        let result = solution.rotateRight(input, 2)
        assert(linkedListToArray(result) == [4, 5, 1, 2, 3])
    }

    @Test func example2() {
        let solution = Solution()
        let input = createLinkedList([0, 1, 2])
        let result = solution.rotateRight(input, 4)
        assert(linkedListToArray(result) == [2, 0, 1])
    }

}
