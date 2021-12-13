require 'csv'

FILE = 'input.csv'
$grid = []

def load
    max_x = 0
    max_y = 0

    CSV.foreach(FILE) do |row|
        x, y = row.map(&:to_i)
        max_x = x if x > max_x
        max_y = y if y > max_y
    end
    
    # p max_x
    # p max_y

    $grid = Array.new(max_y+1, '.') { Array.new(max_x+1, '.') }
    
    CSV.foreach(FILE) do |row|
        x, y = row.map(&:to_i)
        # p "#{x},#{y}"
        $grid[y][x] = '#'
    end
end

# useful in debugging visually
def display(y = $grid.count - 1)
    (0..y).each do |i|
        p $grid[i].join
    end
    p '-' * 80
end

def fold(direction, location)
    if direction == 'x'
        (0..($grid.count - 1)).each do |y|
            (location+1..($grid[y].count + 1)).each do |x|
                $grid[y][location - (x - location)] = '#' if $grid[y][x] == '#'
            end
            $grid[y] = $grid[y][0..location-1]
        end
    else
        ((location+1)..($grid.count - 1)).each do |y|
            (0..$grid[y].count).each do |x|
                $grid[location - (y - location)][x] = '#' if $grid[y][x] == '#'
            end
            $grid[y] = nil
        end
    end
    $grid.compact!
end

def count_dots
    $grid.map do |row|
        row.count('#')
    end.sum
end

def main
    load
    fold('x', 655)
    fold('y', 447)
    fold('x', 327)
    fold('y', 223)
    fold('x', 163)
    fold('y', 111)
    fold('x', 81)
    fold('y', 55)
    fold('x', 40)
    fold('y', 27)
    fold('y', 13)
    fold('y', 6)
    
    display
end

main
