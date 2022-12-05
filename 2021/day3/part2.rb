input = File.open('input.txt').read.split("\n")

def recurse(type, position, nums)
  return nums.first.to_i(2) if nums.size == 1

  zeroes = []
  ones = []
  nums.each do |num|
    num[position] == "0" ? zeroes << num : ones << num
  end

  if type == "oxygen"
    recurse(
      "oxygen",
      position += 1, 
      zeroes.size > ones.size ? zeroes : ones
    )
  else
    recurse(
      "carbon",
      position += 1, 
      ones.size < zeroes.size ? ones : zeroes
    )
  end
end

oxygen = recurse("oxygen", 0, input)
carbon = recurse("carbon", 0, input)

puts oxygen * carbon
