
class Ranges
  def initialize(range)
    @first_id, @last_id = range.split("-").map(&:to_i)
  end

  def sum_invalid_ids
    find_invalid_ids.sum
  end

  def find_invalid_ids
    invalid_ids = []
    (@first_id..@last_id).each do |id|
      invalid_ids << id if invalid_id?(id.to_s)
    end
    invalid_ids
  end

  def invalid_id?(id_str)
    string_length = id_str.length
    (1..string_length/2).each do |i|
      next unless string_length % i == 0

      return true if id_str.scan(/.{1,#{i}}/).uniq.size == 1
    end
    false
  end

  def self.test
    str = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"
    ranges = str.split(",").map { |range| Ranges.new(range) }
    puts ranges.map(&:sum_invalid_ids).sum
  end
end

# Ranges.test

ranges = File.read("input.txt").split(",").map { |line| Ranges.new(line) }
puts ranges.map(&:sum_invalid_ids).sum