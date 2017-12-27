class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    ret = ''
    self.each do |num|
      ret += num.to_s
    end
    ret.to_i
  end
end

class String
  # string hashing function
  # get ord of char, multiply
  def hash
    ret = 1
    self.length.times do |i|
      ret *= self[i].ord
      i = 1 if i == 0
      ret += i
    end
    ret
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    # get all KV pairs as array
    hash_keys = self.keys
    hash_pairs = Array.new
    (hash_keys.length).times do |i|
      hash_pairs[i] = [hash_keys[i], self[hash_keys[i]]]
    end
    # sort array of kv pairs by k
    hash_pairs.sort_by! { |pair| pair[0] }
    ret = 1
    hash_pairs.each do |pair|
      ret *= pair[0].object_id
      ret += pair[1].to_s.hash # uses above string hash function
    end
    ret
  end
end
