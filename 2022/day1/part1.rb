# frozen_string_literal: true

input = File.read('input.txt')

greatest = 0
current = 0
input.split("\n").each do |cal|
  if cal == ''
    greatest = current if current > greatest
    current = 0
  else
    current += cal.to_i
  end
end
puts greatest
