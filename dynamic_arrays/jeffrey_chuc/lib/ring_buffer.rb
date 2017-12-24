require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @start_idx = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    self.check_index(index)
    @store[translate_index(index)]
  end

  # O(1)
  def []=(index, val)
    self.check_index(index)
    @store[translate_index(index)] = val
  end

  # O(1)
  def pop
    self.check_removal
    @length -= 1
    @store[translate_index(@length)]
  end

  # O(1) ammortized
  def push(val)
    self.resize! if @length == @capacity
    @store[translate_index(@length)] = val
    @length += 1
    @store
  end

  # O(1)
  def shift
    self.check_removal
    ret_val = @store[@start_idx]
    @start_idx += 1
    @start_idx %= @capacity
    @length -= 1
    ret_val
  end

  # O(1) ammortized
  def unshift(val)
    self.resize! if @length == @capacity
    @start_idx -= 1
    (@start_idx = (@start_idx + @capacity) % @capacity) if @start_idx < 0
    @store[@start_idx] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_removal
    raise 'index out of bounds' if @length == 0
  end

  def check_index(index)
    raise "index out of bounds" if (index + 1) > @length
  end

  def translate_index(index)
    ((start_idx + index) % @capacity)
  end

  def resize!
    tmp_store = StaticArray.new(@capacity * 2)
    new_coords = (((@capacity*2) - @start_idx)..((@capacity*2) - @start_idx + @length - 1)).to_a
    old_coords = ((@start_idx)..(@start_idx + @length-1)).to_a
    @length.times do |i|
      tmp_store[new_coords[i] % (@capacity * 2)] = @store[old_coords[i] % @capacity]
    end
    @store = tmp_store
    @capacity = @capacity * 2
    @start_idx = @capacity - @start_idx
  end
end
