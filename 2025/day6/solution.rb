
class MathHomework
  attr_accessor :operators, :numbers, :all_lines
  def initialize(input = 'input.txt')
    @all_lines = File.read(input).split("\n")

    part1_lines = all_lines.dup.map(&:split)
    @operators = part1_lines.pop.map(&:to_sym)
    @numbers = part1_lines.map { |line| line.map(&:to_i) }
  end

  def self.test_part1
    self.new('test.txt').calculate
  end

  def self.part1
    self.new.calculate
  end

  def self.test_part2
    self.new('test.txt').calculate_part2
  end

  def self.part2
    self.new.calculate_part2
  end

  def calculate
    total = nil
    (0...row_length).each do |i|
      operands = numbers.map { |row| row[i] }
      operator = operators[i]
      evaluation = operands.reduce(operator)
      if total.nil?
        total = evaluation
      else
        total += evaluation
      end
    end
    total
  end

  def calculate_part2
    nums = all_lines.dup
    ops = nums.pop
    current_operands = []
    total = nil

    (nums[0].length - 1).downto(0).each do |i|
      current_number = nums.map { |row| row[i] }.join
      next unless current_number.match?(/[0-9]/)

      current_operands << current_number.to_i

      if ops[i] != " "
        current_operator = ops[i].to_sym
        evaluation = current_operands.reduce(current_operator)
        if total.nil?
          total = evaluation
        else
          total += evaluation
        end
        current_operands = []
      end
    end
    total
  end
end

# puts MathHomework.test_part1
# puts MathHomework.part1
puts MathHomework.test_part2
puts MathHomework.part2