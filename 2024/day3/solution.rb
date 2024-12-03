class MullItOver
  attr_reader :input

  def initialize(file_path = 'input.txt')
    @input = File.read(file_path)
  end

  def part1
    result = extract_operations(input).map { |a, b| a.to_i * b.to_i }
    puts result.sum
  end

  def part2
    dos = input.split('do()')
    result = dos.map do |line|
      lines = line.split("don't()")
      extract_operations(lines.first).map { |a, b| a.to_i * b.to_i }.sum
    end
    puts result.sum
  end

  private

  def extract_operations(str)
    regex = /mul\(([1-9]\d{0,2}),([1-9]\d{0,2})\)/
    str.scan(regex)
  end

  def extract_numbers(match)
    match.scan(/\d+/).map(&:to_i)
  end
end

MullItOver.new.part1
MullItOver.new.part2
