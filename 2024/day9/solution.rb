# frozen_string_literal: true

class DiskFragmenter
  attr_reader :disk_map
  attr_accessor :disk
  def initialize
    @disk_map = File.read('input.txt')
    @disk = []
    generate_disk
  end

  def defragment
    move_files
    puts checksum
  end

  private

  def checksum
    total = 0
    disk.each_with_index do |id, index|
      break if id == -1

      total += id * index
    end
    total
  end

  def move_whole_files

  end

  def move_files
    left_index = -1
    right_index = disk.size

    while left_index < right_index
      loop do
        left_index += 1
        return if left_index >= right_index
        break if disk[left_index] == -1
      end

      loop do
        right_index -= 1
        return if right_index <= left_index
        break if disk[right_index] != -1
      end

      @disk[left_index] = disk[right_index]
      @disk[right_index] = -1
    end
  end

  def generate_disk
    id = 0
    is_file = true
    disk_map.each_char do |char|
      char.to_i.times { @disk << (is_file ? id : -1) }
      id += 1 if is_file
      is_file = !is_file
    end
  end
end

df = DiskFragmenter.new
df.defragment
