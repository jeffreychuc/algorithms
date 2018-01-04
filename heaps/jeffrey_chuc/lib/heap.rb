require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    curr_pos = self.count - 1
    @store = BinaryMinHeap.heapify_up(@store, curr_pos, @prc)
  end

  public
  def self.child_indices(len, parent_index)
  end

  def self.parent_index(child_index)
    (child_index - 1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new {|a,b| a <=> b}
    curr_pos = child_idx
    val = array[curr_pos]
    while curr_pos > 0
      parent_index = BinaryMinHeap.parent_index(curr_pos)
      if prc.call(array[curr_pos], array[parent_index]) < 0
        array[curr_pos] = array[parent_index]
        array[parent_index] = val
      end
      curr_pos = parent_index
    end
    array
  end
end
