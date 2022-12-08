# frozen_string_literal: true

WINS = ['A Y', 'B Z', 'C X'].freeze
TIES = ['A X', 'B Y', 'C Z'].freeze
LOSES = ['A Z', 'B X', 'C Y'].freeze
SHAPE_SCORE = { 'X' => 1, 'Y' => 2, 'Z' => 3 }.freeze

score = 0

File.read('input.txt').split("\n") do |round|
  score += if WINS.include?(round)
    6
  elsif TIES.include?(round)
    3
  else
    0
  end + SHAPE_SCORE[round[2]]
end

puts score
