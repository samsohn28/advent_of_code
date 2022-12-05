# frozen_string_literal: true

class Lanternfish
  def initialize(age_list)
    @ages = { 0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0 }
    age_list.each { |age| @ages[age] += 1 }
  end

  attr_accessor :ages

  def grow
    temp = 0
    (0..8).each do |age|
      if age.zero?
        temp = ages[0]
      else
        ages[age - 1] = ages[age]
      end
    end
    ages[6] += temp
    ages[8] = temp
  end

  def total
    ages.values.sum
  end
end

lanternfish = File.open('input.txt').read.split(',').map(&:to_i)
part1 = Lanternfish.new(lanternfish)
80.times do
  part1.grow
end
puts part1.total

part2 = Lanternfish.new(lanternfish)
256.times do
  part2.grow
end
puts part2.total
