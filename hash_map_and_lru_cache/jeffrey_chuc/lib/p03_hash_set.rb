require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @prev_num_buckets = num_buckets
  end

  def insert(key)
    self[key].push(key)
    @count += 1
    resize! if @count == num_buckets
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
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
