input = File.read('input.txt').split("\n")

sum = 0
input.each do |line|
  possible = true
  header, games = line.split(":")
  game_number = header.split(" ").last.strip.to_i
  min_set = {
    "red" => 0,
    "green" => 0,
    "blue" => 0
  }

  games.split(";").each do |game|
    game.split(",").each do |draw|
      cubes, color = draw.split(" ")
      if min_set[color.strip] < cubes.to_i
        min_set[color.strip] = cubes.to_i
      end
    end
  end

  power = min_set.values.reduce(1) { |product, number| product * number }
  sum += power
end
puts sum
