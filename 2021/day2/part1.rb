input = File.open('input.txt').read.split("\n").map(&:split)

position = 0
depth = 0

input.each do |instruction|
  direction = instruction[0]
  distance = instruction[1].to_i

  case direction
  when "forward" then position += distance
  when "down" then depth += distance
  when "up" then depth -= distance
  end
end

puts position * depth