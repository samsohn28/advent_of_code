input = File.open('input.txt').read.split("\n").map(&:split)

position = 0
depth = 0
aim = 0

input.each do |instruction|
  direction = instruction[0]
  distance = instruction[1].to_i

  case direction
  when "forward"
    position += distance
    depth += (aim * distance)
  when "down" then aim += distance
  when "up" then aim -= distance
  end
end

puts position * depth