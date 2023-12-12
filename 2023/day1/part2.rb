input = File.read('input.txt').split("\n")
sum = 0
input.map do |str|
  new_str = ""
  (0..str.length - 1).each do |i|
    if str[i].match?(/[0-9]/i)
      new_str += str[i]
    else
      if str[i..i + 2] == "one"
        new_str += "1"
      elsif str[i..i + 2] == "two"
        new_str += "2"
      elsif str[i..i + 4] == "three"
        new_str += "3"
      elsif str[i..i + 3] == "four"
        new_str += "4"
      elsif str[i..i + 3] == "five"
        new_str += "5"
      elsif str[i..i + 2] == "six"
        new_str += "6"
      elsif str[i..i + 4] == "seven"
        new_str += "7"
      elsif str[i..i + 4] == "eight"
        new_str += "8"
      elsif str[i..i + 3] == "nine"
        new_str += "9"
      end
    end
  end
  sum += "#{new_str[0]}#{new_str[-1]}".to_i
  puts "#{str} : #{new_str[0]}#{new_str[-1]}"
end
puts sum

