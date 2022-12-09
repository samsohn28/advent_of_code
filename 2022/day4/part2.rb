# frozen_string_literal: true

count = 0

File.read('input.txt').split("\n") do |pair|
  first, second = pair.split(',')

  first = first.split('-')
  first_a = (first.first.to_i..first.last.to_i).to_a

  second = second.split('-')
  second_a = (second.first.to_i..second.last.to_i).to_a

  count += 1 unless (first_a & second_a).empty?
end

puts count
