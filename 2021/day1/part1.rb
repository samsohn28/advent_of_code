input = File.open('input.txt').read

previous = nil
increases = 0
input.split("\n").each do |depth|
  unless previous.nil?
    increases += 1 if depth.to_i > previous.to_i
    puts "#{previous} -> #{depth}: #{increases}"
  end
  previous = depth
end
puts increases