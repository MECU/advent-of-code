require 'csv'

def load_coordinates
    board = Array.new(1000) { Array.new(1000, 0) }

    CSV.foreach('input.csv') do |row|
        x1, y1, x2, y2 = row.map(&:to_i)
        
        if x1 == x2
            ya = y1
            yb = y2
            if y1 > y2
                ya = y2
                yb = y1
            end
            
            (ya..yb).each do |y|
                board[x1][y] += 1
            end
        end
        if y1 == y2
            xa = x1
            xb = x2
            if x1 > x2
                xa = x2
                xb = x1
            end
            (xa..xb).each do |x|
                board[x][y1] += 1
            end
        end
    end

    board
end

def calculate(board)
    score = 0

    board.each do |row|
        score += row.filter{ |x| x > 1 }.count
    end

    score
end

def main
    board = load_coordinates
    
    score = calculate(board)

    p "score: #{score}"
end

main

# 1057 low
# 5124
