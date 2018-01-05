require_relative "heap"

class Array
  def heap_sort!
    curr_pos = 0
    prc = Proc.new { |a,b| b <=> a }
    return if curr_pos == self.length
    while curr_pos < self.length
      BinaryMinHeap.heapify_up(self, curr_pos, &prc)
      curr_pos += 1
    end
    curr_pos = self.length - 1
    while curr_pos > 0
      self[0], self[curr_pos] = self[curr_pos], self[0]
      BinaryMinHeap.heapify_down(self, 0, curr_pos, &prc)
      curr_pos -= 1
    end
  end
end
