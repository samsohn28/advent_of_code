input = File.open('input.txt').read.split("\n")

window = []
increases = 0

input.each_with_index do |depth, index|
  if index < 3
    window << depth.to_i
    next
  end

  window1 = window.sum
  window.shift
  window << depth.to_i
  increases += 1 if window.sum > window1
end
puts increases