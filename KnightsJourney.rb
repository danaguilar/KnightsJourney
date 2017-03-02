#Given a starting point, dynamically build a tree while searching
#Each node should have a value, parent and children. No child should be the same value as the parent
#When a match is found, return the node and go up the parents to get the moves

class Node
  attr_reader :coord, :parent, :children
  @@available_moves = [
    [-2,-1],
    [-2,1],
    [-1,-2],
    [-1,2],
    [1,-2],
    [1,2],
    [2,-1],
    [2,1]
  ]
  def initialize(coord, parent = nil)
    @coord = coord #in terms of [x,y]
    @parent = parent
    @children = []

  end

  def create_children
    legal_moves.each do |move|
      unless move[0] == @coord[0] and move[1] == @coord[1]
        new_move = Node.new(move, self)
        @children << new_move
      end
    end
  end

  def to_s
    return "Current Coordinates: #{@coord}
    Came from #{@parent.nil? ? "Nowhere" : @parent.coord}
    Can go:#{@children.each{|node| node.coord.inspect}}"
  end

  def legal_moves
    move = Array.new
    @@available_moves.each do |coord_array|
      if (@coord[0] + coord_array[0]).between?(0,7) and (@coord[1] + coord_array[1]).between?(0,7)
        move << [@coord[0] + coord_array[0], @coord[1] + coord_array[1]]
      end
    end
    return move
  end
end


def knight_moves(beginning_coords, ending_coords)
  beginning = Node.new(beginning_coords)
  beginning.create_children
  moves_to_check = beginning.children
  until moves_to_check.length == 0
    next_move = moves_to_check.shift
    return next_move if next_move.coord[0] == ending_coords[0] and next_move.coord[1] == ending_coords[1]
    next_move.create_children
    next_move.children.each do |child|
      moves_to_check << child
    end
  end
end

def print_results(node)
  move_path = Array.new
  count = 0
  until node.parent.nil?
    move_path.push(node.coord)
    node = node.parent
    count += 1
  end
  move_path.push(node.coord)
  move_path.reverse!
  puts "You made it in #{count} #{count == 1 ? "move" : "moves"}! Here is your path"
  move_path.each {|move| puts move.inspect}
end

print_results(knight_moves([0,0],[7,7]))
