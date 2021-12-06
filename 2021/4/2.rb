require 'csv'

CALLED_NUMBERS = '26,38,2,15,36,8,12,46,88,72,32,35,64,19,5,66,20,52,74,3,59,94,45,56,0,6,67,24,97,50,92,93,84,65,71,90,96,21,87,75,58,82,14,53,95,27,49,69,16,89,37,13,1,81,60,79,51,18,48,33,42,63,39,34,62,55,47,54,23,83,77,9,70,68,85,86,91,41,4,61,78,31,22,76,40,17,30,98,44,25,80,73,11,28,7,99,29,57,43,10'

class Board
    attr_reader :board
    def initialize(layout)
        @board = []
        @last_called = nil
        parse_layout(layout)
        @winner = false
    end

    def number_called(number)
        @last_called = number
        @board.map! do |row|
            row.map! { |x| x == number ? '*' : x }
        end
    end

    def winner?
        @board.each_with_index do |row, index|
            return true if row.count('*') == 5
            
            column = @board.map do |col|
                col[index] == '*'
            end

            return true if column.count(true) == 5
        end

        false
    end

    def calculate_score
        total = @board.map do |row|
            row.filter{ |num| num.is_a?(Integer) }.sum
        end

        total.sum * @last_called
    end

    private
    def parse_layout(layout)
        layout.each do |row|
            next if row.nil?

            @board << row.split(' ').map(&:to_i)
        end
    end
end

def main
    layout = []
    boards = []

    CSV.foreach('input.csv') do |row|
        if row.empty?
            boards << Board.new(layout)
            layout = []
        end
        layout << row[0]
    end

    winning_board = nil
    number_of_boards = boards.count

    CALLED_NUMBERS.split(',').each do |b|
        boards.each do |board|
            board.number_called(b.to_i)
        end

        winners = boards.reject{ |b| b.winner? }
        if winners.count == 1
            boards = winners
        end

        if boards.count == 1 && boards[0].winner?
            p boards[0].calculate_score
            exit
        end
    end
end

main

# 102836 too high
# 31044 too high
