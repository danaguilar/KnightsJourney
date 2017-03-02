class Node
  attr_accessor :value, :left, :right
  def initialize(value)
    @value = value
  end

  def to_s
    return "value: #{@value.to_s}"
  end
end


def build_tree(array)
  root_node = nil
  array.each do |element|
    unless root_node.nil?
      append_to_tree(element, root_node)
    else
      root_node = Node.new(element)
    end
  end
  return root_node
end

def append_to_tree(value,node)
  if value < node.value
    if node.left.nil?
      new_node = Node.new(value)
      node.left = new_node
    else
      append_to_tree(value,node.left)
    end
  elsif value > node.value
    if node.right.nil?
      new_node = Node.new(value)
      node.right = new_node
    else
      append_to_tree(value,node.right)
    end
  else
  end
end

def print_tree(root_node)
  nodes_to_process = [root_node]
  until nodes_to_process.length == 0
    processing_node = nodes_to_process.shift
    nodes_to_process << processing_node.left unless processing_node.left.nil?
    nodes_to_process << processing_node.right unless processing_node.right.nil?
    puts "value: #{processing_node.value}: Left: #{processing_node.left}  Right: #{processing_node.right}"
  end
end



def breadth_first_search(value,root_node)
  nodes_to_process = [root_node]
  count = 0
  until nodes_to_process.length == 0
    processing_node = nodes_to_process.shift
    if processing_node.value == value
      puts "Found in #{count} steps"
      return processing_node
    end
    nodes_to_process << processing_node.left unless processing_node.left.nil?
    nodes_to_process << processing_node.right unless processing_node.right.nil?
    count += 1
  end
  return "not found"
end

def depth_first_search(value, root_node)
  puts "value is :#{value} and node is: #{root_node.nil? ? "nil" : root_node.value}"
  if value < root_node.value
    puts "checking left"
    return depth_first_search(value,root_node.left) unless root_node.left.nil?
    return nil
  elsif value > root_node.value
    puts "checking right"
    return depth_first_search(value,root_node.right) unless root_node.right.nil?
    return 'nothing found'
  else
    return root_node
  end
end



root_node = build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
#puts breadth_first_search(5, root_node)
puts depth_first_search(10, root_node)
