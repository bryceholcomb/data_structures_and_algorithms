class Pathfinder
  # coordinates are [y,x]
  def solve(landscape)

    visited_locs = []
    queue = [Node.new(*landscape.start)]
    curr_node = [-1,-1]

    until spots_around(landscape.finish, landscape).map(&:to_a).include? curr_node.to_a
      curr_node = queue.shift
      queue += spots_around(curr_node, landscape).reject { |coord| visited_locs.include? coord.to_a }
      visited_locs << curr_node.to_a
    end

    curr_node.full_tree
  end

  def spots_around(last_node, bounds)
    coords = last_node.to_a
    [[coords[0] - 1, coords[1]], [coords[0] + 1, coords[1]],
    [coords[0], coords[1] - 1], [coords[0], coords[1] + 1]]
    .map { |cords| Node.new(*cords, last_node) }
    .reject { |node| bounds.at(*node.to_a) == "#" }
  end
end

class Node
  attr_reader :x, :y, :from
  def initialize(x, y, from = nil)
    @x, @y, @from = x, y, from
  end

  def full_tree
    from ? from.full_tree + [to_a] : []
  end

  def to_a
    [x, y]
  end
end
