input = File.read('input.txt').split("\n")
sum = input.map do |str|
  s = str.gsub(/[^0-9 ]/i, '')
  "#{s[0]}#{s[-1]}".to_i
end.sum
puts sum