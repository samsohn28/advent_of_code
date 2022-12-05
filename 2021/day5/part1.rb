input = File.open('input.txt').read
lines = input.split("\n")

danger_areas = {}

def min(num1, num2)
  return num1 if num1 < num2
  return num2
end

def max(num1, num2)
  return num1 if num1 > num2
  return num2
end

lines.each do |line|
  points = line.split(' -> ')
  point1 = points[0].split(',').map(&:to_i)
  point2 = points[1].split(',').map(&:to_i)

  # check if horizontal or vertical
  next unless point1[0] == point2[0] || point1[1] == point2[1]

  if point1[0] == point2[0]
    x = point1[0]
    from = min(point1[1], point2[1])
    to = max(point1[1], point2[1])
    (from..to).each do |y|
      danger_areas[[x,y]] = 0 if danger_areas[[x,y]].nil?
      danger_areas[[x,y]] += 1
    end
  else
    y = point1[1]
    from = min(point1[0], point2[0])
    to = max(point1[0], point2[0])
    (from..to).each do |x|
      danger_areas[[x,y]] = 0 if danger_areas[[x,y]].nil?
      danger_areas[[x,y]] += 1 
    end
  end
end

count = 0
danger_areas.each do |_k,v|
  count += 1 if v > 1
end

puts count