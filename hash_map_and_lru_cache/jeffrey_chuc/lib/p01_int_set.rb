class MaxIntSet
  def initialize(max)
    @store = Array.new(max) { false }
    @length = max
  end

  def insert(num)
    raise 'Out of bounds' if !validate!(num)
    @store[num] = true
  end

  def remove(num)
    raise 'Out of bounds' if !validate!(num)
    @store[num] = false
  end

  def include?(num)
    raise 'Out of bounds' if !validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
    num >= 0 && num < @length
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets].push(num)
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @prev_num_buckets = num_buckets
  end

  def insert(num)
    if !self.include?(num)
      @store[num % num_buckets].push(num)
      @count += 1
      resize! if @count == num_buckets
    end
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(@prev_num_buckets * 2) { Array.new }
    @prev_num_buckets = @prev_num_buckets * 2
    # setting count to 0 because .insert changes count anyways.
    @count = 0
    old_store.flatten.each { |num| self.insert(num) }
  end
end
