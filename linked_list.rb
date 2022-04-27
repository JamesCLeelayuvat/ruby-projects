require "pry"

class LinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = new_node
    elsif @tail.nil?
      @tail = new_node
      @head.next_node = @tail
    else
      @tail.next_node = new_node
      @tail = new_node
    end
  end

  def prepend(value)
    new_node = Node.new(value, @head)
    @head = new_node
  end

  def size
    pointer = @head
    counter = 0
    until pointer.nil?
      counter += 1
      pointer = pointer.next_node
    end
    counter
  end

  def head()
    @head
  end

  def tail()
    @tail
  end

  def at(index)
    pointer = @head
    index.times do
      pointer = pointer.next_node
    end
    pointer
  end

  def pop
    @head
    pointer = @head
    (self.size - 1).times do
      if pointer.next_node == @tail
        p pointer
        @tail = pointer
        @tail.next_node = nil
        p @tail
      end
      pointer = pointer.next_node
    end
  end

  def contains?(value)
    pointer = @head
    until pointer.nil?
      if pointer.value == value
        return true
      end
      pointer = pointer.next_node
    end
    return false
  end

  def find(value)
    pointer = @head
    index = 0
    until pointer.nil?
      if pointer.value = value
        return index
      else
        index += 1
        pointer = pointer.next_node
      end
    end
  end

  def to_s
    pointer = @head
    until pointer.nil?
      print "( #{pointer.value} ) --> "
      pointer = pointer.next_node
    end

    print "nil"
  end
end

class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

linked_list = LinkedList.new
linked_list.append("A")
linked_list.append("B")
linked_list.prepend("C")
linked_list.to_s
puts
p linked_list.head
p linked_list.tail
p linked_list.at(1)
p linked_list.contains?("B")
p linked_list.find("C")
p linked_list.size
linked_list.pop
linked_list.to_s
