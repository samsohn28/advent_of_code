
class PrintingDepartment
  attr_reader :grid

  def initialize(file_path = 'input.txt')
    @grid = File.read(file_path).split("\n").map(&:chars)
  end

  def self.test_part1
    puts self.new('test.txt').accessible_positions
  end

  def self.part1
    puts self.new('input.txt').accessible_positions
  end

  def self.test_part2
    puts self.new('test.txt').total_removable_rolls
  end

  def self.part2
    puts self.new('input.txt').total_removable_rolls
  end

  def total_removable_rolls
    total_result, current_result = nil, 0
    until current_result == total_result
      total_result = current_result
      grid.each_with_index do |row, y|
        row.each_with_index do |char, x|
          if accessible_position?(x, y)
            grid[y][x] = '.'
            current_result += 1
          end
        end
      end
    end
    total_result
  end

  def accessible_positions
    result = 0
    grid.each_with_index do |row, y|
      row.each_with_index do |char, x|
        result += 1 if accessible_position?(x, y)
      end
    end
    result
  end

  private

  def is_paper_roll?(x, y)
    grid[y][x] == '@'
  end

  def is_in_bounds?(x, y)
    x >= 0 && x < grid[0].size && y >= 0 && y < grid.size
  end

  def accessible_position?(x, y)
    return false unless is_paper_roll?(x, y)

    [
      [x-1, y-1],
      [x, y-1],
      [x+1, y-1],
      [x-1, y],
      [x+1, y],
      [x-1, y+1],
      [x, y+1],
      [x+1, y+1]
    ].select do |x2, y2|
      is_in_bounds?(x2, y2) && is_paper_roll?(x2, y2)
    end.size < 4
  end
end

# PrintingDepartment.test_part1
# PrintingDepartment.part1
# PrintingDepartment.test_part2
PrintingDepartment.part2
