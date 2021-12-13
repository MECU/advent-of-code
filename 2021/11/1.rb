require 'csv'

$grid = []
$flashed = []
$max_y = 9
$max_x = 9

def load
    CSV.foreach('input.csv') do |row|
        $grid << row[0].split('').map(&:to_i)
        $max_x = row[0].split('').count - 1
    end
    $max_y = $grid.count - 1
    reset_flashed
end

def reset_flashed
    (0..$max_y).each do |y|
        $flashed[y] = []
        (0..$max_x).map do |x|
            $flashed[y][x] = false
        end
    end
end

def count_flashed
    $flashed.map do |row|
        row.count(true)
    end.sum
end

def main
    load

    flashes = 0
    (1..100).each do |step|
        $grid.map! do |y|
            y.map! do |x|
                x += 1
            end
        end
        
        (0..$max_y).each do |y|
            (0..$max_x).each do |x|
                flash?(x, y)
            end
        end
        
        flashes += count_flashed
        reset_flashed
    end

    p "flashes: #{flashes}"
end

def flash?(x, y)
    return false if $grid[y][x] < 10 || $flashed[y][x] == true

    $flashed[y][x] = true
    $grid[y][x] = 0
    increase_neighbors(x, y)
end

def increase_neighbors(x, y)
    $grid[y-1][x-1] += 1 if y-1 >= 0 && x-1 >= 0 && $flashed[y-1][x-1] != true
    $grid[y-1][x] += 1 if y-1 >= 0 && $flashed[y-1][x] != true
    $grid[y-1][x+1] += 1 if y-1 >= 0 && x+1 <= 9 && $flashed[y-1][x+1] != true
    $grid[y][x-1] += 1 if x-1 >= 0 && $flashed[y][x-1] != true
    $grid[y][x+1] += 1 if x+1 <= 9 && $flashed[y][x+1] != true
    $grid[y+1][x-1] += 1 if y+1 <= 9 && x-1 >= 0 && $flashed[y+1][x-1] != true
    $grid[y+1][x] += 1 if y+1 <= 9 && $flashed[y+1][x] != true
    $grid[y+1][x+1] += 1 if y+1 <= 9 && x+1 <= 9 && $flashed[y+1][x+1] != true
    
    flash?(x-1, y-1) if y-1 >= 0 && x-1 >= 0
    flash?(x, y-1) if y-1 >= 0
    flash?(x+1, y-1) if y-1 >= 0 && x+1 <= 9
    flash?(x-1, y) if x-1 >= 0
    flash?(x+1, y) if x+1 <= 9
    flash?(x-1, y+1) if y+1 <= 9 && x-1 >= 0
    flash?(x, y+1) if y+1 <= 9
    flash?(x+1, y+1) if y+1 <= 9 && x+1 <= 9
end

# useful in debugging visually
def display(y = $max_y)
    (0..y).each do |i|
        p $grid[i].join
    end
    p '-' * 10
    (0..y).each do |i|
        p $flashed[i].join
    end
    p '-' * 10
end

main

# 1120 low
# 1925 high
# 1686
