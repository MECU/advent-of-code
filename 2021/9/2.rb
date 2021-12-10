require 'csv'

$data = []
$max_y = 99
$max_x = 99

def load
    CSV.foreach('input.csv') do |row|
        $data << row[0].split('').map(&:to_i)
        $max_x = $data[-1].count - 1 if $data[-1].count - 1 > $max_y
    end
    $max_y = $data.count - 1
end

def main
    load

    valley = []

    (0..$max_x).each do |y|
        (0..$max_y).each do |x|
            size = scanner(x, y)
            next if size.zero?
                        
            valley << size
        end
    end

    three = valley.sort.reverse.take(3)
    p three
    p three.reduce(:*)
end

def scanner(x, y)
    return 0 if x < 0 || y < 0 || x > $max_x || y > $max_y

    value = $data[y][x]
    return 0 if value == 9

    size = 1
    $data[y][x] = 9
    
    size += scanner(x+1, y)
    size += scanner(x-1, y)
    size += scanner(x, y+1)
    size += scanner(x, y-1)

    size
end

# useful in debugging visually
def display(x = $max_x)
    (0..x).each do |i|
        p $data[i].join
    end
    p '-' * 100
end

main

# 865520 (96,96,95) low
# 893952 (97,96,96) low
# 978432 (104,98,96) low
# 1008315 (105,99,97) ?
# 1059300 (107,100,99)
