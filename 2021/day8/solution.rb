# frozen_string_literal: true

class Display
  def initialize(signals, outputs)
    @signals = signals.split
    @outputs = outputs.split
  end

  attr_reader :signals, :outputs

  def find_easy_digits
    outputs.collect { |output| [2, 3, 4, 7].include?(output.size) ? true : nil }.compact.size
  end

  def find_digits
    outputs.collect { |output| signal_wire_mapping[output.chars.sort.join] }.join
  end

  def signal_wire_mapping
    @signal_wire_mapping ||= map_signal_wires
  end

  def map_signal_wires
    {
      one => '1',
      two => '2',
      three => '3',
      four => '4',
      five => '5',
      six => '6',
      seven => '7',
      eight => '8',
      nine => '9',
      zero => '0'
    }
  end

  def one
    @one ||= signals.select { |signal| signal.size == 2 }.first.chars.sort.join
  end

  def two
    @two ||= signals.select do |signal|
      char = eight.chars - (three.chars | four.chars)
      signal.size == 5 && signal.include?(char.first)
    end.first.chars.sort.join
  end

  def three
    @three ||= signals.select do |signal|
      signal.size == 5 && ((signal.chars & one.chars).size == 2)
    end.first.chars.sort.join
  end

  def four
    @four ||= signals.select { |signal| signal.size == 4 }.first.chars.sort.join
  end

  def five
    @five ||= signals.select do |signal|
      char = eight.chars - (three.chars | two.chars)
      signal.size == 5 && signal.include?(char.first)
    end.first.chars.sort.join
  end

  def six
    @six ||= signals.select do |signal|
      char = eight.chars - (three.chars | four.chars)
      signal.size == 6 && (signal.chars.sort == (five.chars + char).sort)
    end.first.chars.sort.join
  end

  def seven
    @seven ||= signals.select { |signal| signal.size == 3 }.first.chars.sort.join
  end

  def eight
    @eight ||= signals.select { |signal| signal.size == 7 }.first.chars.sort.join
  end

  def nine
    @nine ||= signals.select do |signal|
      signal.size == 6 && signal.chars.sort == (four.chars | five.chars).sort
    end.first.chars.sort.join
  end

  def zero
    @zero ||= signals.select do |signal|
      signal_sorted = signal.chars.sort
      signal.size == 6 && signal_sorted != six.chars.sort && signal_sorted != nine.chars.sort
    end.first.chars.sort.join
  end
end

input = File.open('input.txt').read.split("\n")

# part1 = 0

# input.each do |line|
#   signals, outputs = line.split('|')
#   part1 += Display.new(signals, outputs).find_easy_digits
# end

# p part1

part2 = 0
input.each_with_index do |line, i|
  signals, outputs = line.split('|')
  temp = Display.new(signals, outputs).find_digits.to_i
  part2 += temp
  p "#{i}: #{temp} -- #{part2}"
end
p part2

# line = "efcgdb da bdefg dfegba fbacg gbcdea dbafceg adb feda fadgb | da ad cgabde cebdga"
# signals, outputs = line.split('|')
# d = Display.new(signals, outputs)
# p line
# p d.one
# p d.two
# p d.three
# p d.four
# p d.five
# p d.six
# p d.seven
# p d.eight
# p d.nine
# p d.zero
# p d.signal_wire_mapping
# outputs.split.each do |output|
#   p d.signal_wire_mapping[output.chars.sort.join]
# end
