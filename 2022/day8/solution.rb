# frozen_string_literal: true

require 'byebug'

module Day8
  class TreeGrid
    attr_reader :grid

    def initialize
      @grid = File.read('input.txt').split("\n").map do |str|
        str.split('').map(&:to_i)
      end
    end
  end

  class TreetopTreeHouse
    attr_reader :grid, :width, :height

    def initialize(grid)
      @grid = grid
      @width = grid.first.length
      @height = grid.length
    end

    def part1
      visible_trees = width * 2 + height * 2 - 4
      (1...width - 1).each do |y|
        (1...height - 1).each do |x|
          visible_trees += 1 if process_tree([x, y], grid[y][x])
        end
      end
      visible_trees
    end

    def part2
      highest_scenic_score = 0
      (1...width - 1).each do |y|
        (1...height - 1).each do |x|
          current_scenic_score = calculate_scenic_score([x, y], grid[y][x])
          highest_scenic_score = max(current_scenic_score, highest_scenic_score)
        end
      end
      highest_scenic_score
    end

    private

    def process_tree(coordinates, height)
      x, y = coordinates
      is_visible?(grid[y], x, height) ||
        is_visible?(grid.map { |y| y[x] }, y, height)
    end

    def is_visible?(tree_line, tree, height)
      tree_line[...tree].all? { |h| h < height } ||
        tree_line[tree + 1..].all? { |h| h < height }
    end

    def calculate_scenic_score(coordinates, height)
      x, y = coordinates
      scenic_score(grid[y], x, height) *
        scenic_score(grid.map { |y| y[x] }, y, height)
    end

    def scenic_score(tree_line, x, height)
      calculate(tree_line[...x].reverse, height) *
        calculate(tree_line[x + 1..], height)
    end

    def calculate(tree_line, height)
      score = 0
      next_highest = 0
      tree_line.each do |h|
        if h > height
          return score + 1
        else
          score += 1
        end
        next_highest = h if h > next_highest
      end
      score
    end

    def max(a, b)
      return a if a > b
      b
    end
  end
end

grid = Day8::TreeGrid.new.grid
solution = Day8::TreetopTreeHouse.new(grid)
# puts solution.part1
puts solution.part2
