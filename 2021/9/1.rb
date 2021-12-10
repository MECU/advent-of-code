require 'csv'

def load
    data = []

    CSV.foreach('input.csv') do |row|
        data << row[0].split('').map(&:to_i)
    end

    data
end

def main
    data = load

    low_points = []

    y_limit = data.count - 1
    (0..y_limit).each do |y|
        x_limit = data[0].count - 1
        (0..x_limit).each do |x|
            value = data[y][x]
            next if value == 9
            next if y-1 >= 0 && data[y-1][x] < value
            next if x-1 >= 0 && data[y][x-1] < value
            next if x+1 <= x_limit && data[y][x+1] < value
            next if y+1 <= y_limit && data[y+1][x] < value

            low_points << data[y][x]
        end
    end

    p low_points
    p low_points.count + low_points.sum
end

main

# 1649 high
# 1486 high
# 1339 high
# 409 ?
# 486