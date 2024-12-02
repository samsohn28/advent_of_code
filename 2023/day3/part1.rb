
class GearRatios
  SYMBOLS = "*#+$".freeze

  attr_reader :grid

  def initialize
    input = File.read('input.txt')
    @grid = input.split("\n").map { |row| row.split("") }
  end

  def sum_of_part_numbers
    sum = 0
    grid.each_with_index do |row, y|
      row.each_with_index do |char, x|
        next unless symbol?(char)

        sum += surrounding_part_numbers(x, y)
      end
    end
    puts sum
  end

  private

  def number?(char)
    char.match?(/[0-9]/i)
  end

  def symbol?(char)
    SYMBOLS.include?(char)
  end

  def surrounding_part_numbers(x, y)
    # check left
    # check right
    # check up
    # if number, then expand to find 1 number
    # if "." then potentially 2 numbers
    # check down

    # how do we know if up/down numbers are the same or not from diagonal?
  end
end
