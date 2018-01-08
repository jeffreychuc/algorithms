class BSTNode

  attr_accessor :left, :right, :parent, :value

  def initialize(value, parent = nil)
    @value = value
    @parent = parent
  end
end
