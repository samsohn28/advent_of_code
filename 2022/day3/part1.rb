# frozen_string_literal: true
require 'byebug'

SCORES = ("a".."z").to_a + ("A".."Z").to_a

score = 0

File.read('input.txt').split("\n") do |rucksack|
  half = (rucksack.length - 1) / 2
  first = rucksack[..half]
  second = rucksack[half + 1..]

  first.split('').each do |item|
    if second.include?(item)
      score += SCORES.find_index(item) + 1
      break
    end
  end
end

puts score
