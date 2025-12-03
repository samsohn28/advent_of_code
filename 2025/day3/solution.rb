
class Joltage
  def initialize(bank, digits)
    @bank = bank.split("")
    @digits = digits
  end

  def find_largest_joltage
    largest_joltage = ""
    last_index = -1
    @digits.times do |i|
      offset = @digits - i
      joltage, joltage_index = scan_bank(offset, last_index)
      last_index = joltage_index
      largest_joltage += joltage
    end
    largest_joltage.to_i
  end

  def scan_bank(offset, last_index)
    current_joltage = "0"
    current_index = 0
    @bank[last_index + 1..-offset].each_with_index do |joltage, index|
      if joltage > current_joltage
        current_joltage = joltage
        current_index = index
      end
    end
    [current_joltage, current_index + last_index + 1]
  end

  def self.test_part_1
    result = 0
    str = "987654321111111\n811111111111119\n234234234234278\n818181911112111"
    str.split("\n").each do |line|
      joltage = Joltage.new(line, 2)
      largest_joltage = joltage.find_largest_joltage
      puts largest_joltage
      result += largest_joltage
    end
    puts result
  end

  def self.test_part_2
    result = 0
    str = "987654321111111\n811111111111119\n234234234234278\n818181911112111"
    str.split("\n").each do |line|
      joltage = Joltage.new(line, 12)
      largest_joltage = joltage.find_largest_joltage
      puts largest_joltage
      result += largest_joltage
    end
    puts result
  end
end

# Joltage.test_part_2

result = 0
input = File.read("input.txt").split("\n")
input.each do |line|
  joltage = Joltage.new(line, 12)
  result += joltage.find_largest_joltage
end
puts result
