# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'
require 'byebug'

class QueueWithMax
  attr_accessor :store
  attr_reader :max

  def initialize
    @store = RingBuffer.new
    @max = RingBuffer.new
  end

  def enqueue(val)
    @store.unshift(val)
    # byebug
    if @max.length == 0
      # init the max queue
      @max.unshift(val)
    else
      tmp_max = RingBuffer.new
      val_buffer = RingBuffer.new
      val_buffer.push(val)
      # byebug
      (@max.length).times do |i|
        if ((val_buffer.length > 0 && @max.length > 0) && val_buffer[0] > @max[0])
          tmp_max.push(val_buffer.shift)
        end
        tmp_max.push(@max.shift)
      end
      @max = tmp_max
    end
    # p @store
    # p @max
    @store
  end

  def dequeue
    @max.pop
    @store.pop
  end

  def max
    return @store[0] if @store.length == 1
    @max[0]
  end

  def length
    @store.length
  end
end
