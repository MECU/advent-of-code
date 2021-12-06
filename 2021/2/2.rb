require 'csv'

depth = 0
position = 0
aim = 0

CSV.foreach('input.csv') do |row|
    next if row.nil?

    command, distance = row[0].split(' ')
    position += distance.to_i if command == 'forward'
    aim -= distance.to_i if command == 'up'
    aim += distance.to_i if command == 'down'
    depth += aim * distance.to_i if command == 'forward'
end

puts depth * position