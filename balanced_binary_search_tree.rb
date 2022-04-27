class Node
  attr_accessor :left_child, :right_child, :value

  def initialize(value, left_child = nil, right_child = nil)
    @value = value
    @left_child = left_child
    @right_child = right_child
  end
end

class Tree
  attr_accessor :tree

  def initialize(array = [])
    @array = array
    @sorted_array = array.uniq.sort
  end

  def build_tree(start_index = 0, end_index = @sorted_array.size - 1)
    if start_index > end_index
      return nil
    end
    mid_index = (start_index + end_index) / 2
    new_node = Node.new(@sorted_array[mid_index])
    new_node.left_child = build_tree(start_index, mid_index - 1)
    new_node.right_child = build_tree(mid_index + 1, end_index)
    @tree = new_node
    return new_node
  end

  def insert(value, node_pointer = @tree)
    if value > node_pointer.value
      if node_pointer.right_child.nil?
        node_pointer.right_child = Node.new(value)
      else
        insert(value, node_pointer.right_child)
      end
    else
      if node_pointer.left_child.nil?
        node_pointer.left_child = Node.new(value)
      else
        insert(value, node_pointer.left_child)
      end
    end
  end

  def delete(value, node_pointer = @tree)
    if node_pointer.nil?
      return
    end
    p node_pointer.right_child.value
    if node_pointer.left_child.value == value
      case

      when has_no_children?(node_pointer.left_child)
        node_pointer.left_child = nil
      when has_both_children?(node_pointer.left_child)
        leftmost = pop_leftmost(node_pointer.left_child)
        leftmost.left_child = node_pointer.left_child.left_child
        leftmost.right_child = node_pointer.left_child.right_child
        node_pointer.left_child = leftmost
      end
    elsif node_pointer.right_child.value == value
      case

      when has_no_children?(node_pointer.right_child)
        node_pointer.right_child = nil
      when has_both_children?(node_pointer.right_child)
        leftmost = pop_leftmost(node_pointer.right_child)
        leftmost.left_child = node_pointer.right_child.left_child
        leftmost.right_child = node_pointer.right_child.right_child
        node_pointer.right_child = leftmost
      end
    else
      delete(value, node_pointer.left_child)
      delete(value, node_pointer.right_child)
    end
  end

  def find(value, node_pointer = @tree)
    if node_pointer.nil?
      return nil
    elsif node_pointer.value == value
      return node_pointer
    elsif find(value, node_pointer.left_child).nil? == false
      return find(value, node_pointer.left_child)
    elsif find(value, node_pointer.right_child).nil? == false
      return find(value, node_pointer.right_child)
    end
    return nil
  end

  def level_order
    no_children = false
    queue = [@tree]
    return_array = []
    until no_children
      node = queue.shift
      queue.append(node.left_child) unless node.left_child.nil?
      queue.append(node.right_child) unless node.right_child.nil?
      if block_given?
        return_array.append(yield(node))
      else
        return_array.append(node.value)
      end
      if queue.empty?
        no_children = true
      end
    end
    return_array
  end

  def in_order(node_pointer = @tree, return_array = [], &block)
    if node_pointer.nil?
      return
    end
    pre_order(node_pointer.left_child, return_array, &block)
    return_array.append(yield(node_pointer))
    pre_order(node_pointer.right_child, return_array, &block)
    return_array
  end

  def pre_order(node_pointer = @tree, return_array = [], &block)
    if node_pointer.nil?
      return
    end
    return_array.append(yield(node_pointer))
    pre_order(node_pointer.left_child, return_array, &block)
    pre_order(node_pointer.right_child, return_array, &block)
    return_array
  end

  def post_order(node_pointer = @tree, return_array = [], &block)
    if node_pointer.nil?
      return
    end
    pre_order(node_pointer.left_child, return_array, &block)
    pre_order(node_pointer.right_child, return_array, &block)
    return_array.append(yield(node_pointer))
    return_array
  end

  def height(node, height = 0)
    if node.nil?
      return height - 1
    end
    left_node_height = height(node.left_child, height + 1)
    right_node_height = height(node.right_child, height + 1)
    if left_node_height > right_node_height
      return left_node_height
    else
      return right_node_height
    end
  end

  def pretty_print(node = @tree, prefix = "", is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? "│   " : "    "}", false) if node.right_child
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? "    " : "│   "}", true) if node.left_child
  end

  def depth(node, depth = 0, node_pointer = @tree)
    if node_pointer == node
      return depth
    elsif node_pointer == nil
      return -1
    end
    left_depth = depth(node, depth + 1, node_pointer.left_child)
    right_depth = depth(node, depth + 1, node_pointer.right_child)
    unless left_depth == -1
      return left_depth
    else
      return right_depth
    end
  end

  def balanced?(node_pointer = @tree)
    if node_pointer.nil?
      return true
    end

    unless balanced?(node_pointer.left_child) && (height(node_pointer.left_child) - height(node_pointer.right_child)).abs <= 1
      return false
    end
    unless balanced?(node_pointer.right_child) && (height(node_pointer.left_child) - height(node_pointer.right_child)).abs <= 1
      return false
    end
    return true
  end

  def rebalance()
    build_tree(create_array_from_tree)
  end

  def create_array_from_tree(node_pointer = @tree, array = [])
    if node_pointer.nil?
      return
    end
    array.append(node_pointer.value)
    create_array_from_tree(node_pointer.left_child, array)
    create_array_from_tree(node_pointer.right_child, array)
    return array
  end
end

def pop_leftmost(node_pointer)
  if node_pointer.left_child.left_child.nil?
    leftmost = node_pointer.left_child
    node_pointer.left_child = nil
    return leftmost
  else
    pop_leftmost(node_pointer.left_child)
  end
end

def has_no_children?(node)
  if node.right_child.nil? && node.left_child.nil?
    return true
  end
  return false
end

def has_both_children?(node)
  if node.right_child.nil? && node.left_child.nil?
    return false
  end
  return true
end

tree = Tree.new([1, 2, 3, 4, 5])
tree.build_tree
tree.pretty_print
p tree.create_array_from_tree()
