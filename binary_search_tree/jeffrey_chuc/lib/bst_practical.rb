require_relative 'binary_search_tree'

def kth_largest(tree_node, k)
  new_tree = BinarySearchTree.new
  new_tree.root = tree_node
  new_tree.find(new_tree.in_order_traversal[-k])
end
