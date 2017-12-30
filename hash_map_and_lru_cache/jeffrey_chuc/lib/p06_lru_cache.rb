require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    # if key exists, move to front of LL and return value
    # else calc and store into LL, eject last one if LL.length > @max
    if @map.include?(key)
      node_to_move = @map[key]
      @map[key].remove
      @map[key] = @store.append(node_to_move.key, node_to_move.val)
    else
      @map[key] = @store.append(key, @prc.call(key))
    end
    eject! if count > @max
    @map[key].val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
  end

  def eject!
    @map.delete(@store.first.key)
    @store.remove(@store.first.key)
  end
end
