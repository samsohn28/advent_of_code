
class HistorianHysteria
  attr_reader :first_list, :second_list
  def initialize
    @first_list, @second_list = File.read("input.txt")
      .lines
      .map(&:chomp)
      .map { |line| line.split.map(&:to_i) }
      .transpose
    @first_list.sort!
    @second_list.sort!
  end

  def part1
    distances = []
    (0...first_list.length).each do |i|
      distances << (first_list[i] - second_list[i]).abs
    end

    puts distances.inject(:+)
  end

  def part2
    results = []
    unique_numbers = (first_list + second_list).uniq.sort!
    unique_numbers.each do |num|
      count_first = first_list.count(num)
      count_second = second_list.count(num)
      results << count_first * count_second * num
    end

    puts results.inject(:+)
  end
end

HistorianHysteria.new.part1
HistorianHysteria.new.part2
