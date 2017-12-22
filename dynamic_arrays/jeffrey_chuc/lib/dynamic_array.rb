require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    self.check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    self.check_index(index)
    @store[index] = value
    @store
  end

  # O(1)
  def pop
    self.check_removal
    @length -= 1
    ret_val = @store[@length]
    @store[@length] = nil
    ret_val
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    self.resize! if @length == @capacity
    @store[@length] = val
    @length += 1
    @store
  end

  # O(n): has to shift over all the elements.
  def shift
    self.check_removal
    tmp_store = StaticArray.new(@capacity)
    (1..@length).each do |i|
      tmp_store[i-1] = @store[i]
    end
    ret_val = @store[0]
    @store = tmp_store
    @length -= 1
    ret_val
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    self.resize! if @length == @capacity
    tmp_store = StaticArray.new(@capacity)
    tmp_store[0] = val
    (0...@length).each do |i|
      tmp_store[i+1] = @store[i]
    end
    @store = tmp_store
    @length += 1
    # byebug
    @store
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_removal
    raise 'index out of bounds' if @length == 0
  end

  def check_index(index)
    raise "index out of bounds" if (index + 1) > @length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    tmp_store = StaticArray.new(@capacity * 2)
    # @store.each_with_index do |val, i|
    #   tmp_store[i] = val
    # end
    (0..@capacity).each do |i|
      tmp_store[i] = @store[i]
    end
    @store = tmp_store
    @capacity = @capacity * 2
  end
end
