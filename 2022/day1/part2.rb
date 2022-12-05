# frozen_string_literal: true

input = File.read('input.txt')
greatest = []
current = 0
input.split("\n").each do |cal|
  if cal == ''
    if greatest.count < 3
      greatest << current
    elsif current > greatest.sort!.reverse!.last
      greatest.pop
      greatest << current
    end
    current = 0
  else
    current += cal.to_i
  end
end
puts greatest.sum
