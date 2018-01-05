require_relative 'heap'

def k_largest_elements(array, k)
  curr_pos = 0
  prc = Proc.new { |a,b| b <=> a }
  return if curr_pos == array.length
  while curr_pos < array.length
    BinaryMinHeap.heapify_up(array, curr_pos, &prc)
    curr_pos += 1
  end
  curr_pos = array.length - 1
  while curr_pos >= array.length - k
    array[0], array[curr_pos] = array[curr_pos], array[0]
    BinaryMinHeap.heapify_down(array, 0, curr_pos, &prc)
    curr_pos -= 1
  end
  array[array.length-k..-1]
end
