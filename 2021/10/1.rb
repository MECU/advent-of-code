require 'csv'

PAIRS = {'(' => ')', '[' => ']', '{' => '}', '<' => '>'}
POINTS = {
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137,
}

score = 0

CSV.foreach('input.csv') do |row|
    data = row[0].split('')

    chunk = []

    data.each do |i|
        if PAIRS.keys.include?(i)
            chunk << i
            next
        end

        last = chunk.pop

        if PAIRS[last] == i
            next
        end
p i
p POINTS
p POINTS[i]
        score += POINTS[i]
        break
    end
end

p "score: #{score}"
