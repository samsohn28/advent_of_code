# frozen_string_literal: true

signal = File.read('input.txt').split('')

a = 0
b = 13

while true
  if signal[a..b].uniq.length == 14
    puts b + 1
    break
  else
    a += 1
    b += 1
  end
end
