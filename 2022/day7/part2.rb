# frozen_string_literal: true

FILESYSTEM = Hash.new(0)
DIRECTORIES = []

def change_directories(name)
  case name
  when '..' then DIRECTORIES.pop
  when '/' then DIRECTORIES.clear.append('/')
  else
    DIRECTORIES << name
  end
end

File.read('input.txt').split("\n") do |command|
  c = command.split(' ')
  case c.first
  when '$'
    change_directories(c[2]) if c[1] == 'cd'
  else
    filesize = c.first.to_i
    DIRECTORIES.size.times do |index|
      FILESYSTEM[DIRECTORIES[0..index].join('.')] += filesize
    end
  end
end

TOTAL_SPACE = 70_000_000
SPACE_NEEDED = FILESYSTEM['/'] - 40_000_000

FILESYSTEM.values.sort.each do |size|
  if size > SPACE_NEEDED
    puts size
    break
  end
end
