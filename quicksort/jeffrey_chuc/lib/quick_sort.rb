class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array[0]
    left = []
    right = []
    array[1..-1].each do |el|
      if el <= pivot
        left.push(el)
      else
        right.push(el)
      end
    end
    QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length <= 1
    pivot = QuickSort.partition(array, start, length, &prc)
    QuickSort.sort2!(array, start, pivot - start, &prc)
    QuickSort.sort2!(array, pivot + 1, length - pivot - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new{ |a,b| a<=>b }
    partition = start
    (start + 1..(start + length - 1)).each do |i|
      if prc.call(array[i], array[start]) == -1
        partition += 1
        if partition != i
          array[i], array[partition] = array[partition], array[i]
        end
      end
    end
    # array.each_with_index do |el, i|
    #   next if i < start
    #   if prc.call(el, array[start]) == -1
    #     partition += 1
    #     if partition != i
    #       array[i], array[partition] = array[partition], array[i]
    #     end
    #   end
    # end
    array[start], array[partition] = array[partition], array[start]
    partition
  end
end
