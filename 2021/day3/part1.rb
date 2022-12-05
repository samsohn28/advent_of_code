input = File.open('input.txt').read.split("\n")

max = input.size
zeroes = {}

input.each do |bin|
  bin.split("").map.with_index do |val, idx|
    if val == "0"
      zeroes[idx] = 0 if zeroes[idx].nil?
      zeroes[idx] += 1
    end
  end
end

puts zeroes

gamma = ""
epsilon = ""

(0..zeroes.size - 1).each do |x|
  v = zeroes[x]
  if v > (max / 2)
    gamma += "0"
    epsilon += "1"
  else
    gamma += "1"
    epsilon += "0"
  end
end

puts gamma
puts epsilon

puts gamma.to_i(2) * epsilon.to_i(2)
