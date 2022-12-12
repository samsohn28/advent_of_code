# frozen_string_literal: true

STACKS = {
  1 => %w[B G S C],
  2 => %w[T M W H J N V G],
  3 => %w[M Q S],
  4 => %w[B S L T W N M],
  5 => %w[J Z F T V G W P],
  6 => %w[C T B G Q H S],
  7 => %w[T J P B W],
  8 => %w[G D C Z F T Q M],
  9 => %w[N S H B P F]
}

File.read('input.txt').split("\n")[10..].each do |instruction|
  instruction_arr = instruction.split(' ')
  crates_to_move = instruction_arr[1].to_i
  from = instruction_arr[3].to_i
  to = instruction_arr[5].to_i

  STACKS[to] += STACKS[from].pop(crates_to_move)
end

puts STACKS
