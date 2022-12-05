# frozen_string_literal: true

require 'byebug'

class Lava
  def initialize(height_map)
    @height_map = height_map
    @y_max = height_map.size - 1
    @x_max = height_map.first.size - 1
  end

  attr_reader :height_map, :x_max, :y_max
  attr_accessor :curr_val, :y_curr, :x_curr, :basins

  def calculate_risk_level
    risk_level_total = 0
    height_map.each_with_index do |row, y|
      @y_curr = y
      row.each_with_index do |val, x|
        @x_curr = x
        @curr_val = val
        risk_level_total += (val + 1) if low_point?
      end
    end
    risk_level_total
  end

  def calculate_largest_basins
    @basins = {}
    find_basins
    calculate
  end

  def calculate
    basins.values.map(&:size).sort.last(3).inject(:*)
  end

  def find_basins
    height_map.each_with_index do |row, y|
      row.each_with_index do |val, x|
        if basinable?(val, y, x)
          add_basin(basin_key, val, y, x)
        end
      end
    end
  end

  def basinable?(val, y_current, x_current)
    val < 9 && !basins.values.flatten(1).include?([y_current, x_current])
  end

  def add_basin(key, val, y_current, x_current)
    return unless basinable?(val, y_current, x_current)

    basins[key] << [y_current, x_current]
    add_basin(key, val, y_current - 1, x_current) unless y_current.zero?
    add_basin(key, val, y_current + 1, x_current) unless y_current == y_max
    add_basin(key, val, y_current, x_current - 1) unless x_current.zero?
    add_basin(key, val, y_current, x_current + 1) unless x_current == x_max
  end

  def add_location_to_basin(key)
    basin[key] = [y_current, x_current]
  end

  def basin_key
    if basins.keys.empty?
      basins[0] = []
      0
    else
      new_key = basins.keys.max + 1
      basins[new_key] = []
      new_key
    end
  end

  def low_point?
    check_above && check_below && check_left && check_right
  end

  def check_above
    y_curr.zero? || curr_val < height_map[y_curr - 1][x_curr]
  end

  def check_below
    y_curr == y_max || curr_val < height_map[y_curr + 1][x_curr]
  end

  def check_left
    x_curr.zero? || curr_val < height_map[y_curr][x_curr - 1]
  end

  def check_right
    x_curr == x_max || curr_val < height_map[y_curr][x_curr + 1]
  end
end

input = File.open('input.txt').read.split("\n")
height_map = input.map { |line| line.split('').map(&:to_i) }

lava = Lava.new(height_map)
p lava.calculate_risk_level
p lava.calculate_largest_basins
