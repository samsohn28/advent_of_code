require 'byebug'

class PrintQueue
  attr_reader :rules, :manuals
  def initialize
    rules, manuals = File.read('input.txt').split("\n\n")
    @rules = rules.split("\n")
    @manuals = manuals.split("\n").map { |line| line.split(",") }
  end

  def part1
    puts manuals.sum do |manual|
      sorted_manual = sort_manual(manual)
      byebug
      sorted_manual == manual ? mid_num(sorted_manual) : 0
    end
  end

  def compare(a, b)
    rules.include?("#{a}|#{b}") ? 0 : 1
  end

  def sort_manual(manual)
    manual.sort { |a, b| compare(a, b) }
  end

  def mid_num(manual)
    manual[manual.length / 2].to_i
  end
end

PrintQueue.new.part1
# PrintQueue.new("input.txt").part2
