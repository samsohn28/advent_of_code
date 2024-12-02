first_list, second_list = File.read("input.txt")
  .lines
  .map { |line| line.split.map(&:to_i) }
  .transpose
first_list.sort!
second_list.sort!

distances = []
(0...first_list.length).each do |i|
  distances << (first_list[i] - second_list[i]).abs
end

puts distances.inject(:+)
