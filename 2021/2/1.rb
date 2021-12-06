require 'csv'

depth = 0
position = 0

CSV.foreach('input.csv') do |row|
    next if row.nil?

    command, distance = row[0].split(' ')
    position += distance.to_i if command == 'forward'
    depth -= distance.to_i if command == 'up'
    depth += distance.to_i if command == 'down'
end

puts depth * position