# frozen_string_literal: true

# frozen_string_literal: true

require 'byebug'

instructions = File.read('input.txt').split("\n").map { |instruction| instruction.split(' ') }
@knots = []
10.times do
  @knots << [0, 0]
end

@visited = Hash.new(0)

def process_steps(direction, steps)
  steps.times do
    previous_knot = @knots.first
    move_head(direction)
    @knots.dup[1..9].each.with_index do |knot, index|
      @knots[index] = previous_knot if touching?(previous_knot, index)
      previous_knot = knot
    end
    @visited[@knots.last] += 1
  end
end

def step(direction)
  x, y = @knots.first
  case direction
  when 'U' then y += 1
  when 'D' then y -= 1
  when 'R' then x += 1
  when 'L' then x -= 1
  end
  [x, y]
end

def touching?(previous_knot, index)
  touching_distance = [-1, 0, 1]
  knot = @knots[index]
  touching_distance.include?(knot.first - previous_knot.first) &&
    touching_distance.include?(knot.last - previous_knot.last)
end

def move_head(direction)
  @knots.first = step(direction)
end

instructions.each do |instruction|
  direction, steps = instruction

  process_steps(direction, steps.to_i)
end

puts @visited.size

