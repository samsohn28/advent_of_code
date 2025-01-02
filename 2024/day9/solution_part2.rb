# frozen_string_literal: true

class DiskFragmenterPart2
  DiskFile = Struct.new(:id, :size)

  attr_reader :disk_map
  attr_accessor :disk

  def initialize
    @disk_map = File.read('input.txt').chomp
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
    index = 0
    disk.each do |file|
      next if file.id == -1

      total += file.id * (index..(index + file.size - 1)).sum
      index += file.size
    end
    total
  end

  def move_files
    right_index = disk.size - 1

    while right_index > 0
      current_file = nil

      # Find the rightmost file
      while right_index >= 0
        if disk[right_index].id != -1
          current_file = disk[right_index]
          break
        end
        right_index -= 1
      end
      break unless current_file

      # Find the leftmost empty slot large enough to hold the file
      left_index = 0
      while left_index < right_index
        if disk[left_index].id == -1 && disk[left_index].size >= current_file.size
          break
        end
        left_index += 1
      end

      # If a suitable slot was found, move the file
      if disk[left_index].id == -1 && disk[left_index].size >= current_file.size
        remaining_size = disk[left_index].size - current_file.size
        disk[left_index] = current_file
        disk[right_index] = DiskFile.new(-1, current_file.size)

        # Insert the remaining empty space, if any
        disk.insert(left_index + 1, DiskFile.new(-1, remaining_size)) if remaining_size > 0
      else
        break # Stop moving if no valid slot was found
      end
    end
  end

  def generate_disk
    id = 0
    is_file = true
    disk_map.each_char do |char|
      @disk << DiskFile.new(is_file ? id : -1, char.to_i)
      id += 1 if is_file
      is_file = !is_file
    end
  end
end

DiskFragmenterPart2.new.defragment
