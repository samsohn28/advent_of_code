
class CeresSearch
  attr_reader :grid, :max_length, :max_width, :word

  DIRECTIONS = [
    [0, 1],   # Right
    [0, -1],  # Left
    [1, 0],   # Down
    [-1, 0],  # Up
    [1, 1],   # Down-Right
    [1, -1],  # Down-Left
    [-1, 1],  # Up-Right
    [-1, -1]  # Up-Left
  ]

  DIAGONALS = [
    [[1, 1], [-1, -1]], # Down-Right, Up-Left
    [[1, -1], [-1, 1]]  # Down-Left, Up-Right
  ]

  def initialize(word)
    @grid = File.read('input.txt').lines.map(&:chomp).map(&:chars)
    @word = word
    @max_length = @grid.size
    @max_width = @grid.first.size
  end

  def part1
    matches = []

    (0...max_length).each do |row|
      (0...max_width).each do |col|
        matches.concat(find_word(row, col))
      end
    end

    puts matches.count
  end

  def part2
    matches = 0

    (1...max_length-1).each do |row|
      (1...max_width-1).each do |col|
        matches += 1 if find_x_mas(row, col)
      end
    end

    puts matches
  end

  private

  def find_word(row, col)
    found_positions = []

    DIRECTIONS.each do |dx, dy|
      positions = []
      (0...word.length).each do |i|
        x, y = row + i * dx, col + i * dy
        break unless valid_position?(x, y) && grid[x][y] == word[i]

        positions << [x, y]
      end

      found_positions << positions if positions.size == word.length
    end

    found_positions
  end

  def find_x_mas(row, col)
    DIAGONALS.all? do |(dx1, dy1), (dx2, dy2)|
      x1, y1 = row + 1 * dx1, col + 1 * dy1
      x2, y2 = row  + 1 * dx2, col + 1 * dy2
      [word, word.reverse].include?([grid[x1][y1], grid[row][col], grid[x2][y2]].join)
    end
  end

  def valid_position?(x, y)
    x >= 0 && x < max_length && y >= 0 && y < max_width
  end
end

CeresSearch.new('XMAS').part1
CeresSearch.new('MAS').part2
