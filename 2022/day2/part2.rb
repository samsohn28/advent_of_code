# frozen_string_literal: true

RESULT = { 'X' => :lose, 'Y' => :draw, 'Z' => :win }.freeze
NEED = {
  'A' => { win: :paper, draw: :rock, lose: :scissors },
  'B' => { win: :scissors, draw: :paper, lose: :rock },
  'C' => { win: :rock, draw: :scissors, lose: :paper }
}.freeze
SCORES = { win: 6, draw: 3, lose: 0, rock: 1, paper: 2, scissors: 3 }.freeze

score = 0

File.read('input.txt').split("\n") do |round|
  score += SCORES[RESULT[round[2]]] + SCORES[NEED[round[0]][RESULT[round[2]]]]
end

puts score
