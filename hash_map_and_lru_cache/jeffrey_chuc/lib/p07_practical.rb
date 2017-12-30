require_relative 'p05_hash_map'
require 'byebug'

def can_string_be_palindrome?(string)
  hm = HashMap.new
  string.split('').each do |c|
    tmp = hm.get(c)
    if tmp
      hm.set(c, tmp + 1)
    else
      hm.set(c, 1)
    end
  end
  even = 0
  odd = 0
  hm.each do |e|
    e[1] % 2 == 0 ? even += 1 : odd += 1
  end
  odd <= 1
end
