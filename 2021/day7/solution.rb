# frozen_string_literal: true

class Crabs
  def initialize(positions)
    @positions = positions.map(&:to_i)
  end

  attr_reader :positions

  def max
    max ||= positions.max
  end

  def min
    min ||= positions.min
  end

  def find_cheapest_fuel
    cheapest = nil
    (min..max).each do |aligned_position|
      cheapest = if cheapest.nil?
                   required_fuel(aligned_position)
                 else
                   [cheapest, required_fuel(aligned_position)].min
                 end
    end
    cheapest
  end

  def required_fuel(aligned_position)
    # part 1
    # positions.map { |position| (position - aligned_position).abs }.sum

    # part 2
    positions.map { |position| triangular((position - aligned_position).abs) }.sum
  end

  def triangular(num)
    num * (num + 1) / 2
  end
end

input = File.open('input.txt').read.split(',')

puts Crabs.new(input).find_cheapest_fuel
