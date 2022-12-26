# frozen_string_literal: true

require 'byebug'

instructions = File.read('input.txt').split("\n").map { |instruction| instruction.split(' ') }
@head = [0, 0]
@tail = [0, 0]
@visited = Hash.new(0)

def process_steps(direction, steps)
  steps.times do
    next_step = step(direction)
    move_tail unless touching?(next_step)
    @head = next_step
  end
end

def step(direction)
  x, y = @head
  case direction
  when 'U' then y += 1
  when 'D' then y -= 1
  when 'R' then x += 1
  when 'L' then x -= 1
  end
  [x, y]
end

def touching?(next_step)
  touching_distance = [-1, 0, 1]
  touching_distance.include?(@tail.first - next_step.first) &&
    touching_distance.include?(@tail.last - next_step.last)
end

def move_tail
  @tail = @head
  @visited[@tail] += 1
end

instructions.each do |instruction|
  direction, steps = instruction

  process_steps(direction, steps.to_i)
end

puts @visited.size
