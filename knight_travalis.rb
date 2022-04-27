def knight_moves(from, to)
  board = Array.new(8, Array.new(8, 0))
  root = Node.new(from)
  create_moves_tree(root)
  p root
end

def create_moves_tree(node_pointer, count = 0, root = node_pointer)
  if count == 6
    return root
  end
  starting_from = node_pointer.value
  moves_array = []
  moves_array.append(Node.new([starting_from[0] + 1, starting_from[1] + 2], nil, node_pointer)) if on_the_board?(starting_from[0] + 1, starting_from[1] + 2)
  moves_array.append(Node.new([starting_from[0] - 1, starting_from[1] + 2], nil, node_pointer)) if on_the_board?(starting_from[0] - 1, starting_from[1] + 2)
  moves_array.append(Node.new([starting_from[0] + 1, starting_from[1] - 2], nil, node_pointer)) if on_the_board?(starting_from[0] + 1, starting_from[1] - 2)
  moves_array.append(Node.new([starting_from[0] - 1, starting_from[1] - 2], nil, node_pointer)) if on_the_board?(starting_from[0] - 1, starting_from[1] - 2)
  moves_array.append(Node.new([starting_from[0] + 2, starting_from[1] + 1], nil, node_pointer)) if on_the_board?(starting_from[0] + 2, starting_from[1] + 1)
  moves_array.append(Node.new([starting_from[0] + 2, starting_from[1] - 1], nil, node_pointer)) if on_the_board?(starting_from[0] + 2, starting_from[1] - 1)
  moves_array.append(Node.new([starting_from[0] - 2, starting_from[1] + 1], nil, node_pointer)) if on_the_board?(starting_from[0] - 2, starting_from[1] + 1)
  moves_array.append(Node.new([starting_from[0] - 2, starting_from[1] - 1], nil, node_pointer)) if on_the_board?(starting_from[0] - 2, starting_from[1] - 1)
  node_pointer.next_nodes = moves_array
  node_pointer.next_nodes.each { |node| create_moves_tree(node, count + 1, root) }
end

def on_the_board?(x, y)
  if x < 8 && x > -1 && y < 8 && y > -1
    return true
  end
  return false
end

def find_shortest_move(node_pointer, count = 0, to)
  node_pointer.next_nodes.each do |node|
    if node.value == to
      return node
    end
  end
end

def find_shortest_move(node_pointer, count = 0, to)
  if (node_pointer.value == to)
    return node_pointer
  end
  shortest_node = nil
  node_pointer.next_nodes.each do |node|
    if node.value == to
      shortest_node = node
    end
  end
  unless shortest_node.nil?
    return shortest_node
  end
  node_pointer.next_nodes.each do |node|
    find_shortest_move(node, count + 1, to)
  end
end

def find_shortest_move(node_pointer, count = 0, to)
  if node_pointer.nil?
    return nil
  end
  if node_pointer.value == to
    return count
  end

  node_pointer.next_nodes.min(1) do |a, b|
    if find_shortest_move(a, count + 1, to).nil? && find_shortest_move(b, count + 1, to).nil?
      return nil
    elsif find_shortest_move(a, count + 1, to).nil?
      return find_shortest_move(b, count + 1, to).value
    elsif find_shortest_move(b, count + 1, to).nil?
      return find_shortest_move(a, count + 1, to).value
    end
  end
end

class Node
  attr_accessor :value, :next_nodes, :previous_node

  def initialize(value, next_nodes = nil, previous_node = nil)
    @previous_node = previous_node
    @value = value
    @next_nodes = next_nodes
  end
end

knight_moves(1, 1)
