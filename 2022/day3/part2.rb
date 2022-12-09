# frozen_string_literal: true
require 'byebug'

SCORES = ("a".."z").to_a + ("A".."Z").to_a

score = 0

File.read('input.txt').split("\n").each_slice(3) do |rucksack_group|
  rucksack_group.map! { |rucksack| rucksack.split('') }
  item_type = rucksack_group.reduce(&:&).first
  score += SCORES.find_index(item_type) + 1
end

puts score
