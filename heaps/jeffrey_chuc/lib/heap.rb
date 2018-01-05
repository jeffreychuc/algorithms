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
    @store[0], @store[-1] = @store[-1], @store[0]
    ret = @store.pop
    @store = BinaryMinHeap.heapify_down(@store, 0, &@prc)
    ret
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    curr_pos = self.count - 1
    @store = BinaryMinHeap.heapify_up(@store, curr_pos, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    base = 2 * parent_index
    ret = []
    2.times do |i|
      child = base + (i + 1)
      ret.push(child) if child < len
    end
    ret
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new {|a,b| a <=> b}
    curr_pos = parent_idx
    children_idx = BinaryMinHeap.child_indices(len, curr_pos)
    while !children_idx.empty?
      mapped_vals = children_idx.map {|i| [array[i], i] }
      mapped_vals = mapped_vals.to_h
      comp_vals = mapped_vals.keys
      if comp_vals.length > 1
        if prc.call(comp_vals[0], comp_vals[1]) < 0
          swap_idx = mapped_vals[comp_vals[0]]
        else
          swap_idx = mapped_vals[comp_vals[1]]
        end
        array[curr_pos], array[swap_idx] = array[swap_idx], array[curr_pos]
        curr_pos = swap_idx
        children_idx = BinaryMinHeap.child_indices(len, curr_pos)
      else
        if prc.call(comp_vals[0], array[curr_pos]) < 0
          swap_idx = mapped_vals[comp_vals[0]]
          array[curr_pos], array[swap_idx] = array[swap_idx], array[curr_pos]
        end
        break
      end
    end
    array
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
