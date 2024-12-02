first_list, second_list = File.read("input.txt")
  .lines
  .map { |line| line.split.map(&:to_i) }
  .transpose

first_list.sort!
second_list.sort!

results = []
unique_numbers = (first_list + second_list).uniq.sort!
unique_numbers.each do |num|
  count_first = first_list.count(num)
  count_second = second_list.count(num)
  results << count_first * count_second * num
end

puts results.inject(:+)