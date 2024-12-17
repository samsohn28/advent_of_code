# frozen_string_literal: true

require 'set'

class ResonantCollinearity
  attr_reader :grid, :antenna_positions
  def initialize
    @grid = File.read('input.txt').split("\n").map { |line| line.split('') }
    @antenna_positions = Hash.new { |h, k| h[k] = [] }
    fill_antenna_positions
  end

  def part1
    antinodes = find_antinodes
    puts antinodes.size
  end

  def part2
    antinodes = find_antinodes(resonant_harmonics: true)
    puts antinodes.size
  end

  private

  def find_antinodes(resonant_harmonics: false)
    antinodes = Set.new
    antenna_positions.each_value do |positions|
      positions.combination(2) do |position1, position2| # More readable than each_with_index + slice
        slope_x = position2[0] - position1[0]
        slope_y = position2[1] - position1[1]
        antinode_positions = resonant_harmonics ?
                               calculate_all_antinode_positions(position1, position2, slope_x, slope_y) :
                               calculate_antinode_positions(position1, position2, slope_x, slope_y)
        antinode_positions.each { |antinode| antinodes.add(antinode) unless out_of_bounds?(antinode) }
      end
    end
    antinodes
  end

  def calculate_antinode_positions(position1, position2, slope_x, slope_y)
    antinode_1 = [position1[0] - slope_x, position1[1] - slope_y]
    antinode_2 = [position2[0] + slope_x, position2[1] + slope_y]
  
    [antinode_1, antinode_2]
  end

  def calculate_all_antinode_positions(position1, position2, slope_x, slope_y)
    left_antinodes = next_antinode(position1, slope_x, slope_y, 'left')
    right_antinodes = next_antinode(position2, slope_x, slope_y, 'right')
    left_antinodes + right_antinodes
  end

  def next_antinode(position, slope_x, slope_y, direction)
    return [] if out_of_bounds?(position)

    if direction == 'left'
      next_antinode([position[0] - slope_x, position[1] - slope_y], slope_x, slope_y, direction) << position
    else
      next_antinode([position[0] + slope_x, position[1] + slope_y], slope_x, slope_y, direction) << position
    end
  end

  def out_of_bounds?(position)
    position[0] < 0 || position[0] >= grid.length || position[1] < 0 || position[1] >= grid[0].length
  end

  def fill_antenna_positions
    grid.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        antenna_positions[cell] << [row_index, col_index] unless cell == '.'
      end
    end
  end
end

rc = ResonantCollinearity.new
puts rc.part1
puts rc.part2
