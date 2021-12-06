require 'csv'

def load_coordinates
    board = Array.new(1000) { Array.new(1000, 0) }

    CSV.foreach('input.csv') do |row|
        x1, y1, x2, y2 = row.map(&:to_i)
        
        if x1 == x2
            # do both because higher point might be first
            (y1..y2).each { |y| board[x1][y] += 1 }
            (y2..y1).each { |y| board[x1][y] += 1 }
        elsif y1 == y2
            # do both because higher point might be first
            (x1..x2).each { |x| board[x][y1] += 1 }
            (x2..x1).each { |x| board[x][y1] += 1 }
        else
            # diagonal
            x_step = 1
            x_step = -1 if x1 > x2
            y_step = 1
            y_step = -1 if y1 > y2

            i = x1
            j = y1
            loop do
                board[i][j] += 1
                i += x_step
                j += y_step
                if i == x2
                    board[i][j] += 1
                    break
                end
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

# > 5124 (part 1)
# 19748 low