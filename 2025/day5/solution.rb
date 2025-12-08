
class Cafeteria
  attr_reader :ranges, :ingredient_ids, :cleaned_ranges
  def initialize(file_path = 'input.txt')
    ranges, ingredient_ids = File.read(file_path).split("\n\n")
    @ranges = ranges.split("\n")
    @ingredient_ids = ingredient_ids.split("\n").map(&:to_i)
  end

  def self.test_part1
    puts self.new('test.txt').sum_fresh_ingredients
  end

  def self.part1
    puts self.new.sum_fresh_ingredients
  end

  def self.test_part2
    puts self.new('test.txt').sum_uniq_ranges
  end

  def self.part2
    puts self.new.sum_uniq_ranges
  end

  def sum_uniq_ranges
    clean_ranges.sum do |clean_range|
      clean_range[1] - clean_range[0] + 1
    end
  end

  def sum_fresh_ingredients
    fresh_ingredients = 0
    tmp_ingredient_ids = ingredient_ids.dup
    ranges.each do |range|
      first_id, last_id = range.split("-").map(&:to_i)
      ids_to_delete = []
      fresh_ids = tmp_ingredient_ids.select do |id|
        in_range?(id, first_id, last_id)
      end
      fresh_ingredients += fresh_ids.count
      tmp_ingredient_ids = tmp_ingredient_ids - fresh_ids
    end
    fresh_ingredients
  end

  def in_range?(id, first_id, last_id)
    first_id <= id && last_id >= id
  end

  def clean_ranges
    int_ranges = ranges.map { |range| range.split("-").map(&:to_i) }
    int_ranges.sort!
    clean_ranges = []
    int_ranges.each_with_index do |int_range, index|
      if index == 0
        clean_ranges << int_range
      else
        if int_range[0] <= clean_ranges[-1][1]
          clean_ranges[-1][1] = [int_range[1], clean_ranges[-1][1]].max
        else
          clean_ranges << int_range
        end
      end
    end
    clean_ranges
  end

  def overlaps?(new_range, first_id, last_id)
    first_id <= new_range[1] && last_id >= new_range[0]
  end
end

# Cafeteria.test_part1
# Cafeteria.part1
# Cafeteria.test_part2
Cafeteria.part2