
require 'set'

class GuardGavillant

  DIRECTIONS = {
    'up' => [0, -1],
    'down' => [0, 1],
    'left' => [-1, 0],
    'right' => [1, 0]
  }

  attr_accessor :grid, :position, :direction, :result_positions
  def initialize
    @grid = File.read('input.txt').split("\n").map { |line| line.split('') }
    @position = nil
    @grid.each_with_index do |row, y|
      x = row.index('^')
      if x
        @position = [x, y]
        break
      end
    end
    @direction = 'up'
  end

  def part1
    guard_positions = Set.new
    obstruction_positions = []
    until outside_grid?
      guard_positions.add(position)
      move_or_turn_guard
      if possible_obstruction_position?(guard_positions)
        obstruction_positions << position
      end
    end
    puts guard_positions.size
  end

  private

  def possible_obstruction_position?(guard_positions)
    next_direction = turn
    guard_positions.include?([position, next_direction])
  end

  def move_or_turn_guard
    if next_position == '#'
      @direction = turn
    else
      @position = move
    end
  end

  def turn
    case direction
    when 'up' then 'right'
    when 'right' then 'down'
    when 'down' then 'left'
    when 'left' then 'up'
    end
  end

  def move
    x, y = position
    dx, dy = DIRECTIONS[direction]
    [x + dx, y + dy]
  end

  def next_position
    x, y = position
    dx, dy = DIRECTIONS[direction]
    grid[y + dy][x + dx]
  end

  def outside_grid?
    x, y = position
    x < 0 || x >= grid[0].size || y < 0 || y >= grid.size
  end
end

guard = GuardGavillant.new
guard.part1
guard.part2
