
class Laboratory
  attr_accessor :grid
  def initialize(input = 'input.txt')
    @grid = File.read(input).split("\n").map(&:chars)
  end

  def self.part1
    self.new.total_beam_splits
  end

  def self.test_part1
    self.new('test.txt').total_beam_splits
  end

  def self.test_part2
    self.new('test.txt').many_worlds
  end

  def self.part2
    self.new.many_worlds
  end

  def total_beam_splits
    beam_positions = []
    splits = 0
    grid.each_with_index do |row, y|
      if row.include?('S')
        beam_positions << row.index('S')
        next
      end

      splitter_positions = row.each_index.select { |i| row[i] == '^' }
      next if splitter_positions.empty?

      new_beam_positions = beam_positions.dup
      splitter_positions.each do |position|
        if beam_positions.include?(position)
          splits += 1
          new_beam_positions << position - 1
          new_beam_positions << position + 1
          new_beam_positions.delete(position)
        end
      end
      beam_positions = new_beam_positions.uniq
    end
    splits
  end

  def many_worlds(world = nil, memo = {})
    if world.nil?
      start_row = 0
      start_col = grid[0].index('S')
      return many_worlds([start_row + 1, start_col], memo)
    end

    row, col = world
    key = [row, col]
    return memo[key] if memo.key?(key)

    return 1 if row >= grid.length

    return 0 if col < 0 || col >= grid[row].length

    cell = grid[row][col]

    memo[key] =
      if cell == '^'
        many_worlds([row + 1, col - 1], memo) +
          many_worlds([row + 1, col + 1], memo)
      else
        many_worlds([row + 1, col], memo)
      end
  end
end

# puts Laboratory.test_part1
# puts Laboratory.part1

# puts Laboratory.test_part2
puts Laboratory.part2