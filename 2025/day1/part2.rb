
class Dial
  def initialize
    @position = 50
    @zeroes = 0
  end

  def move(direction, distance)
    if direction == "R"
      distance.times do
        @position += 1
        @zeroes += 1 if @position % 100 == 0
      end
    else
      distance.times do
        @position -= 1
        @zeroes += 1 if @position % 100 == 0
      end
    end

    @position = @position % 100
  end

  def position
    @position
  end

  def zeroes
    @zeroes
  end
end

dial = Dial.new
input = File.readlines("input.txt")
input.each do |line|
  dir = line[0]
  distance = line[1..].to_i
  dial.move(dir, distance)
end

puts dial.position
puts dial.zeroes
