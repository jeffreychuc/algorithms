# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative 'bst_node'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value, curr_node = @root)
    if @root.nil?
      @root = BSTNode.new(value)
    else
      if curr_node.value > value
        if curr_node.left.nil?
          curr_node.left = BSTNode.new(value, curr_node)
        else
          curr_node = curr_node.left
          self.insert(value, curr_node)
        end
      elsif curr_node.value < value
        if curr_node.right.nil?
          curr_node.right = BSTNode.new(value, curr_node)
        else
          curr_node = curr_node.right
          self.insert(value, curr_node)
        end
      end
    end
  end

  def find(value, tree_node = @root)
    if tree_node.nil?
      return nil
    elsif tree_node.value == value
      return tree_node
    else
      if tree_node.value > value
        self.find(value, tree_node.left)
      elsif tree_node.value < value
        self.find(value, tree_node.right)
      end
    end
  end

  def delete(value)
    node = self.find(value)
    return false if node.nil?
    # no children for node
    if node == @root
      @root = nil
    elsif node.left.nil? && node.right.nil?
      # case for node with no children
      (node.parent.value > node.value) ? node.parent.left = nil : node.parent.right = nil
      node.parent = nil
    elsif (node.left.nil? && !node.right.nil?) || (!node.left.nil? && node.right.nil?)
      # case for node with one child
      node.left.nil? ? child = node.right : child = node.left
      (node.parent.left == node) ? node.parent.left = child : node.parent.right = child
      node.parent = nil
      node = nil
    else
      # case for target with 2 children
      replacement = self.maximum(node.left)
      value = replacement.value
      self.delete(replacement.value)
      node.value = value
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node if tree_node.right.nil?
    self.maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    return -1 if tree_node.nil?
    return [1 + self.depth(tree_node.left), 1 + self.depth(tree_node.right)].max
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?
    return true if (((self.depth(tree_node.left) - self.depth(tree_node.right)).abs <= 1) && (self.is_balanced?(tree_node.left) && self.is_balanced?(tree_node.right)))
    false
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return [] if tree_node.nil?
    return self.in_order_traversal(tree_node.left) + [tree_node.value] + self.in_order_traversal(tree_node.right)
  end


  private
  # optional helper methods go here:

end
