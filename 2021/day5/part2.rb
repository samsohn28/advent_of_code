input = File.open('input.txt').read
lines = input.split("\n")

require './Point'
danger_areas = {}

lines.each do |line|
  points = line.split(' -> ')
  point1 = points[0].split(',')
  point2 = points[1].split(',')

  current = Point.new(point1[0], point1[1])
  finish = Point.new(point2[0], point2[1])

  while (current.x != finish.x) && (current.y != finish.y)
    danger_areas[[current.x, current.y]] = 0 if danger_areas[[current.x, current.y]].nil?
    danger_areas[[current.x, current.y]] += 1
    current.x -= 1 if current.x > finish.x
    current.x += 1 if current.x < finish.x
    current.y -= 1 if current.y > finish.y
    current.y += 1 if current.y < finish.y
  end
  danger_areas[[current.x, current.y]] = 0 if danger_areas[[current.x, current.y]].nil?
  danger_areas[[current.x, current.y]] += 1
end

count = 0
danger_areas.each do |_k,v|
  count += 1 if v > 1
end

puts count