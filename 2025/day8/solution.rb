# Disjointed Set Union (DSU)
class DSU
  def initialize(n)
    @parent = Array.new(n) { |i| i }
    @rank   = Array.new(n, 0)
  end

  def find(x)
    # path compression
    @parent[x] == x ? x : @parent[x] = find(@parent[x])
  end

  def union(a, b)
    ra, rb = find(a), find(b)
    return false if ra == rb

    # union by rank
    if @rank[ra] < @rank[rb]
      @parent[ra] = rb
    elsif @rank[rb] < @rank[ra]
      @parent[rb] = ra
    else
      @parent[rb] = ra
      @rank[ra] += 1
    end

    true
  end
end

class Playground
  attr_reader :junctions
  def initialize(input = 'input.txt')
    @junctions = File.read(input).split("\n")
  end

  def calculate_distances
    distances = []
    (0...junctions.length - 1).each do |i|
      (i + 1...junctions.length).each do |j|
        distance = euclidean_distance(junctions[i], junctions[j])
        distances << [distance, i, j]
      end
    end
    distances.sort_by(&:first)
  end

  def euclidean_distance(junction1, junction2)
    x1, y1, z1 = junction1.split(',').map(&:to_i)
    x2, y2, z2 = junction2.split(',').map(&:to_i)
    (x1 - x2)**2 + (y1 - y2)**2 + (z1 - z2)**2 # don't need to sqrt because we're sorting by distance
  end

  def self.test_part1
    self.new('test.txt').circuits(10)
  end

  def self.part1
    self.new.circuits(1000)
  end

  def self.test_part2
    self.new('test.txt').last_connected_junctions
  end

  def self.part2
    self.new.last_connected_junctions
  end

  def circuits(iterations)
    distances = calculate_distances
    n = junctions.length
    dsu = DSU.new(n)
  
    distances.take(iterations).each do |distance, i, j|
      dsu.union(i, j)
    end
  
    components = Hash.new { |h, k| h[k] = [] }
    (0...n).each do |i|
      root = dsu.find(i)
      components[root] << i
    end
  
    sizes = components.values.map(&:size).sort.reverse
    sizes.first(3).inject(1, :*)
  end

  def last_connected_junctions
    distances = calculate_distances
    n = junctions.length
    dsu = DSU.new(n)
    last_connected_result = nil
    components = n

    distances.each do |distance, i, j|
      break if components == 1
      if dsu.union(i, j)
        components -= 1
        last_connected_result = multiply_x_coordinates(junctions[i], junctions[j])
      end
    end
    last_connected_result
  end

  def multiply_x_coordinates(junction1, junction2)
    x1, y1, z1 = junction1.split(',').map(&:to_i)
    x2, y2, z2 = junction2.split(',').map(&:to_i)
    x1 * x2
  end
end

puts Playground.test_part1
puts Playground.part1
puts Playground.test_part2
puts Playground.part2
